-- ============================================================
-- University Student Registration & Results Management System
-- Database: UniversityDB
-- SQL Server 2019+
-- ============================================================

USE master;
GO
CREATE DATABASE UniversityDB;
GO
USE UniversityDB;
GO

-- ============================================================
-- TABLE 1: DEPARTMENTS
-- ============================================================
CREATE TABLE Departments (
    DeptID      INT           PRIMARY KEY IDENTITY(1,1),
    DeptName    VARCHAR(100)  NOT NULL,
    DeptCode    VARCHAR(10)   NOT NULL UNIQUE,
    Dean        VARCHAR(100),
    Location    VARCHAR(50),
    Phone       VARCHAR(20),
    EstablishedYear INT       CHECK (EstablishedYear BETWEEN 1900 AND 2100)
);
GO

-- ============================================================
-- TABLE 2: PROGRAMS
-- ============================================================
CREATE TABLE Programs (
    ProgramID    INT          PRIMARY KEY IDENTITY(1,1),
    ProgramName  VARCHAR(100) NOT NULL,
    ProgramCode  VARCHAR(10)  NOT NULL UNIQUE,
    DeptID       INT          NOT NULL,
    TotalCredits INT          NOT NULL CHECK (TotalCredits > 0),
    DurationYears INT         NOT NULL CHECK (DurationYears BETWEEN 1 AND 6),
    DegreeLevel  VARCHAR(20)  CHECK (DegreeLevel IN ('Bachelor','Master','Diploma','Certificate')),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
GO

-- ============================================================
-- TABLE 3: STUDENTS
-- ============================================================
CREATE TABLE Students (
    StudentID      INT          PRIMARY KEY IDENTITY(1000,1),
    FirstName      VARCHAR(50)  NOT NULL,
    LastName       VARCHAR(50)  NOT NULL,
    DateOfBirth    DATE         NOT NULL,
    Gender         CHAR(1)      CHECK (Gender IN ('M','F','O')),
    Email          VARCHAR(100) NOT NULL UNIQUE,
    Phone          VARCHAR(20),
    Address        VARCHAR(200),
    EnrollmentDate DATE         NOT NULL DEFAULT GETDATE(),
    ProgramID      INT          NOT NULL,
    AcademicStatus VARCHAR(20)  DEFAULT 'Active'
                                CHECK (AcademicStatus IN ('Active','Inactive','Graduated','Suspended','Withdrawn')),
    FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID)
);
GO

-- ============================================================
-- TABLE 4: INSTRUCTORS
-- ============================================================
CREATE TABLE Instructors (
    InstructorID   INT          PRIMARY KEY IDENTITY(100,1),
    FirstName      VARCHAR(50)  NOT NULL,
    LastName       VARCHAR(50)  NOT NULL,
    Email          VARCHAR(100) NOT NULL UNIQUE,
    DeptID         INT          NOT NULL,
    Rank           VARCHAR(30)  CHECK (Rank IN ('Lecturer','Assistant Professor',
                                               'Associate Professor','Professor')),
    HireDate       DATE         NOT NULL,
    Phone          VARCHAR(20),
    Specialization VARCHAR(100),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
GO

-- ============================================================
-- TABLE 5: COURSES
-- ============================================================
CREATE TABLE Courses (
    CourseID     INT          PRIMARY KEY IDENTITY(200,1),
    CourseCode   VARCHAR(10)  NOT NULL UNIQUE,
    CourseName   VARCHAR(100) NOT NULL,
    Credits      INT          NOT NULL CHECK (Credits BETWEEN 1 AND 6),
    DeptID       INT          NOT NULL,
    CourseLevel  INT          CHECK (CourseLevel IN (100,200,300,400,500)),
    Description  VARCHAR(500),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
GO

-- ============================================================
-- TABLE 6: COURSE PREREQUISITES
-- ============================================================
CREATE TABLE CoursePrerequisites (
    PrereqID            INT PRIMARY KEY IDENTITY(1,1),
    CourseID            INT NOT NULL,
    PrerequisiteCourseID INT NOT NULL,
    CONSTRAINT UQ_CoursePrereq UNIQUE (CourseID, PrerequisiteCourseID),
    CONSTRAINT CHK_NoSelfPrereq CHECK (CourseID <> PrerequisiteCourseID),
    FOREIGN KEY (CourseID)            REFERENCES Courses(CourseID),
    FOREIGN KEY (PrerequisiteCourseID) REFERENCES Courses(CourseID)
);
GO

-- ============================================================
-- TABLE 7: SEMESTERS
-- ============================================================
CREATE TABLE Semesters (
    SemesterID   INT          PRIMARY KEY IDENTITY(1,1),
    SemesterName VARCHAR(20)  NOT NULL CHECK (SemesterName IN ('Fall','Spring','Summer')),
    AcademicYear INT          NOT NULL CHECK (AcademicYear BETWEEN 2000 AND 2100),
    StartDate    DATE         NOT NULL,
    EndDate      DATE         NOT NULL,
    IsCurrent    BIT          DEFAULT 0,
    CONSTRAINT UQ_SemesterYear UNIQUE (SemesterName, AcademicYear),
    CONSTRAINT CHK_SemDates CHECK (EndDate > StartDate)
);
GO

-- ============================================================
-- TABLE 8: SECTIONS
-- ============================================================
CREATE TABLE Sections (
    SectionID     INT         PRIMARY KEY IDENTITY(300,1),
    CourseID      INT         NOT NULL,
    InstructorID  INT         NOT NULL,
    SemesterID    INT         NOT NULL,
    Capacity      INT         NOT NULL CHECK (Capacity BETWEEN 10 AND 200),
    EnrolledCount INT         DEFAULT 0 CHECK (EnrolledCount >= 0),
    Room          VARCHAR(20),
    Schedule      VARCHAR(50),
    CONSTRAINT CHK_CapacityEnrolled CHECK (EnrolledCount <= Capacity),
    FOREIGN KEY (CourseID)     REFERENCES Courses(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
    FOREIGN KEY (SemesterID)   REFERENCES Semesters(SemesterID)
);
GO

-- ============================================================
-- TABLE 9: ENROLLMENTS
-- ============================================================
CREATE TABLE Enrollments (
    EnrollmentID   INT   PRIMARY KEY IDENTITY(5000,1),
    StudentID      INT   NOT NULL,
    SectionID      INT   NOT NULL,
    EnrollmentDate DATE  NOT NULL DEFAULT GETDATE(),
    Status         VARCHAR(20) DEFAULT 'Active'
                         CHECK (Status IN ('Active','Dropped','Completed','Withdrawn')),
    CONSTRAINT UQ_StudentSection UNIQUE (StudentID, SectionID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SectionID) REFERENCES Sections(SectionID)
);
GO

-- ============================================================
-- TABLE 10: GRADES
-- ============================================================
CREATE TABLE Grades (
    GradeID        INT          PRIMARY KEY IDENTITY(1,1),
    EnrollmentID   INT          NOT NULL UNIQUE,
    MidtermScore   DECIMAL(5,2) CHECK (MidtermScore BETWEEN 0 AND 100),
    FinalScore     DECIMAL(5,2) CHECK (FinalScore BETWEEN 0 AND 100),
    AssignmentScore DECIMAL(5,2) CHECK (AssignmentScore BETWEEN 0 AND 100),
    TotalScore     DECIMAL(5,2) CHECK (TotalScore BETWEEN 0 AND 100),
    LetterGrade    CHAR(2)      CHECK (LetterGrade IN ('A','B','C','D','F')),
    GradePoints    DECIMAL(3,2) CHECK (GradePoints BETWEEN 0.00 AND 4.00),
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);
GO

-- ============================================================
-- TABLE 11: ATTENDANCE
-- AttendancePercentage is a PERSISTED computed column
-- ============================================================
CREATE TABLE Attendance (
    AttendanceID         INT   PRIMARY KEY IDENTITY(1,1),
    EnrollmentID         INT   NOT NULL UNIQUE,
    TotalClasses         INT   NOT NULL CHECK (TotalClasses > 0),
    AttendedClasses      INT   NOT NULL CHECK (AttendedClasses >= 0),
    AttendancePercentage AS    (CAST(AttendedClasses AS DECIMAL(5,2))
                                / TotalClasses * 100) PERSISTED,
    CONSTRAINT CHK_AttendanceValid CHECK (AttendedClasses <= TotalClasses),
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);
GO