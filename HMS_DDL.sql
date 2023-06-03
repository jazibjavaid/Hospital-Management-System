------------------------------------------CREATE DATABASE------------------------------------------

CREATE DATABASE Team9_Database;
USE Team9_Database;

------------------------------------------CREATE SCHEMA------------------------------------------

CREATE SCHEMA dbo;
---------------------------------------------------CREATE TABLE QUERIES-----------------------------------------------------
--DROP TABLE Hospital
CREATE TABLE dbo.Hospital
(
	HospitalID INT IDENTITY(1, 1) NOT NULL,
	HospitalName VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	Zipcode VARCHAR(20) NOT NULL,
	ContactNo VARCHAR(20),
	Email VARCHAR(50),
	City VARCHAR(50) NOT NULL,
	State VARCHAR(50) NOT NULL,
	CONSTRAINT PK_HospitalID PRIMARY KEY(HospitalID)
)

--DROP TABLE Department
CREATE TABLE dbo.Department
(
	DepartmentID INT IDENTITY(1, 1) NOT NULL,
	DepartmentName VARCHAR(255),
	DepartmentHead VARCHAR(255),
	CONSTRAINT PK_DepartmentID PRIMARY KEY(DepartmentID)
)

--DROP TABLE HospitalDepartment
CREATE TABLE dbo.HospitalDepartment
(
	HospitalID INT NOT NULL,
	DepartmentID INT NOT NULL,
	HosDepID INT IDENTITY(1, 1) NOT NULL,
	CONSTRAINT PK_HosDepID PRIMARY KEY(HosDepID),
	CONSTRAINT FK_HospitalID FOREIGN KEY (HospitalID) REFERENCES dbo.Hospital(HospitalID),
	CONSTRAINT FK_DepartmentID FOREIGN KEY (DepartmentID) REFERENCES dbo.Department(DepartmentID)
)

--DROP TABLE Doctor
CREATE TABLE dbo.Doctor
(
	DoctorID INT IDENTITY(1, 1) NOT NULL,
	HosDepID INT NOT NULL,
	DoctorFName VARCHAR(255) NOT NULL,
	DoctorLName VARCHAR(255) NOT NULL,
	Gender char(1) NULL,
	ContactNo varchar(10) NULL,
	CONSTRAINT PK_DoctorID PRIMARY KEY(DoctorID),
	CONSTRAINT FK_HosDepID FOREIGN KEY (HosDepID) REFERENCES dbo.HospitalDepartment(HosDepID)
)

--DROP TABLE Nurse
CREATE TABLE dbo.Nurse
(
	NurseID INT IDENTITY(1, 1) NOT NULL,
	HosDepID INT NOT NULL,
	NurseFName VARCHAR(255) NOT NULL,
	NurseLName VARCHAR(255) NOT NULL,
	Gender char(1) NULL,
	ContactNo VARCHAR(10) NULL,
	CONSTRAINT PK_NurseID PRIMARY KEY(NurseID),
	CONSTRAINT FK_HosDepID_1 FOREIGN KEY (HosDepID) REFERENCES dbo.HospitalDepartment(HosDepID)
)

--DROP TABLE InsurancePlan
CREATE TABLE dbo.InsurancePlan
(
	InsuranceID int IDENTITY(1,1) NOT NULL,
	PlanCode int NOT NULL,
	CompanyName varchar(50) NOT NULL,
	ContactNo VARCHAR(10) NOT NULL,
	Email varchar(50) NOT NULL,
	InsuranceDate date NOT NULL,
	CONSTRAINT PK__Insuranc__74231BC4D8BF75DA PRIMARY KEY (InsuranceID)
);

--DROP TABLE Patient
CREATE TABLE dbo.Patient
(
	PatientID int IDENTITY(1,1) NOT NULL,
	InsuranceID int NULL,
	PatientFName varchar(30) NOT NULL,
	PatientLName varchar(30) NOT NULL,
	DateOfBirth date NOT NULL,
	ContactNo varbinary(255) NOT NULL,
	Email varbinary(255) NOT NULL,
	Gender char(1) COLLATE NOT NULL
	CONSTRAINT PK__Patient__970EC346377BB6BE PRIMARY KEY
(PatientID),
	CONSTRAINT FK__Patient__Insuran__49C3F6B7 FOREIGN KEY
(InsuranceID) REFERENCES Team9_Database.dbo.InsurancePlan
(InsuranceID)
);

--DROP TABLE Address
CREATE TABLE Team9_Database.dbo.Address
(
	PatientID int NOT NULL,
	StreetAddress varchar(50) NOT NULL,
	City varchar(30) NOT NULL,
	States varchar(30) NOT NULL,
	ZipCode varchar(10) NOT NULL,
	CONSTRAINT PK__Address__970EC346A4DE3DDE PRIMARY KEY (PatientID),
	CONSTRAINT FK__Address__Patient__4CA06362 FOREIGN KEY (PatientID) REFERENCES Team9_Database.dbo.Patient(PatientID)
);

--DROP TABLE MedicalRecord
CREATE TABLE dbo.MedicalRecord
(
	RecordID int IDENTITY(1,1) NOT NULL,
	PatientID int NOT NULL,
	DoctorID int NOT NULL,
	Diagnosis varchar(100) NULL,
	Prescription varchar(100) NULL,
	AppointmentCost decimal(10,2) NULL,
	RecordDate date NULL,
	CONSTRAINT PK__MedicalR__FBDF78C92F54CC44 PRIMARY KEY (RecordID),
	CONSTRAINT FK__MedicalRe__Docto__0A9D95DB FOREIGN KEY (DoctorID) REFERENCES Team9_Database.dbo.Doctor(DoctorID),
	CONSTRAINT FK__MedicalRe__Patie__09A971A2 FOREIGN KEY (PatientID) REFERENCES Team9_Database.dbo.Patient(PatientID)
);

--DROP TABLE Tests
CREATE TABLE dbo.Tests
(
	TestID int IDENTITY(1,1) NOT NULL,
	TestName varchar(100) NULL,
	Description varchar(100) NULL,
	Cost decimal(10,2) NULL,
	CONSTRAINT PK__Tests__8CC33100E45D05B8 PRIMARY KEY (TestID)
);

--DROP TABLE Testing
CREATE TABLE dbo.Testing
(
	RecordID int NOT NULL,
	TestID int NOT NULL,
	[Result] varchar(100) NULL,
	CONSTRAINT PKTESTING PRIMARY KEY (RecordID,TestID),
	CONSTRAINT FK__Testing__RecordI__1332DBDC FOREIGN KEY (RecordID) REFERENCES Team9_Database.dbo.MedicalRecord(RecordID),
	CONSTRAINT FK__Testing__TestID__14270015 FOREIGN KEY (TestID) REFERENCES Team9_Database.dbo.Tests(TestID)
);

--DROP TABLE Admit
CREATE TABLE dbo.Admit
(
	AdmitID int IDENTITY(1,1) NOT NULL,
	RecordID int NOT NULL,
	NurseID int NOT NULL,
	AdmitDate date NOT NULL,
	DischargeDate date NULL,
	CONSTRAINT PK__Admit__93986932A0656408 PRIMARY KEY (admitID),
	CONSTRAINT FK__Admit__NurseID__5EBF139D FOREIGN KEY (NurseID) REFERENCES Team9_Database.dbo.Nurse(NurseID),
	CONSTRAINT FK__Admit__RecordID__5DCAEF64 FOREIGN KEY (RecordID) REFERENCES Team9_Database.dbo.MedicalRecord(RecordID)
);

--DROP TABLE Billing
CREATE TABLE dbo.Billing
(
	BillingID int IDENTITY(1,1) NOT NULL,
	RecordID int NOT NULL,
	BillingDate date NOT NULL,
	RoomCost float NULL,
	OtherCharges float NULL,
	PaymentMode varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK_Billing__F1656D13C9935A99 PRIMARY KEY (BillingID),
	CONSTRAINT FK__Billing__RecordI__619B8048 FOREIGN KEY (RecordID) REFERENCES Team9_Database.dbo.MedicalRecord(RecordID)
);

--DROP TABLE VitalSign
CREATE TABLE dbo.VitalSign
(
	RecordID int NOT NULL,
	Temperature float NOT NULL,
	RespirationRate float NOT NULL,
	PulseRate float NOT NULL,
	BloodPressure float NOT NULL,
	Weight float NOT NULL,
	Height float NOT NULL,
	CONSTRAINT PK_RecordID PRIMARY KEY (RecordID),
	CONSTRAINT FK_RecordID FOREIGN KEY (RecordID) REFERENCES Team9_Database.dbo.MedicalRecord(RecordID)
);

--DROP TABLE Medicine
CREATE TABLE dbo.Medicine
(
	MedID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(100),
	Brand VARCHAR(100),
	[Description] VARCHAR(100),
	Cost DECIMAL(10, 2)
);

--DROP TABLE Medication
CREATE TABLE dbo.Medication
(
	RecordID INT NOT NULL
		REFERENCES dbo.MedicalRecord(RecordID),
	MedID INT NOT NULL
		REFERENCES dbo.Medicine(MedID)
		CONSTRAINT PKMEDICATION PRIMARY KEY CLUSTERED
			(RecordID, MedID)
);
