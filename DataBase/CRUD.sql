use UniversityDB;

-- ============================================================
-- CREATE — Add a new student mid-semester
-- ============================================================
INSERT INTO Students (FirstName, LastName, DateOfBirth, Gender, Email,
                      Phone, EnrollmentDate, ProgramID, AcademicStatus)
VALUES ('Hassan', 'Idris', '2003-05-10', 'M', 'hassan.idris@univ.edu',
        '011-9991234', '2026-02-15', 1, 'Active');
GO

-- ============================================================
-- READ — Retrieve full student profile with program/department
-- ============================================================
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName           AS FullName,
    DATEDIFF(YEAR, s.DateOfBirth, GETDATE())  AS Age,
    s.Gender,
    p.ProgramName,
    d.DeptName,
    s.EnrollmentDate,
    s.AcademicStatus
FROM Students s
JOIN Programs  p ON s.ProgramID = p.ProgramID
JOIN Departments d ON p.DeptID  = d.DeptID
WHERE s.AcademicStatus = 'Active'
ORDER BY p.ProgramName, s.LastName;
GO

-- ============================================================
-- UPDATE — Change academic status after review board decision
-- ============================================================
UPDATE Students
SET AcademicStatus = 'Active'
WHERE StudentID = 1003
  AND AcademicStatus = 'Suspended';
GO

-- Restore for consistency
UPDATE Students SET AcademicStatus = 'Suspended' WHERE StudentID = 1003;
GO

-- ============================================================
-- UPDATE — Correct a data entry error in a grade record
-- ============================================================
UPDATE Grades
SET MidtermScore  = 72,
    TotalScore    = ROUND(0.3*72 + 0.5*74 + 0.2*76, 2),
    LetterGrade   = 'C',
    GradePoints   = 2.00
WHERE EnrollmentID = 5030;
GO

-- ============================================================
-- DELETE — Remove a withdrawn enrollment (safe deletion)
-- ============================================================
-- Best practice: soft delete first
UPDATE Enrollments SET Status = 'Withdrawn'
WHERE EnrollmentID = 5089;

-- Hard delete only if confirmed and no grade/attendance exists
DELETE FROM Attendance  WHERE EnrollmentID = 5089;
DELETE FROM Grades      WHERE EnrollmentID = 5089;  -- None for active sem
DELETE FROM Enrollments WHERE EnrollmentID = 5089;
GO

-- Restore for query testing
INSERT INTO Enrollments ( StudentID, SectionID, EnrollmentDate, Status)
VALUES ( 1010, 326, '2026-02-01', 'Active');
SET IDENTITY_INSERT Enrollments OFF;
INSERT INTO Attendance (EnrollmentID, TotalClasses, AttendedClasses)
VALUES (5098, 20, 15);
GO