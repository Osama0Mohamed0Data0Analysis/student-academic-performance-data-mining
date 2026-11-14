-- ============================================================
-- 1 SEED DATA: DEPARTMENTS (DeptID 1-5)
-- ============================================================

USE UniversityDB;

INSERT INTO Departments (DeptName, DeptCode, Dean, Location, Phone, EstablishedYear) VALUES
('Computer Science',        'CS',  'Dr. Ahmad Yusof',  'Block A', '03-11110001', 1985),
('Business Administration', 'BA',  'Dr. Sarah Tan',    'Block B', '03-11110002', 1990),
('Engineering',             'ENG', 'Dr. Raj Kumar',    'Block C', '03-11110003', 1980),
('Mathematics',             'MTH', 'Dr. Lee Wei',      'Block D', '03-11110004', 1975),
('Information Technology',  'IT',  'Dr. Nurul Ain',    'Block E', '03-11110005', 2000),
('English',                 'EN', 'Dr. Jane Doe',      'Block F', '03-11110006', 1970);
GO

-- ============================================================
-- 2 SEED DATA: PROGRAMS (ProgramID 1-6)
-- ============================================================
INSERT INTO Programs (ProgramName, ProgramCode, DeptID, TotalCredits, DurationYears, DegreeLevel) VALUES
('B.Sc. Computer Science',       'BSCS',  1, 120, 4, 'Bachelor'),
('B.Sc. Information Technology', 'BSIT',  5, 120, 4, 'Bachelor'),
('B.Sc. Software Engineering',   'BSSE',  3, 130, 4, 'Bachelor'),
('B.B.A. Business Administration','BBA',  2, 120, 4, 'Bachelor'),
('B.Sc. Mathematics',            'BSMTH', 4, 120, 4, 'Bachelor'),
('M.Sc. Computer Science',       'MSCS',  1,  42, 2, 'Master');
GO

-- ============================================================
-- 3 SEED DATA: INSTRUCTORS (InstructorID 100-109)
-- ============================================================
INSERT INTO Instructors (FirstName, LastName, Email, DeptID, Rank, HireDate, Phone, Specialization) VALUES
('Ahmad',    'Yusof',  'ahmad.yusof@univ.edu',  1, 'Professor',             '2005-01-15', '012-1111111', 'Artificial Intelligence'),
('Sarah',    'Tan',    'sarah.tan@univ.edu',     2, 'Associate Professor',   '2008-03-20', '012-2222222', 'Finance'),
('Raj',      'Kumar',  'raj.kumar@univ.edu',     3, 'Professor',             '2003-06-01', '012-3333333', 'Systems Engineering'),
('Lee',      'Wei',    'lee.wei@univ.edu',       4, 'Assistant Professor',   '2015-08-10', '012-4444444', 'Statistics'),
('Nurul',    'Ain',    'nurul.ain@univ.edu',     5, 'Lecturer',              '2018-01-05', '012-5555555', 'Networking'),
('David',    'Lim',    'david.lim@univ.edu',     1, 'Associate Professor',   '2010-07-20', '012-6666666', 'Database Systems'),
('Priya',    'Nair',   'priya.nair@univ.edu',    1, 'Lecturer',              '2019-09-01', '012-7777777', 'Software Engineering'),
('Hassan',   'Omar',   'hassan.omar@univ.edu',   2, 'Assistant Professor',   '2016-02-14', '012-8888888', 'Marketing'),
('Chen',     'Li',     'chen.li@univ.edu',       4, 'Associate Professor',   '2011-05-30', '012-9999999', 'Applied Mathematics'),
('Fatimah',  'Zahra',  'fatimah.zahra@univ.edu', 5, 'Lecturer',              '2020-01-10', '012-0000000', 'Cybersecurity');
GO

-- ============================================================
-- 4 SEED DATA: COURSES (CourseID 200-219)
-- ============================================================
INSERT INTO Courses (CourseCode, CourseName, Credits, DeptID, CourseLevel) VALUES
-- CS Dept (DeptID=1)
('CS101', 'Introduction to Programming',     3, 1, 100),  -- CourseID 200
('CS201', 'Data Structures & Algorithms',    3, 1, 200),  -- CourseID 201
('CS301', 'Database Systems',                3, 1, 300),  -- CourseID 202
('CS401', 'Artificial Intelligence',         3, 1, 400),  -- CourseID 203
('CS202', 'Object-Oriented Programming',     3, 1, 200),  -- CourseID 204
-- IT Dept (DeptID=5)
('IT101', 'Computer Fundamentals',           3, 5, 100),  -- CourseID 205
('IT201', 'Computer Networks',               3, 5, 200),  -- CourseID 206
('IT301', 'Cybersecurity Fundamentals',      3, 5, 300),  -- CourseID 207
('IT202', 'Web Development',                 3, 5, 200),  -- CourseID 208
-- Business Dept (DeptID=2)
('BA101', 'Principles of Management',        3, 2, 100),  -- CourseID 209
('BA201', 'Business Statistics',             3, 2, 200),  -- CourseID 210
('BA301', 'Financial Management',            3, 2, 300),  -- CourseID 211
('BA202', 'Marketing Management',            3, 2, 200),  -- CourseID 212
-- Engineering Dept (DeptID=3)
('ENG101','Engineering Mathematics I',       3, 3, 100),  -- CourseID 213
('ENG201','Engineering Mathematics II',      3, 3, 200),  -- CourseID 214
('ENG301','Systems Engineering',             3, 3, 300),  -- CourseID 215
-- Math Dept (DeptID=4)
('MTH101','Calculus I',                      3, 4, 100),  -- CourseID 216
('MTH201', 'Calculus II',              3, 4, 200),   -- CourseID 217
('MTH301', 'Linear Algebra',           3, 4, 300),   -- CourseID 218
--- English Dept (DeptID=6) - No courses yet
('ENGL101', 'English Composition', 3, 6, 100); -- CourseID 219
GO	
-- ============================================================
-- 5 SEED DATA: COURSE PREREQUISITES 
-- COURSE PREREQUISITES (14 Relationships)
-- CourseID Reference Map:
-- CS101=200, CS201=201, CS301=202, CS401=203, CS202=204
-- IT101=205, IT201=206, IT301=207, IT202=208
-- BA101=209, BA201=210, BA301=211, BA202=212
-- ENG101=213, ENG201=214, ENG301=215
-- MTH101=216, MTH201=217, MTH301=218
-- ============================================================
INSERT INTO CoursePrerequisites (CourseID, PrerequisiteCourseID) VALUES
(201, 200),   -- CS201 requires CS101
(202, 201),   -- CS301 requires CS201
(203, 202),   -- CS401 requires CS301
(204, 200),   -- CS202 requires CS101
(206, 205),   -- IT201 requires IT101
(207, 206),   -- IT301 requires IT201
(208, 205),   -- IT202 requires IT101
(210, 209),   -- BA201 requires BA101
(211, 210),   -- BA301 requires BA201
(212, 209),   -- BA202 requires BA101
(214, 213),   -- ENG201 requires ENG101
(215, 214),   -- ENG301 requires ENG201
(217, 216),   -- MTH201 requires MTH101
(218, 217);   -- MTH301 requires MTH201
GO
-- ============================================================
-- 6 SEMESTERS (SemesterID 1-5; Spring 2026 = Current)
-- ============================================================
INSERT INTO Semesters (SemesterName, AcademicYear, StartDate, EndDate, IsCurrent) VALUES
('Fall',   2023, '2023-09-01', '2024-01-31', 0),  -- SemesterID 1
('Spring', 2024, '2024-02-01', '2024-06-30', 0),  -- SemesterID 2
('Fall',   2024, '2024-09-01', '2025-01-31', 0),  -- SemesterID 3
('Spring', 2025, '2025-02-01', '2025-06-30', 0),  -- SemesterID 4
('Fall',   2025, '2025-09-01', '2026-01-31', 0),   -- SemesterID 5
('Spring', 2026, '2026-02-01', '2026-06-30', 1);  -- SemesterID 6 (CURRENT)
GO
-- ============================================================
-- 7 
-- STUDENTS (StudentID 1000-1024, 25 students)
-- Diversity: 5 programs, both genders, mixed academic status
-- Key cases: 1003=Suspended(failed), 1007=At-Risk(violations)
-- ============================================================
INSERT INTO Students (FirstName, LastName, DateOfBirth, Gender, Email, Phone,
                      EnrollmentDate, ProgramID, AcademicStatus) VALUES
('Ali',     'Hassan',   '2001-03-15', 'M', 'ali.hassan@univ.edu',     '011-1001001', '2023-09-01', 1, 'Active'),     -- 1000 BSCS
('Maria',   'Santos',   '2002-07-22', 'F', 'maria.santos@univ.edu',   '011-1001002', '2023-09-01', 5, 'Active'),     -- 1001 BSIT
('Kevin',   'Lim',      '2001-11-05', 'M', 'kevin.lim@univ.edu',      '011-1001003', '2023-09-01', 5, 'Active'),     -- 1002 BSIT
('Ravi',    'Patel',    '2000-08-30', 'M', 'ravi.patel@univ.edu',     '011-1001004', '2023-09-01', 1, 'Suspended'),  -- 1003 BSCS (At-Risk)
('Emily',   'Wong',     '2002-04-18', 'F', 'emily.wong@univ.edu',     '011-1001005', '2023-09-01', 1, 'Active'),     -- 1004 BSCS
('James',   'Okafor',   '2001-09-12', 'M', 'james.okafor@univ.edu',   '011-1001006', '2023-09-01', 4, 'Active'),     -- 1005 BBA
('Fatima',  'Ali',      '2003-01-25', 'F', 'fatima.ali@univ.edu',     '011-1001007', '2023-09-01', 1, 'Active'),     -- 1006 BSCS
('Daniel',  'Park',     '2002-06-08', 'M', 'daniel.park@univ.edu',    '011-1001008', '2023-09-01', 5, 'Active'),     -- 1007 BSIT (Violation)
('Sarah',   'Ng',       '2001-12-14', 'F', 'sarah.ng@univ.edu',       '011-1001009', '2023-09-01', 4, 'Active'),     -- 1008 BBA
('Omar',    'Hassan',   '2000-05-27', 'M', 'omar.hassan@univ.edu',    '011-1001010', '2023-09-01', 1, 'Active'),     -- 1009 BSCS
('Zara',    'Khan',     '2003-03-19', 'F', 'zara.khan@univ.edu',      '011-1001011', '2023-09-01', 1, 'Active'),     -- 1010 BSCS
('Michael', 'Tan',      '2001-08-03', 'M', 'michael.tan@univ.edu',    '011-1001012', '2023-09-01', 5, 'Active'),     -- 1011 BSIT
('Aisha',   'Yusuf',    '2002-11-28', 'F', 'aisha.yusuf@univ.edu',    '011-1001013', '2023-09-01', 4, 'Active'),     -- 1012 BBA
('David',   'Chin',     '2000-02-14', 'M', 'david.chin@univ.edu',     '011-1001014', '2023-09-01', 1, 'Active'),     -- 1013 BSCS
('Lily',    'Wong',     '2003-07-06', 'F', 'lily.wong@univ.edu',      '011-1001015', '2023-09-01', 4, 'Active'),     -- 1014 BBA
('Ryan',    'Lee',      '2002-09-21', 'M', 'ryan.lee@univ.edu',       '011-1001016', '2023-09-01', 1, 'Active'),     -- 1015 BSCS
('Nadia',   'Ahmad',    '2001-04-17', 'F', 'nadia.ahmad@univ.edu',    '011-1001017', '2023-09-01', 5, 'Active'),     -- 1016 BSIT (Low Attend)
('Tom',     'Brown',    '2000-10-09', 'M', 'tom.brown@univ.edu',      '011-1001018', '2023-09-01', 3, 'Active'),     -- 1017 BSSE
('Siti',    'Rahimah',  '2002-12-31', 'F', 'siti.rahimah@univ.edu',   '011-1001019', '2023-09-01', 3, 'Active'),     -- 1018 BSSE
('Carlos',  'Rivera',   '2001-06-15', 'M', 'carlos.rivera@univ.edu',  '011-1001020', '2023-09-01', 4, 'Active'),     -- 1019 BBA
('Priya',   'Sharma',   '2003-02-28', 'F', 'priya.sharma@univ.edu',   '011-1001021', '2023-09-01', 5, 'Active'),     -- 1020 BSIT
('Jake',    'Wilson',   '2002-05-11', 'M', 'jake.wilson@univ.edu',    '011-1001022', '2023-09-01', 1, 'Active'),     -- 1021 BSCS (F→Retook)
('Lin',     'Mei',      '2001-03-22', 'F', 'lin.mei@univ.edu',        '011-1001023', '2023-09-01', 2, 'Active'),     -- 1022 BSMTH
('Ahmed',   'Malik',    '2000-11-18', 'M', 'ahmed.malik@univ.edu',    '011-1001024', '2023-09-01', 4, 'Graduated'),  -- 1023 BBA
('Nina',    'Petrov',   '2003-08-04', 'F', 'nina.petrov@univ.edu',    '011-1001025', '2023-09-01', 1, 'Active');     -- 1024 BSCS
GO
-- ============================================================
-- 8
-- SECTIONS (SectionID 300-326, 27 sections across 5 semesters)
-- EnrolledCount set to reflect actual enrollments inserted below
-- InstructorID: Ahmad=100,Sarah=101,Raj=102,Lee=103,Nurul=104
--               David=105,Priya=106,Hassan=107,Chen=108,Fatimah=109
-- ============================================================

-- FALL 2023 (SemesterID=1) — Foundational Courses
INSERT INTO Sections (CourseID, InstructorID, SemesterID, Capacity, EnrolledCount, Room, Schedule) VALUES
(200, 100, 1, 35, 10, 'A101', 'Mon/Wed 08:00-09:30'),  -- 300: CS101
(205, 104, 1, 30,  6, 'E201', 'Tue/Thu 08:00-09:30'),  -- 301: IT101
(209, 101, 1, 40,  6, 'B101', 'Mon/Wed 10:00-11:30'),  -- 302: BA101
(213, 102, 1, 35,  2, 'C101', 'Tue/Thu 10:00-11:30'),  -- 303: ENG101
(216, 103, 1, 30,  1, 'D101', 'Fri 08:00-11:00');      -- 304: MTH101

-- SPRING 2024 (SemesterID=2) — Intermediate Courses
INSERT INTO Sections (CourseID, InstructorID, SemesterID, Capacity, EnrolledCount, Room, Schedule) VALUES
(201, 100, 2, 30,  7, 'A102', 'Mon/Wed 08:00-09:30'),  -- 305: CS201
(204, 105, 2, 30,  2, 'A103', 'Tue/Thu 08:00-09:30'),  -- 306: CS202
(206, 104, 2, 30,  6, 'E202', 'Mon/Wed 10:00-11:30'),  -- 307: IT201
(208, 109, 2, 30,  0, 'E203', 'Tue/Thu 10:00-11:30'),  -- 308: IT202 (no enrollments)
(210, 107, 2, 35,  6, 'B102', 'Mon/Wed 14:00-15:30'),  -- 309: BA201
(214, 102, 2, 30,  2, 'C102', 'Tue/Thu 14:00-15:30'),  -- 310: ENG201
(217, 108, 2, 25,  1, 'D102', 'Fri 08:00-11:00');      -- 311: MTH201

-- FALL 2024 (SemesterID=3) — Advanced Courses + Violations
INSERT INTO Sections (CourseID, InstructorID, SemesterID, Capacity, EnrolledCount, Room, Schedule) VALUES
(202, 105, 3, 30,  6, 'A201', 'Mon/Wed 08:00-09:30'),  -- 312: CS301
(204, 106, 3, 30,  3, 'A202', 'Tue/Thu 08:00-09:30'),  -- 313: CS202 (retake section)
(207, 104, 3, 25,  5, 'E301', 'Mon/Wed 10:00-11:30'),  -- 314: IT301
(211, 101, 3, 30,  4, 'B201', 'Tue/Thu 10:00-11:30'),  -- 315: BA301
(212, 107, 3, 30,  2, 'B202', 'Mon/Wed 14:00-15:30'),  -- 316: BA202
(218, 108, 3, 25,  1, 'D201', 'Fri 08:00-11:00');      -- 317: MTH301

-- SPRING 2025 (SemesterID=4) — Upper Level
INSERT INTO Sections (CourseID, InstructorID, SemesterID, Capacity, EnrolledCount, Room, Schedule) VALUES
(203, 100, 4, 25,  4, 'A301', 'Mon/Wed 08:00-09:30'),  -- 318: CS401
(202, 105, 4, 25,  2, 'A302', 'Tue/Thu 08:00-09:30'),  -- 319: CS301
(208, 109, 4, 30,  2, 'E401', 'Mon/Wed 10:00-11:30'),  -- 320: IT202
(212, 107, 4, 30,  2, 'B301', 'Tue/Thu 10:00-11:30'),  -- 321: BA202
(215, 102, 4, 25,  2, 'C301', 'Mon/Wed 14:00-15:30');  -- 322: ENG301

-- FALL 2025 (SemesterID=5) 
INSERT INTO Sections (CourseID, InstructorID, SemesterID, Capacity, EnrolledCount, Room, Schedule) VALUES
(203, 100, 5, 25, 2, 'A305', 'Mon/Wed 08:00-09:30'),  -- 323: CS401 (AI)
(207, 104, 5, 25, 2, 'E405', 'Tue/Thu 08:00-09:30'),  -- 324: IT301 (Cybersecurity)
(211, 101, 5, 30, 2, 'B305', 'Mon/Wed 10:00-11:30'),  -- 325: BA301 (Financial Mgmt)
(202, 105, 5, 25, 2, 'A306', 'Tue/Thu 08:00-09:30');  -- 326: CS301 (Database - for stragglers)

-- SPRING 2026 (SemesterID=6, CURRENT)
INSERT INTO Sections (CourseID, InstructorID, SemesterID, Capacity, EnrolledCount, Room, Schedule) VALUES
(203, 100, 6, 25,  2, 'A401', 'Mon/Wed 08:00-09:30'),  -- 323: CS401
(207, 104, 6, 25,  2, 'E501', 'Tue/Thu 08:00-09:30'),  -- 324: IT301
(211, 101, 6, 30,  2, 'B401', 'Mon/Wed 10:00-11:30'),  -- 325: BA301
(201, 100, 6, 30,  2, 'A402', 'Tue/Thu 10:00-11:30');  -- 326: CS201
GO

-- ============================================================
-- 9 ENROLLMENTS (EnrollmentID 5000-5089, 90 total)
-- Status: 'Completed' for semesters 1-4, 'Active' for semester 5
-- ============================================================

-- FALL 2023: Sections 300-304 (25 enrollments: 5000-5024)
INSERT INTO Enrollments (StudentID, SectionID, EnrollmentDate, Status) VALUES
-- CS101 (Sec 300): 10 CS students
(1000, 300, '2023-09-01', 'Completed'),  -- 5000
(1003, 300, '2023-09-01', 'Completed'),  -- 5001 Ravi: will FAIL (F)
(1004, 300, '2023-09-01', 'Completed'),  -- 5002
(1006, 300, '2023-09-01', 'Completed'),  -- 5003
(1009, 300, '2023-09-01', 'Completed'),  -- 5004
(1010, 300, '2023-09-01', 'Completed'),  -- 5005
(1013, 300, '2023-09-01', 'Completed'),  -- 5006
(1015, 300, '2023-09-01', 'Completed'),  -- 5007
(1021, 300, '2023-09-01', 'Completed'),  -- 5008
(1024, 300, '2023-09-01', 'Completed'),  -- 5009
-- IT101 (Sec 301): 6 IT students
(1001, 301, '2023-09-01', 'Completed'),  -- 5010
(1002, 301, '2023-09-01', 'Completed'),  -- 5011
(1007, 301, '2023-09-01', 'Completed'),  -- 5012
(1011, 301, '2023-09-01', 'Completed'),  -- 5013
(1016, 301, '2023-09-01', 'Completed'),  -- 5014
(1020, 301, '2023-09-01', 'Completed'),  -- 5015
-- BA101 (Sec 302): 6 Business students
(1005, 302, '2023-09-01', 'Completed'),  -- 5016
(1008, 302, '2023-09-01', 'Completed'),  -- 5017
(1012, 302, '2023-09-01', 'Completed'),  -- 5018
(1014, 302, '2023-09-01', 'Completed'),  -- 5019
(1019, 302, '2023-09-01', 'Completed'),  -- 5020
(1023, 302, '2023-09-01', 'Completed'),  -- 5021
-- ENG101 (Sec 303): 2 Engineering students
(1017, 303, '2023-09-01', 'Completed'),  -- 5022
(1018, 303, '2023-09-01', 'Completed'),  -- 5023
-- MTH101 (Sec 304): 1 Math student
(1022, 304, '2023-09-01', 'Completed');  -- 5024
GO

-- SPRING 2024: Sections 305-311 (24 enrollments: 5025-5048)
INSERT INTO Enrollments (StudentID, SectionID, EnrollmentDate, Status) VALUES
-- CS201 (Sec 305): Students who passed CS101 (except 1003 who failed)
(1000, 305, '2024-02-01', 'Completed'),  -- 5025
(1004, 305, '2024-02-01', 'Completed'),  -- 5026
(1006, 305, '2024-02-01', 'Completed'),  -- 5027
(1009, 305, '2024-02-01', 'Completed'),  -- 5028
(1013, 305, '2024-02-01', 'Completed'),  -- 5029
(1015, 305, '2024-02-01', 'Completed'),  -- 5030
(1024, 305, '2024-02-01', 'Completed'),  -- 5031
-- CS202 (Sec 306): Alternative to CS201 (also needs CS101)
(1010, 306, '2024-02-01', 'Completed'),  -- 5032
(1021, 306, '2024-02-01', 'Completed'),  -- 5033 Jake: will FAIL
-- IT201 (Sec 307): All IT students (all passed IT101)
(1001, 307, '2024-02-01', 'Completed'),  -- 5034
(1002, 307, '2024-02-01', 'Completed'),  -- 5035
(1007, 307, '2024-02-01', 'Completed'),  -- 5036 Daniel: will FAIL (sets up violation)
(1011, 307, '2024-02-01', 'Completed'),  -- 5037
(1016, 307, '2024-02-01', 'Completed'),  -- 5038 Nadia: D grade
(1020, 307, '2024-02-01', 'Completed'),  -- 5039
-- BA201 (Sec 309): Business students (all passed BA101)
(1005, 309, '2024-02-01', 'Completed'),  -- 5040
(1008, 309, '2024-02-01', 'Completed'),  -- 5041
(1012, 309, '2024-02-01', 'Completed'),  -- 5042
(1014, 309, '2024-02-01', 'Completed'),  -- 5043
(1019, 309, '2024-02-01', 'Completed'),  -- 5044
(1023, 309, '2024-02-01', 'Completed'),  -- 5045
-- ENG201 (Sec 310): Passed ENG101
(1017, 310, '2024-02-01', 'Completed'),  -- 5046
(1018, 310, '2024-02-01', 'Completed'),  -- 5047
-- MTH201 (Sec 311): Lin Mei (passed MTH101)
(1022, 311, '2024-02-01', 'Completed');  -- 5048
GO
-- FALL 2024: Sections 312-317 (21 enrollments: 5049-5069)
INSERT INTO Enrollments (StudentID, SectionID, EnrollmentDate, Status) VALUES
-- CS301 (Sec 312): Passed CS201. NOTE: 1003=VIOLATION (failed CS101, never took CS201)
(1000, 312, '2024-09-01', 'Completed'),  -- 5049
(1004, 312, '2024-09-01', 'Completed'),  -- 5050
(1006, 312, '2024-09-01', 'Completed'),  -- 5051
(1009, 312, '2024-09-01', 'Completed'),  -- 5052
(1024, 312, '2024-09-01', 'Completed'),  -- 5053
(1003, 312, '2024-09-01', 'Completed'),  -- 5054 VIOLATION: Ravi never passed CS201
-- CS202 Retake (Sec 313): Students who chose CS202 path
(1013, 313, '2024-09-01', 'Completed'),  -- 5055 (has CS201, now doing CS202)
(1015, 313, '2024-09-01', 'Completed'),  -- 5056 (has CS201, now doing CS202)
(1021, 313, '2024-09-01', 'Completed'),  -- 5057 (retaking after F in Spring 2024)
-- IT301 (Sec 314): Passed IT201. NOTE: 1007=VIOLATION (failed IT201)
(1001, 314, '2024-09-01', 'Completed'),  -- 5058
(1002, 314, '2024-09-01', 'Completed'),  -- 5059
(1011, 314, '2024-09-01', 'Completed'),  -- 5060
(1020, 314, '2024-09-01', 'Completed'),  -- 5061
(1007, 314, '2024-09-01', 'Completed'),  -- 5062 VIOLATION: Daniel failed IT201
-- BA301 (Sec 315): Passed BA201
(1005, 315, '2024-09-01', 'Completed'),  -- 5063
(1008, 315, '2024-09-01', 'Completed'),  -- 5064
(1019, 315, '2024-09-01', 'Completed'),  -- 5065
(1023, 315, '2024-09-01', 'Completed'),  -- 5066
-- BA202 (Sec 316): Passed BA101
(1012, 316, '2024-09-01', 'Completed'),  -- 5067
(1014, 316, '2024-09-01', 'Completed'),  -- 5068
-- MTH301 (Sec 317): Lin Mei passed MTH201
(1022, 317, '2024-09-01', 'Completed');  -- 5069
Go
-- SPRING 2025: Sections 318-322 (12 enrollments: 5070-5081)
INSERT INTO Enrollments (StudentID, SectionID, EnrollmentDate, Status) VALUES
(1000, 318, '2025-02-01', 'Completed'),  -- 5070
(1006, 318, '2025-02-01', 'Completed'),  -- 5071 Fatima Ali (CS401)
(1009, 318, '2025-02-01', 'Completed'),  -- 5072 Omar Hassan (CS401)
(1024, 318, '2025-02-01', 'Completed'),  -- 5073 Nina Petrov (CS401)
-- CS301 (Sec 319): Students who took CS201 Spr24 but missed Fall CS301
(1013, 319, '2025-02-01', 'Completed'),  -- 5074 David Chin
(1015, 319, '2025-02-01', 'Completed'),  -- 5075 Ryan Lee
-- IT202 (Sec 320): Catching up / At-Risk cases
(1007, 320, '2025-02-01', 'Completed'),  -- 5076 Daniel Park (persistent fail)
(1016, 320, '2025-02-01', 'Completed'),  -- 5077 Nadia Ahmad
-- BA202 (Sec 321): Passed BA101
(1012, 321, '2025-02-01', 'Completed'),  -- 5078 Aisha Yusuf
(1014, 321, '2025-02-01', 'Completed'),  -- 5079 Lily Wong
-- ENG301 (Sec 322): Passed ENG201
(1017, 322, '2025-02-01', 'Completed'),  -- 5080 Tom Brown
(1018, 322, '2025-02-01', 'Completed');  -- 5081 Siti Rahimah
GO
-- FALL 2025: Sections 323 - 326  (Enrollments 5082-5089)
INSERT INTO Enrollments ( StudentID, SectionID, EnrollmentDate, Status) VALUES
-- CS401 (Sec 323): Students who passed CS301 in Spring 2025
( 1000, 323, '2025-09-01', 'Completed'),  -- Ali Hassan
( 1006, 323, '2025-09-01', 'Completed'),  -- Fatima Ali
-- IT301 (Sec 324): Passed IT201
( 1001, 324, '2025-09-01', 'Completed'),  -- Maria Santos
( 1002, 324, '2025-09-01', 'Completed'),  -- Kevin Lim
-- BA301 (Sec 325): Passed BA201
( 1005, 325, '2025-09-01', 'Completed'),  -- James Okafor
(1008, 325, '2025-09-01', 'Completed'),  -- Sarah Ng
-- CS301 (Sec 326): Catching up
( 1015, 326, '2025-09-01', 'Completed'),  -- Ryan Lee
(1013, 326, '2025-09-01', 'Completed');  -- David Chin
GO
-- ============================================================
-- SPRING 2026 Enrollments (EnrollmentID 5097-5090) — ACTIVE
-- No grades yet; attendance is partial (20 classes completed)
-- ============================================================
INSERT INTO Enrollments (StudentID, SectionID, EnrollmentDate, Status) VALUES
-- CS401 (Sec 323): Passed CS301 in Spring 2025
( 1015, 327, '2026-02-01', 'Active'),   -- CS401
( 1013, 327, '2026-02-01', 'Active'),   -- CS401
-- IT301 (Sec 324): 1016=eligible(D); 1007=VIOLATION(failed IT201)
( 1016, 328, '2026-02-01', 'Active'),   -- IT301 -> Changed to IT202 logic or keep IT301 Sec 328
( 1007, 328, '2026-02-01', 'Active'),   -- IT301
-- BA301 (Sec 325): Both passed BA201
( 1012, 329, '2026-02-01', 'Active'),   -- BA301
( 1014, 329, '2026-02-01', 'Active'),   -- BA301
-- CS201 (Sec 326): Passed CS101, never took CS201
( 1021, 330, '2026-02-01', 'Active'),   -- CS201
( 1010, 330, '2026-02-01', 'Active');   -- CS201
GO

-- ============================================================
-- 10 GRADES (GradeID auto, EnrollmentIDs 5000-5081 only)
-- Formula: Total = 0.3*Midterm + 0.5*Final + 0.2*Assignment
-- A>=85(4.0), B>=75(3.0), C>=65(2.0), D>=55(1.0), F<55(0.0)
-- ============================================================
INSERT INTO Grades (EnrollmentID,MidtermScore,FinalScore,AssignmentScore,TotalScore,LetterGrade,GradePoints)
VALUES
-- =========== FALL 2023 — CS101 (Sec 300) ===========
(5000, 88, 90, 92, 89.8, 'A', 4.00),  -- Ali Hassan
(5001, 40, 38, 45, 40.0, 'F', 0.00),  -- Ravi Patel   ← FAIL (suspended later)
(5002, 82, 85, 88, 84.7, 'B', 3.00),  -- Emily Wong
(5003, 90, 93, 95, 92.5, 'A', 4.00),  -- Fatima Ali
(5004, 78, 80, 82, 79.8, 'B', 3.00),  -- Omar Hassan
(5005, 72, 75, 78, 74.7, 'C', 2.00),  -- Zara Khan
(5006, 85, 88, 90, 87.5, 'A', 4.00),  -- David Chin
(5007, 76, 78, 80, 77.8, 'B', 3.00),  -- Ryan Lee
(5008, 65, 68, 70, 67.5, 'C', 2.00),  -- Jake Wilson
(5009, 86, 89, 91, 88.5, 'A', 4.00),  -- Nina Petrov
-- =========== FALL 2023 — IT101 (Sec 301) ===========
(5010, 75, 78, 80, 77.5, 'B', 3.00),  -- Maria Santos
(5011, 88, 92, 94, 91.2, 'A', 4.00),  -- Kevin Lim
(5012, 70, 72, 74, 71.8, 'C', 2.00),  -- Daniel Park
(5013, 82, 85, 87, 84.5, 'B', 3.00),  -- Michael Tan
(5014, 78, 80, 82, 79.8, 'B', 3.00),  -- Nadia Ahmad
(5015, 90, 92, 94, 91.8, 'A', 4.00),  -- Priya Sharma
-- =========== FALL 2023 — BA101 (Sec 302) ===========
(5016, 80, 82, 85, 82.0, 'B', 3.00),  -- James Okafor
(5017, 85, 88, 90, 87.5, 'A', 4.00),  -- Sarah Ng
(5018, 76, 78, 80, 77.8, 'B', 3.00),  -- Aisha Yusuf
(5019, 82, 85, 88, 84.7, 'B', 3.00),  -- Lily Wong
(5020, 90, 93, 95, 92.5, 'A', 4.00),  -- Carlos Rivera
(5021, 88, 91, 93, 90.5, 'A', 4.00),  -- Ahmed Malik
-- =========== FALL 2023 — ENG101 / MTH101 ===========
(5022, 78, 80, 82, 79.8, 'B', 3.00),  -- Tom Brown
(5023, 85, 88, 90, 87.5, 'A', 4.00),  -- Siti Rahimah
(5024, 92, 95, 97, 94.5, 'A', 4.00),  -- Lin Mei
-- =========== SPRING 2024 — CS201 (Sec 305) ===========
(5025, 85, 88, 90, 87.5, 'A', 4.00),  -- Ali Hassan
(5026, 78, 80, 82, 79.8, 'B', 3.00),  -- Emily Wong
(5027, 92, 95, 97, 94.5, 'A', 4.00),  -- Fatima Ali
(5028, 75, 78, 80, 77.5, 'B', 3.00),  -- Omar Hassan
(5029, 88, 90, 92, 89.8, 'A', 4.00),  -- David Chin
(5030, 72, 74, 76, 73.8, 'C', 2.00),  -- Ryan Lee
(5031, 80, 83, 85, 82.5, 'B', 3.00),  -- Nina Petrov
-- =========== SPRING 2024 — CS202 (Sec 306) ===========
(5032, 76, 78, 80, 77.8, 'B', 3.00),  -- Zara Khan
(5033, 45, 48, 50, 47.5, 'F', 0.00),  -- Jake Wilson ← FAIL (retakes Fall 2024)
-- =========== SPRING 2024 — IT201 (Sec 307) ===========
(5034, 72, 74, 76, 73.8, 'C', 2.00),  -- Maria Santos
(5035, 88, 92, 94, 91.2, 'A', 4.00),  -- Kevin Lim
(5036, 38, 40, 42, 39.8, 'F', 0.00),  -- Daniel Park ← FAIL (takes IT301 anyway=VIOLATION)
(5037, 82, 85, 87, 84.5, 'B', 3.00),  -- Michael Tan
(5038, 57, 58, 60, 58.1, 'D', 1.00),  -- Nadia Ahmad ← D (borderline pass)
(5039, 90, 92, 94, 91.8, 'A', 4.00),  -- Priya Sharma
-- =========== SPRING 2024 — BA201 (Sec 309) ===========
(5040, 82, 85, 88, 84.7, 'B', 3.00),  -- James Okafor
(5041, 88, 91, 93, 90.5, 'A', 4.00),  -- Sarah Ng
(5042, 72, 74, 76, 73.8, 'C', 2.00),  -- Aisha Yusuf
(5043, 78, 80, 82, 79.8, 'B', 3.00),  -- Lily Wong
(5044, 90, 93, 95, 92.5, 'A', 4.00),  -- Carlos Rivera
(5045, 95, 97, 98, 96.6, 'A', 4.00),  -- Ahmed Malik
-- =========== SPRING 2024 — ENG201 / MTH201 ===========
(5046, 80, 82, 84, 81.8, 'B', 3.00),  -- Tom Brown
(5047, 88, 90, 92, 89.8, 'A', 4.00),  -- Siti Rahimah
(5048, 90, 93, 95, 92.5, 'A', 4.00),  -- Lin Mei
-- =========== FALL 2024 — CS301 (Sec 312) ===========
(5049, 88, 90, 92, 89.8, 'A', 4.00),  -- Ali Hassan
(5050, 76, 78, 80, 77.8, 'B', 3.00),  -- Emily Wong
(5051, 92, 95, 97, 94.5, 'A', 4.00),  -- Fatima Ali
(5052, 78, 80, 82, 79.8, 'B', 3.00),  -- Omar Hassan
(5053, 82, 85, 88, 84.7, 'B', 3.00),  -- Nina Petrov
(5054, 35, 30, 38, 33.1, 'F', 0.00),  -- Ravi Patel ← VIOLATION + F (suspended)
-- =========== FALL 2024 — CS202 Retake (Sec 313) ===========
(5055, 88, 90, 92, 89.8, 'A', 4.00),  -- David Chin
(5056, 75, 77, 79, 76.8, 'B', 3.00),  -- Ryan Lee
(5057, 68, 70, 72, 69.8, 'C', 2.00),  -- Jake Wilson ← Improved from F to C
-- =========== FALL 2024 — IT301 (Sec 314) ===========
(5058, 78, 80, 82, 79.8, 'B', 3.00),  -- Maria Santos
(5059, 90, 93, 95, 92.5, 'A', 4.00),  -- Kevin Lim
(5060, 82, 85, 87, 84.5, 'B', 3.00),  -- Michael Tan
(5061, 88, 91, 93, 90.5, 'A', 4.00),  -- Priya Sharma
(5062, 40, 38, 42, 39.4, 'F', 0.00),  -- Daniel Park ← VIOLATION + F again
-- =========== FALL 2024 — BA301 (Sec 315) ===========
(5063, 82, 85, 88, 84.7, 'B', 3.00),  -- James Okafor
(5064, 88, 90, 92, 89.8, 'A', 4.00),  -- Sarah Ng
(5065, 90, 93, 95, 92.5, 'A', 4.00),  -- Carlos Rivera
(5066, 95, 97, 98, 96.6, 'A', 4.00),  -- Ahmed Malik
-- =========== FALL 2024 — BA202 / MTH301 ===========
(5067, 76, 78, 80, 77.8, 'B', 3.00),  -- Aisha Yusuf
(5068, 82, 85, 88, 84.7, 'B', 3.00),  -- Lily Wong
(5069, 88, 92, 94, 91.2, 'A', 4.00),  -- Lin Mei
-- =========== SPRING 2025 — CS401 (Sec 318) ===========
(5070, 90, 93, 95, 92.5, 'A', 4.00),  -- Ali Hassan
(5071, 93, 96, 98, 95.5, 'A', 4.00),  -- Fatima Ali
(5072, 82, 85, 87, 84.5, 'B', 3.00),  -- Omar Hassan
(5073, 85, 88, 90, 87.5, 'A', 4.00),  -- Nina Petrov
-- =========== SPRING 2025 — CS301 (Sec 319) ===========
(5074, 88, 90, 92, 89.8, 'A', 4.00),  -- David Chin
(5075, 72, 74, 76, 73.8, 'C', 2.00),  -- Ryan Lee
-- =========== SPRING 2025 — IT202 (Sec 320) ===========
(5076, 42, 40, 44, 41.4, 'F', 0.00),  -- Daniel Park ← AT-RISK (GPA 0.0 last sem)
(5077, 68, 70, 72, 69.8, 'C', 2.00),  -- Nadia Ahmad
-- =========== SPRING 2025 — BA202 / ENG301 ===========
(5078, 80, 82, 84, 81.8, 'B', 3.00),  -- Aisha Yusuf
(5079, 85, 88, 90, 87.5, 'A', 4.00),  -- Lily Wong
(5080, 82, 85, 88, 84.7, 'B', 3.00),  -- Tom Brown
(5081, 90, 93, 95, 92.5, 'A', 4.00),  -- Siti Rahimah
-- =========== FALL 2025 — CS401 / IT301 / BA301 / CS201 (Secs 323-326) ===========
(5082, 90, 92, 94, 91.8, 'A', 4.00),
(5083, 93, 95, 96, 94.7, 'A', 4.00),
(5084, 85, 88, 90, 87.5, 'A', 4.00),
(5085, 88, 90, 92, 89.8, 'A', 4.00),
(5086, 82, 85, 87, 84.5, 'B', 3.00),
(5087, 90, 93, 95, 92.5, 'A', 4.00),
(5088, 75, 78, 80, 77.5, 'B', 3.00),
(5089, 80, 82, 85, 82.0, 'B', 3.00);
 GO

 -- ============================================================
-- 11 
-- ATTENDANCE (90 records for EnrollmentIDs 5000-5089)
-- Completed semesters: 28 total classes
-- Spring 2026 (Active): 20 total classes so far
-- INELIGIBLE: Students with AttendancePercentage < 75%
-- ============================================================
INSERT INTO Attendance (EnrollmentID, TotalClasses, AttendedClasses) VALUES
-- FALL 2023 — CS101
(5000, 28, 26), -- Ali       92.9%
(5001, 28, 16), -- Ravi      57.1% ← INELIGIBLE (correlated with F grade)
(5002, 28, 24), -- Emily     85.7%
(5003, 28, 28), -- Fatima   100.0%
(5004, 28, 25), -- Omar      89.3%
(5005, 28, 22), -- Zara      78.6%
(5006, 28, 27), -- David     96.4%
(5007, 28, 24), -- Ryan      85.7%
(5008, 28, 21), -- Jake      75.0%
(5009, 28, 26), -- Nina      92.9%
-- FALL 2023 — IT101
(5010, 28, 24), -- Maria     85.7%
(5011, 28, 27), -- Kevin     96.4%
(5012, 28, 22), -- Daniel    78.6%
(5013, 28, 25), -- Michael   89.3%
(5014, 28, 21), -- Nadia     75.0%
(5015, 28, 28), -- Priya    100.0%
-- FALL 2023 — BA101
(5016, 28, 25), -- James     89.3%
(5017, 28, 26), -- Sarah     92.9%
(5018, 28, 22), -- Aisha     78.6%
(5019, 28, 24), -- Lily      85.7%
(5020, 28, 27), -- Carlos    96.4%
(5021, 28, 28), -- Ahmed    100.0%
-- FALL 2023 — ENG101 / MTH101
(5022, 28, 24), -- Tom       85.7%
(5023, 28, 26), -- Siti      92.9%
(5024, 28, 27), -- Lin Mei   96.4%
-- SPRING 2024 — CS201
(5025, 28, 26), -- Ali       92.9%
(5026, 28, 24), -- Emily     85.7%
(5027, 28, 28), -- Fatima   100.0%
(5028, 28, 25), -- Omar      89.3%
(5029, 28, 27), -- David     96.4%
(5030, 28, 22), -- Ryan      78.6%
(5031, 28, 24), -- Nina      85.7%
-- SPRING 2024 — CS202
(5032, 28, 25), -- Zara      89.3%
(5033, 28, 18), -- Jake      64.3% ← INELIGIBLE (correlated with F)
-- SPRING 2024 — IT201
(5034, 28, 22), -- Maria     78.6%
(5035, 28, 26), -- Kevin     92.9%
(5036, 28, 14), -- Daniel    50.0% ← INELIGIBLE (correlated with F)
(5037, 28, 25), -- Michael   89.3%
(5038, 28, 21), -- Nadia     75.0%
(5039, 28, 27), -- Priya     96.4%
-- SPRING 2024 — BA201
(5040, 28, 24), -- James     85.7%
(5041, 28, 26), -- Sarah     92.9%
(5042, 28, 22), -- Aisha     78.6%
(5043, 28, 25), -- Lily      89.3%
(5044, 28, 27), -- Carlos    96.4%
(5045, 28, 28), -- Ahmed    100.0%
-- SPRING 2024 — ENG201 / MTH201
(5046, 28, 24), -- Tom       85.7%
(5047, 28, 26), -- Siti      92.9%
(5048, 28, 27), -- Lin Mei   96.4%
-- FALL 2024 — CS301
(5049, 28, 26), -- Ali       92.9%
(5050, 28, 24), -- Emily     85.7%
(5051, 28, 28), -- Fatima   100.0%
(5052, 28, 25), -- Omar      89.3%
(5053, 28, 24), -- Nina      85.7%
(5054, 28, 12), -- Ravi      42.9% ← INELIGIBLE (suspension case)
-- FALL 2024 — CS202 Retake
(5055, 28, 26), -- David     92.9%
(5056, 28, 24), -- Ryan      85.7%
(5057, 28, 22), -- Jake      78.6%
-- FALL 2024 — IT301
(5058, 28, 24), -- Maria     85.7%
(5059, 28, 26), -- Kevin     92.9%
(5060, 28, 25), -- Michael   89.3%
(5061, 28, 27), -- Priya     96.4%
(5062, 28, 10), -- Daniel    35.7% ← INELIGIBLE (persistent offender)
-- FALL 2024 — BA301 / BA202 / MTH301
(5063, 28, 25), -- James     89.3%
(5064, 28, 26), -- Sarah     92.9%
(5065, 28, 27), -- Carlos    96.4%
(5066, 28, 28), -- Ahmed    100.0%
(5067, 28, 23), -- Aisha     82.1%
(5068, 28, 24), -- Lily      85.7%
(5069, 28, 26), -- Lin Mei   92.9%
-- SPRING 2025 — CS401
(5070, 28, 26), -- Ali       92.9%
(5071, 28, 28), -- Fatima   100.0%
(5072, 28, 25), -- Omar      89.3%
(5073, 28, 24), -- Nina      85.7%
-- SPRING 2025 — CS301 / IT202 / BA202 / ENG301
(5074, 28, 26), -- David     92.9%
(5075, 28, 22), -- Ryan      78.6%
(5076, 28, 14), -- Daniel    50.0% ← INELIGIBLE (AT-RISK case)
(5077, 28, 22), -- Nadia     78.6%
(5078, 28, 24), -- Aisha     85.7%
(5079, 28, 26), -- Lily      92.9%
(5080, 28, 24), -- Tom       85.7%
(5081, 28, 26), -- Siti      92.9%
-- FALL 2025 — CS401 / IT301 / BA301 / CS201
(5082, 28, 26), -- Ali 92.9%
(5083, 28, 28), -- Fatima 100%
(5084, 28, 24), -- Maria 85.7%
(5085, 28, 26), -- Kevin 92.9%
(5086, 28, 25), -- James 89.3%
(5087, 28, 27), -- Sarah 96.4%
(5088, 28, 22), -- Ryan 78.6%
(5089, 28, 24), -- David 85.7%
-- SPRING 2026 (CURRENT — 20 classes so far)
(5090, 20, 18), -- Ryan Lee   90.0% (CS401)
(5091, 20, 17), -- David Chin 85.0% (CS401)
(5092, 20, 12), -- Nadia     60.0% ← INELIGIBLE FOR FINALS
(5093, 20, 11), -- Daniel    55.0% ← INELIGIBLE FOR FINALS (pattern continues)
(5094, 20, 17), -- Aisha     85.0%
(5095, 20, 16), -- Lily      80.0%
(5096, 20, 18), -- Jake      90.0%
(5097, 20, 15); -- Zara      75.0%
GO