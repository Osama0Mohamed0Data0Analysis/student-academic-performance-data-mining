-- ============================================================
-- QUERY 1: vw_StudentMaster
-- Includes: Age calculation, Academic Status, Program, Dept
-- ============================================================
USE UniversityDB;

CREATE OR ALTER VIEW vw_StudentMaster AS
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName             AS FullName,
    s.Gender,
    s.DateOfBirth,
    DATEDIFF(YEAR, s.DateOfBirth, GETDATE())
    - CASE WHEN (MONTH(s.DateOfBirth) > MONTH(GETDATE()))
           OR   (MONTH(s.DateOfBirth) = MONTH(GETDATE())
            AND  DAY(s.DateOfBirth)   > DAY(GETDATE()))
           THEN 1 ELSE 0 END                    AS Age,
    s.Email,
    s.EnrollmentDate,
    p.ProgramName,
    p.ProgramCode,
    d.DeptName,
    s.AcademicStatus
FROM Students    s
JOIN Programs    p ON s.ProgramID = p.ProgramID
JOIN Departments d ON p.DeptID    = d.DeptID;
GO

-- Usage: List active students ordered by program
SELECT * FROM vw_StudentMaster
WHERE AcademicStatus = 'Active'
ORDER BY ProgramName, FullName;
GO

-- ============================================================
-- QUERY 2: Current Semester Course Load per Student
-- ============================================================
-- Specific student lookup
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName  AS StudentName,
    c.CourseCode,
    c.CourseName,
    c.Credits,
    sec.Schedule,
    sec.Room,
    i.FirstName + ' ' + i.LastName  AS Instructor,
    e.Status
FROM Enrollments  e
JOIN Sections     sec ON e.SectionID    = sec.SectionID
JOIN Courses      c   ON sec.CourseID   = c.CourseID
JOIN Students     s   ON e.StudentID    = s.StudentID
JOIN Instructors  i   ON sec.InstructorID = i.InstructorID
JOIN Semesters    sem ON sec.SemesterID = sem.SemesterID
WHERE sem.IsCurrent = 1
  AND e.StudentID   = 1015   -- Replace with desired StudentID
  AND e.Status      = 'Active';
GO

-- Bonus: View showing all students' current load with credit total
CREATE OR ALTER VIEW vw_CurrentSemesterLoad AS
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName  AS StudentName,
    p.ProgramCode,
    c.CourseCode,
    c.CourseName,
    c.Credits,
    i.FirstName + ' ' + i.LastName  AS Instructor,
    sec.Schedule,
    sec.Room,
    sem.SemesterName + ' ' + CAST(sem.AcademicYear AS VARCHAR) AS CurrentSemester
FROM Enrollments e
JOIN Sections    sec ON e.SectionID      = sec.SectionID
JOIN Courses     c   ON sec.CourseID     = c.CourseID
JOIN Students    s   ON e.StudentID      = s.StudentID
JOIN Programs    p   ON s.ProgramID      = p.ProgramID
JOIN Instructors i   ON sec.InstructorID = i.InstructorID
JOIN Semesters   sem ON sec.SemesterID   = sem.SemesterID
WHERE sem.IsCurrent = 1
  AND e.Status      = 'Active';
GO

SELECT * FROM vw_CurrentSemesterLoad ORDER BY StudentName;
GO

-- ============================================================
-- QUERY 3: Course Enrollment & Capacity Report
-- RemainingSeats = Capacity - EnrolledCount, ascending order
-- ============================================================
SELECT
    c.CourseCode,
    c.CourseName,
    d.DeptName,
    sem.SemesterName + ' ' + CAST(sem.AcademicYear AS VARCHAR) AS Semester,
    i.FirstName + ' ' + i.LastName  AS Instructor,
    sec.Room,
    sec.Capacity,
    sec.EnrolledCount,
    (sec.Capacity - sec.EnrolledCount)            AS RemainingSeats,
    CAST(sec.EnrolledCount * 100.0
         / sec.Capacity AS DECIMAL(5,1))          AS OccupancyPct,
    CASE
        WHEN (sec.Capacity - sec.EnrolledCount) = 0 THEN 'FULL'
        WHEN (sec.Capacity - sec.EnrolledCount) <= 5 THEN 'ALMOST FULL'
        ELSE 'AVAILABLE'
    END                                           AS CapacityStatus
FROM Sections    sec
JOIN Courses     c   ON sec.CourseID     = c.CourseID
JOIN Departments d   ON c.DeptID         = d.DeptID
JOIN Semesters   sem ON sec.SemesterID   = sem.SemesterID
JOIN Instructors i   ON sec.InstructorID = i.InstructorID
ORDER BY RemainingSeats ASC;
GO

-- ============================================================
-- QUERY 4: vw_SemesterGPA
-- Grade points: A=4, B=3, C=2, D=1, F=0
-- Weighted by credit hours per course
-- ============================================================
CREATE OR ALTER VIEW vw_SemesterGPA AS
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName          AS StudentName,
    p.ProgramCode,
    sem.SemesterID,
    sem.SemesterName + ' ' + CAST(sem.AcademicYear AS VARCHAR) AS SemesterLabel,
    SUM(c.Credits)                           AS TotalCredits,
    SUM(g.GradePoints * c.Credits)           AS QualityPoints,
    CAST(
        SUM(g.GradePoints * c.Credits) * 1.0
        / NULLIF(SUM(c.Credits), 0)
    AS DECIMAL(4,2))                         AS SemesterGPA,
    COUNT(CASE WHEN g.LetterGrade = 'F'
               THEN 1 END)                   AS CoursesFailedThisSem,
    SUM(CASE WHEN g.LetterGrade = 'F'
             THEN c.Credits ELSE 0 END)      AS FailedCreditsThisSem
FROM Enrollments  e
JOIN Sections     sec ON e.SectionID    = sec.SectionID
JOIN Courses      c   ON sec.CourseID   = c.CourseID
JOIN Students     s   ON e.StudentID    = s.StudentID
JOIN Programs     p   ON s.ProgramID    = p.ProgramID
JOIN Semesters    sem ON sec.SemesterID = sem.SemesterID
JOIN Grades       g   ON e.EnrollmentID = g.EnrollmentID
WHERE e.Status = 'Completed'
GROUP BY
    s.StudentID, s.FirstName, s.LastName,
    p.ProgramCode, sem.SemesterID,
    sem.SemesterName, sem.AcademicYear;
GO

SELECT * FROM vw_SemesterGPA ORDER BY StudentName, SemesterID;
GO

-- ============================================================
-- QUERY 5: Cumulative GPA (CGPA) — Top 20 Students
-- ============================================================
WITH CGPA_CTE AS (
    SELECT
        s.StudentID,
        s.FirstName + ' ' + s.LastName          AS StudentName,
        p.ProgramName,
        d.DeptName,
        COUNT(DISTINCT e.EnrollmentID)           AS TotalCoursesCompleted,
        SUM(c.Credits)                           AS TotalCreditsEarned,
        SUM(g.GradePoints * c.Credits)           AS TotalQualityPoints,
        CAST(
            SUM(g.GradePoints * c.Credits) * 1.0
            / NULLIF(SUM(c.Credits), 0)
        AS DECIMAL(4,2))                         AS CGPA
    FROM Enrollments  e
    JOIN Sections     sec ON e.SectionID    = sec.SectionID
    JOIN Courses      c   ON sec.CourseID   = c.CourseID
    JOIN Students     s   ON e.StudentID    = s.StudentID
    JOIN Programs     p   ON s.ProgramID    = p.ProgramID
    JOIN Departments  d   ON p.DeptID       = d.DeptID
    JOIN Grades       g   ON e.EnrollmentID = g.EnrollmentID
    WHERE e.Status = 'Completed'
    GROUP BY s.StudentID, s.FirstName, s.LastName,
             p.ProgramName, d.DeptName
)
SELECT TOP 20
    RANK() OVER (ORDER BY CGPA DESC, TotalCreditsEarned DESC) AS [Rank],
    StudentID, StudentName, ProgramName, DeptName,
    TotalCoursesCompleted, TotalCreditsEarned,
    TotalQualityPoints, CGPA,
    CASE
        WHEN CGPA >= 3.50 THEN 'Dean''s List'
        WHEN CGPA >= 3.00 THEN 'Good Standing'
        WHEN CGPA >= 2.00 THEN 'Satisfactory'
        ELSE 'Academic Probation'
    END AS AcademicStanding
FROM CGPA_CTE
ORDER BY CGPA DESC, TotalCreditsEarned DESC;
GO

-- ============================================================
-- QUERY 6: At-Risk Students
-- Condition 1: Last semester GPA < 2.0
-- Condition 2: Failed credits >= 6 in last completed semester
-- ============================================================
WITH LastSemPerStudent AS (
    -- Find the most recent completed semester for each student
    SELECT
        e.StudentID,
        MAX(sec.SemesterID) AS LastSemID
    FROM Enrollments e
    JOIN Sections    sec ON e.SectionID = sec.SectionID
    WHERE e.Status = 'Completed'
    GROUP BY e.StudentID
),
LastSemGPA AS (
    -- Calculate GPA and failed credits in that last semester only
    SELECT
        ls.StudentID,
        ls.LastSemID,
        sem.SemesterName + ' ' + CAST(sem.AcademicYear AS VARCHAR) AS LastSemLabel,
        CAST(
            SUM(g.GradePoints * c.Credits) * 1.0
            / NULLIF(SUM(c.Credits), 0)
        AS DECIMAL(4,2))                                         AS LastSemGPA,
        SUM(CASE WHEN g.LetterGrade = 'F'
                 THEN c.Credits ELSE 0 END)                      AS FailedCredits
    FROM LastSemPerStudent ls
    JOIN Enrollments e   ON ls.StudentID  = e.StudentID
    JOIN Sections   sec  ON e.SectionID   = sec.SectionID
    JOIN Semesters  sem  ON sec.SemesterID = sem.SemesterID
    JOIN Courses    c    ON sec.CourseID   = c.CourseID
    JOIN Grades     g    ON e.EnrollmentID = g.EnrollmentID
    WHERE sec.SemesterID = ls.LastSemID
      AND e.Status       = 'Completed'
    GROUP BY ls.StudentID, ls.LastSemID, sem.SemesterName, sem.AcademicYear
)
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName  AS StudentName,
    p.ProgramName,
    lg.LastSemLabel,
    lg.LastSemGPA,
    lg.FailedCredits,
    s.AcademicStatus,
    CASE
        WHEN lg.LastSemGPA < 2.0 AND lg.FailedCredits >= 6
             THEN 'CRITICAL — Low GPA & Multiple Failures'
        WHEN lg.LastSemGPA < 2.0
             THEN 'AT RISK — Low Semester GPA'
        WHEN lg.FailedCredits >= 6
             THEN 'AT RISK — Excessive Failed Credits'
    END AS RiskCategory
FROM LastSemGPA  lg
JOIN Students    s ON lg.StudentID  = s.StudentID
JOIN Programs    p ON s.ProgramID   = p.ProgramID
WHERE lg.LastSemGPA < 2.0
   OR lg.FailedCredits >= 6
ORDER BY lg.LastSemGPA ASC;
GO

-- ============================================================
-- QUERY 7: Prerequisite Violation Report
-- Students enrolled in a course without passing its prerequisite
-- ============================================================
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName            AS StudentName,
    p.ProgramCode,
    enrolled_c.CourseCode                      AS EnrolledCourse,
    enrolled_c.CourseName                      AS EnrolledCourseName,
    prereq_c.CourseCode                        AS RequiredPrerequisite,
    prereq_c.CourseName                        AS PrerequisiteCourseName,
    sem.SemesterName + ' '
    + CAST(sem.AcademicYear AS VARCHAR)        AS ViolationSemester,
    ISNULL(
        CAST(prev_g.LetterGrade AS VARCHAR),
        'NEVER ENROLLED'
    )                                          AS PrerequisiteStatus,
    e.Status                                   AS CurrentEnrollmentStatus
FROM Enrollments       e
JOIN Sections          sec      ON e.SectionID         = sec.SectionID
JOIN Courses           enrolled_c ON sec.CourseID      = enrolled_c.CourseID
JOIN Semesters         sem      ON sec.SemesterID       = sem.SemesterID
JOIN Students          s        ON e.StudentID          = s.StudentID
JOIN Programs          p        ON s.ProgramID          = p.ProgramID
JOIN CoursePrerequisites cp     ON enrolled_c.CourseID  = cp.CourseID
JOIN Courses           prereq_c ON cp.PrerequisiteCourseID = prereq_c.CourseID
-- Check: Has this student ever PASSED the prerequisite before this enrollment?
LEFT JOIN (
    SELECT
        e2.StudentID,
        sec2.CourseID,
        g2.LetterGrade,
        sec2.SemesterID
    FROM Enrollments e2
    JOIN Sections    sec2 ON e2.SectionID    = sec2.SectionID
    JOIN Grades      g2   ON e2.EnrollmentID = g2.EnrollmentID
    WHERE g2.LetterGrade <> 'F'   -- Only passing records
      AND e2.Status = 'Completed'
) prev_g ON s.StudentID           = prev_g.StudentID
        AND cp.PrerequisiteCourseID = prev_g.CourseID
        AND prev_g.SemesterID       < sec.SemesterID  -- Must be BEFORE enrollment
WHERE prev_g.StudentID IS NULL    -- No passing record found
ORDER BY ViolationSemester, StudentName;
GO

-- ============================================================
-- QUERY 8: Course Pass Rate by Department
-- PassRate% = (Passed / Total_Completed) * 100
-- ============================================================
SELECT
    d.DeptName                                              AS Department,
    c.CourseCode,
    c.CourseName,
    COUNT(g.GradeID)                                        AS TotalStudents,
    SUM(CASE WHEN g.LetterGrade <> 'F' THEN 1 ELSE 0 END)  AS PassedStudents,
    SUM(CASE WHEN g.LetterGrade =  'F' THEN 1 ELSE 0 END)  AS FailedStudents,
    CAST(
        SUM(CASE WHEN g.LetterGrade <> 'F' THEN 1.0 ELSE 0 END)
        / NULLIF(COUNT(g.GradeID), 0) * 100
    AS DECIMAL(5,1))                                        AS PassRatePct,
    CAST(AVG(g.TotalScore) AS DECIMAL(5,2))                 AS AvgScore,
    CAST(AVG(g.GradePoints) AS DECIMAL(4,2))                AS AvgGradePoints
FROM Grades      g
JOIN Enrollments e   ON g.EnrollmentID = e.EnrollmentID
JOIN Sections    sec ON e.SectionID    = sec.SectionID
JOIN Courses     c   ON sec.CourseID   = c.CourseID
JOIN Departments d   ON c.DeptID       = d.DeptID
WHERE e.Status = 'Completed'
GROUP BY d.DeptName, c.CourseCode, c.CourseName
ORDER BY d.DeptName, PassRatePct ASC;
GO

-- ============================================================
-- QUERY 9: vw_InstructorPerformance
-- Shows workload, average grade, and fail rate per instructor
-- ============================================================
CREATE OR ALTER VIEW vw_InstructorPerformance AS
SELECT
    i.InstructorID,
    i.FirstName + ' ' + i.LastName         AS InstructorName,
    i.Rank,
    d.DeptName,
    i.Specialization,
    COUNT(DISTINCT sec.SectionID)           AS TotalSectionsTaught,
    COUNT(DISTINCT
        CASE WHEN sem.IsCurrent = 1
             THEN sec.SectionID END)        AS CurrentSemesterSections,
    COUNT(g.GradeID)                        AS TotalStudentsGraded,
    CAST(AVG(g.TotalScore)    AS DECIMAL(5,2)) AS AvgStudentScore,
    CAST(AVG(g.GradePoints)   AS DECIMAL(4,2)) AS AvgGradePoints,
    SUM(CASE WHEN g.LetterGrade = 'A' THEN 1 ELSE 0 END) AS CountA,
    SUM(CASE WHEN g.LetterGrade = 'B' THEN 1 ELSE 0 END) AS CountB,
    SUM(CASE WHEN g.LetterGrade = 'C' THEN 1 ELSE 0 END) AS CountC,
    SUM(CASE WHEN g.LetterGrade = 'D' THEN 1 ELSE 0 END) AS CountD,
    SUM(CASE WHEN g.LetterGrade = 'F' THEN 1 ELSE 0 END) AS CountF,
    CAST(
        SUM(CASE WHEN g.LetterGrade = 'F' THEN 1.0 ELSE 0 END)
        / NULLIF(COUNT(g.GradeID), 0) * 100
    AS DECIMAL(5,1))                        AS FailRatePct
FROM Instructors  i
JOIN Departments  d   ON i.DeptID         = d.DeptID
JOIN Sections     sec ON i.InstructorID   = sec.InstructorID
JOIN Semesters    sem ON sec.SemesterID   = sem.SemesterID
LEFT JOIN Enrollments e ON sec.SectionID  = e.SectionID
                       AND e.Status       = 'Completed'
LEFT JOIN Grades  g   ON e.EnrollmentID   = g.EnrollmentID
GROUP BY
    i.InstructorID, i.FirstName, i.LastName,
    i.Rank, d.DeptName, i.Specialization;
GO

SELECT * FROM vw_InstructorPerformance
ORDER BY FailRatePct DESC, AvgStudentScore DESC;
GO

-- ============================================================
-- QUERY 10: Attendance Analytics — Finals Ineligibility Report
-- Students with AttendancePercentage < 75% in ANY semester
-- ============================================================
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName             AS StudentName,
    p.ProgramCode,
    c.CourseCode,
    c.CourseName,
    sem.SemesterName + ' '
    + CAST(sem.AcademicYear AS VARCHAR)         AS Semester,
    CASE WHEN sem.IsCurrent = 1
         THEN 'CURRENT' ELSE 'HISTORICAL' END   AS SemesterType,
    a.TotalClasses,
    a.AttendedClasses,
    CAST(a.AttendancePercentage AS DECIMAL(5,1)) AS AttendancePct,
    (a.TotalClasses - a.AttendedClasses)         AS ClassesMissed,
    CASE
        WHEN sem.IsCurrent = 1
        THEN 'INELIGIBLE FOR FINALS — Action Required'
        ELSE 'Was Ineligible — Historical Record'
    END                                          AS FinalEligibilityStatus,
    s.AcademicStatus
FROM Attendance   a
JOIN Enrollments  e   ON a.EnrollmentID  = e.EnrollmentID
JOIN Sections     sec ON e.SectionID     = sec.SectionID
JOIN Semesters    sem ON sec.SemesterID  = sem.SemesterID
JOIN Courses      c   ON sec.CourseID    = c.CourseID
JOIN Students     s   ON e.StudentID     = s.StudentID
JOIN Programs     p   ON s.ProgramID     = p.ProgramID
WHERE a.AttendancePercentage < 75
ORDER BY sem.IsCurrent DESC,
         a.AttendancePercentage ASC,
         StudentName;
GO