DROP DATABASE IF EXISTS QuanLyBaiThi;
CREATE DATABASE QuanLyBaiThi;
USE QuanLyBaiThi;

-- 1.Bảng khai báo phòng ban--
CREATE TABLE Department(
	DepartmentID		TINYINT UNSIGNED    PRIMARY KEY   	NOT NULL,
	DepartmentName		VARCHAR(50)         				NOT NULL
);

-- 2.Bảng khai báo chức vụ --
CREATE TABLE `Position`(
	PositionID			TINYINT UNSIGNED    PRIMARY KEY    			 NOT NULL,		
	PositionName		ENUM('Dev', 'Test', 'Scrum Master', 'PM')    NOT NULL
);

-- 3.Bảng khai báo tài khoản --
CREATE TABLE `Account`(
	AccountID			TINYINT UNSIGNED	PRIMARY KEY,		
	Email				VARCHAR(50) 	    UNIQUE KEY,
    Username			VARCHAR(50)         UNIQUE KEY  	CHECK(length(Username)>=7)   NOT NULL,
    FullName			VARCHAR(50)			NOT NULL		CHECK(length(Fullname)>=9),
    DepartmentID		TINYINT UNSIGNED	NOT NULL,
    PositionID			TINYINT UNSIGNED    DEFAULT(1)		NOT NULL,
    CreateDate			DATETIME 		    DEFAULT NOW(),
	FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

-- 4.Bảng khai báo Group --
CREATE TABLE `Group` (
	GroupID				TINYINT UNSIGNED 		PRIMARY KEY 	NOT NULL,		
	GroupName			VARCHAR(50)				UNIQUE KEY 		NOT NULL	CHECK(length(GroupName)>=5),
    CreatorID			TINYINT UNSIGNED 		UNIQUE KEY		NOT NULL,
    CreateDate			DATE,
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

-- 5.Bảng khai báo GroupAccount-- 
CREATE TABLE GroupAccount (
	GroupID				TINYINT UNSIGNED 	UNIQUE KEY		NOT NULL,		
	AccountID			TINYINT UNSIGNED 	PRIMARY KEY		NOT NULL,
    JoinDate			DATE,
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID),
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID)
);

-- 6.Bảng khai báo TypeQuestion--
CREATE TABLE TypeQuestion (
	TypeID				TINYINT UNSIGNED	PRIMARY KEY			NOT NULL,		
	TypeName			ENUM( 'Essay','Multiple-Choiice' )		NOT NULL
);

-- 7.Bảng khai báo CategoryQuestion--
CREATE TABLE CategoryQuestion (
	CategoryID			TINYINT UNSIGNED	PRIMARY KEY 					NOT NULL ,		
	CategoryName		VARCHAR(50)			CHECK(length(CategoryName)>=8) 	NOT NULL
);
 
 -- 8.Bảng khai báo Question--
 CREATE TABLE Question (
	 QuestionID			TINYINT UNSIGNED	PRIMARY KEY		NOT NULL,
	 Content 			VARCHAR(50) 						NOT NULL		CHECK(length(Content)>=10),
	 CategoryID 		TINYINT UNSIGNED	UNIQUE KEY		NOT NULL,
	 TypeID				TINYINT UNSIGNED	UNIQUE KEY		NOT NULL,
	 CreatorID			TINYINT UNSIGNED	UNIQUE KEY		NOT NULL,
	 CreateDate			DATE,
	 FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
	 FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID)
);

-- 9.Bảng khai báo Answer--
 CREATE TABLE Answer (
	 AnswerID			TINYINT UNSIGNED			PRIMARY KEY     				NOT NULL,
	 Content 			VARCHAR(50)					CHECK(length(Content)>=10)		NOT NULL,
	 QuestionID			TINYINT UNSIGNED			UNIQUE KEY						NOT NULL,
	 isCorrect			VARCHAR(50)													NOT NULL,
     FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

-- 10.Bảng khai báo Exam--
CREATE TABLE Exam (
	 ExamID			    TINYINT UNSIGNED	PRIMARY KEY 	NOT NULL,
	 `Code` 			VARCHAR(50)			UNIQUE KEY		NOT NULL,
	 CategoryID			VARCHAR(50)			UNIQUE KEY		NOT NULL,
	 Duration		    TIME								NOT NULL,
     CreatorID			TINYINT UNSIGNED	UNIQUE KEY		NOT NULL,
     CreateDate			DATE,
	 FOREIGN KEY(CreatorID) REFERENCES Question(CreatorID)
);

-- 11.Bảng khai báo ExamQuestion--
CREATE TABLE ExamQuestion (
	 ExamID    			TINYINT UNSIGNED	UNIQUE KEY		NOT NULL,
	 QuestionID			TINYINT UNSIGNED	UNIQUE KEY 		NOT NULL,
     FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
     FOREIGN KEY(QuestionID) REFERENCES Answer(QuestionID)
);