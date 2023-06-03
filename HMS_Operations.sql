----------------------------------------------CREATE FUNCTION FOR TABLE LEVEL CHECK-------------------------------------------------------

--Function to validate zipcode while data insertion
--DROP FUNCION IsValidZipcode
CREATE FUNCTION IsValidZipcode (@Zipcode VARCHAR(10))
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@Zipcode LIKE '[0-9]%') -- Starts with a digit
    BEGIN
		IF (LEN(@Zipcode) = 5) -- Must be 10 digits after removing special characters
        BEGIN
			SET @IsValid = 1
		END
	END

	RETURN @IsValid
END


--Function to validate email while data insertion
--DROP FUNCION IsValidEmail
CREATE FUNCTION IsValidEmail (@email VARCHAR(255))
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0
	IF CHARINDEX('@', @email) > 0
		AND RIGHT(@email, 4) = '.com'
       BEGIN
		SET @IsValid = 1
	END
	RETURN @IsValid
END;

--Function to validate contactno while data insertion
--DROP FUNCION IsValidContactNo
CREATE FUNCTION IsValidContactNo (@ContactNo VARCHAR(20))
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@ContactNo LIKE '[0-9]%') -- Starts with a digit
    BEGIN
		IF (LEN(@ContactNo) = 10) -- Must be 10 digits after removing special characters
        BEGIN
			IF(ISNUMERIC(@ContactNo) = 1) -- Must contain only numeric digits
            BEGIN
				SET @IsValid = 1
			END
		END
	END

	RETURN @IsValid
END

--Function to validate age while data insertion
--DROP FUNCION IsValidAge
CREATE FUNCTION IsValidAge (@Age INT)
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@Age > 0 AND @Age <= 100) -- Must be 10 digits after removing special characters
        BEGIN
		SET @IsValid = 1
	END

	RETURN @IsValid
END

--Function to validate gender while data insertion
--DROP FUNCION IsValidGender
CREATE FUNCTION dbo.IsValidGender (@Gender CHAR(1))
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@Gender = 'M' OR @Gender = 'F')
    BEGIN
		SET @IsValid = 1
	END

	RETURN @IsValid
END

--Function to validate discharge data greater or equal to admit date while data insertion
--DROP FUNCION IsValidDischargeDate
CREATE FUNCTION IsValidDischargeDate (@admitDate date, @dischargeDate date)
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@dischargeDate IS NULL OR @dischargeDate >= admitDate) -- Either admitted or discharge greater
    BEGIN
		SET @IsValid = 1
	END

	RETURN @IsValid
END

-----------------------------------------------------CREATE FUNCTION FOR COMPUTING COLUMNS---------------------------------------------
--Function to calculate age and populate age column in patient table
--DROP FUNCION CalculateAge
CREATE FUNCTION CalculateAge (@dob DATE)
RETURNS INT
AS
BEGIN
	DECLARE @age INT

	SELECT @age = DATEDIFF(YEAR, @dob, GETDATE()) - CASE WHEN (MONTH(@dob) > MONTH(GETDATE())) OR (MONTH(@dob) = MONTH(GETDATE()) AND DAY(@dob) > DAY(GETDATE())) THEN 1 ELSE 0 END

	RETURN @age
END

--Function to calculate total bill amount while data insertion in Billing table
--DROP FUNCION CalculateBillingTotal
CREATE FUNCTION dbo.CalculateBillingTotal(@RecordID INT, @RoomCost DECIMAL(10, 2), @OtherCharges DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @AppointmentCost DECIMAL(10, 2), @TestCost DECIMAL(10, 2), @MedicineCost DECIMAL(10, 2)

	SELECT @AppointmentCost = COALESCE(AppointmentCost, 0)
	FROM dbo.MedicalRecord
	WHERE RecordID = @RecordID

	SELECT @TestCost = COALESCE(SUM(Cost), 0)
	FROM dbo.Tests
		INNER JOIN dbo.Testing ON dbo.Tests.TestID = dbo.Testing.TestID
	WHERE dbo.Testing.RecordID = @RecordID

	SELECT @MedicineCost = COALESCE(SUM(Cost), 0)
	FROM dbo.Medicine
		INNER JOIN dbo.Medication ON dbo.Medicine.MedID = dbo.Medication.MedID
	WHERE dbo.Medication.RecordID = @RecordID

	RETURN @AppointmentCost + @TestCost + @MedicineCost + @RoomCost + @OtherCharges
END

----------------------------------------------ALTER TABLE QUERIES---------------------------------------------------------
--Adding constraint to HOSPITAL table based on IsValidZipcode function--
ALTER TABLE Hospital
ADD CONSTRAINT chkIsValidZipCode
CHECK (dbo.IsValidZipcode(Zipcode) = 1);

--Adding constraint to HOSPITAL table based on IsValidContactNo function--
ALTER TABLE Hospital
ADD CONSTRAINT chkIsValidContactNoHosp
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to HOSPITAL table based on IsValidEmail function--
ALTER TABLE Hospital
ADD CONSTRAINT chkIsValidEmail
CHECK (dbo.IsValidEmail(Email) = 1);

--Adding constraint to DOCTOR table based on IsValidGender function--
ALTER TABLE Doctor
ADD CONSTRAINT chkIsValidGender
CHECK (dbo.IsValidGender(Gender) = 1);

--Adding constraint to DOCTOR table based on IsValidContactNo function--
ALTER TABLE Doctor
ADD CONSTRAINT chkIsValidContactNoDoc
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to NURSE table based on IsValidGender function--
ALTER TABLE Nurse
ADD CONSTRAINT chkIsValidGenderNurse
CHECK (dbo.IsValidGender(Gender) = 1);

--Adding constraint to NURSE table based on IsValidContactNo function--
ALTER TABLE Nurse
ADD CONSTRAINT chkIsValidContactNoNurse
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to INSURANCEPLAN table based on IsValidContactNo function--
ALTER TABLE InsurancePlan
ADD CONSTRAINT chkIsValidContactNoInsurance
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to PATIENT table based on IsValidZipcode function--
ALTER TABLE Patient
ADD CONSTRAINT chkIsValidGenderPatient
CHECK (dbo.IsValidGender(Gender) = 1);

--Adding constraint to PATIENT table based on IsValidContactNo function--
ALTER TABLE Patient
ADD CONSTRAINT chkIsValidContactNoPatient
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to PATIENT table based on IsValidEmail function--
ALTER TABLE Patient
ADD CONSTRAINT chkIsValidEmailPatient
CHECK (dbo.IsValidEmail(Email) = 1);

--Adding constraint to ADDRESS table based on IsValidZipcode function--
ALTER TABLE Address
ADD CONSTRAINT chkIsValidZipCodeAddress
CHECK (dbo.IsValidZipcode(Zipcode) = 1);

--Adding constraint to ADMIT table based on IsValidDischargeDate function--
ALTER TABLE Team9_Database.dbo.Admit
ADD CONSTRAINT CK_DischargeDateGreaterOrEqual 
CHECK (dbo.IsValidDischargeDate(AdmitDate, DischargeDate) = 1);

--Adding constraint to PATIENT table to create and populate age column based on CalculateAge function--
ALTER TABLE Patient
ADD Age AS dbo.CalculateAge(DATEOFBIRTH);

--Adding constraint to billing table to create and populate Total column based on CalculateBillingTotal function
ALTER TABLE Billing
ADD Total AS dbo.CalculateBillingTotal(RecordID, RoomCost, OtherCharges);


-------------------------------------------------------ENCRYPTION KEY-------------------------------------------------------------------

--CREATING SYMMETRIC KEY
CREATE SYMMETRIC KEY NewKey
WITH ALGORITHM = AES_256
ENCRYPTION BY PASSWORD = 'ThisPassword';
--OPENING SYMMETRIC KEY
OPEN SYMMETRIC KEY NewKey
DECRYPTION BY PASSWORD = 'ThisPassword';
--CLOSING SYMMETRIC KEY
CLOSE SYMMETRIC KEY NewKey

-------------------------------------------------------CREATE TRIGGER QUERIES----------------------------------------------------------- 

--Trigger to encrypt sensitive data in the patient table
--DROP TRIGGER EncryptPatientInfoTrigger
CREATE TRIGGER EncryptPatientInfoTrigger
ON Patient
AFTER INSERT
AS
BEGIN
	OPEN SYMMETRIC KEY NewKey
      DECRYPTION BY PASSWORD = 'ThisPassword';
	DECLARE @Email VARBINARY(255), @ContactNo VARBINARY(255)
	SELECT @Email = Email, @ContactNo = ContactNo
	FROM inserted

	SET @Email = EncryptByKey(Key_GUID('NewKey'),@Email)
	SET @ContactNo = EncryptByKey(Key_GUID('NewKey'),@ContactNo)

	UPDATE Patient
    SET Email = @Email, ContactNo = @ContactNo
    WHERE PatientID = (SELECT PatientID
	FROM inserted)
	CLOSE SYMMETRIC KEY NewKey;
END

-------------------------------------------------------CREATE STORED PROCEDURE QUERIES---------------------------------------------------

--Procedure to decrypt sensitive patient data 
--drop procedure PatientDetails

--EXEC PatientDetails 
CREATE PROCEDURE PatientDetails
AS
BEGIN
	OPEN SYMMETRIC KEY NewKey
      DECRYPTION BY PASSWORD = 'ThisPassword';

	SELECT p.PatientID,
		p.PatientFName,
		p.PatientLName,
		p.DateOfBirth,
		p.Gender,
		DECRYPTBYKEY(p.ContactNo) AS ContactNo,
		DECRYPTBYKEY(p.Email) AS Email,
		a.StreetAddress,
		a.City,
		a.States,
		a.ZipCode,
		p.InsuranceID,
		ip.PlanCode,
		ip.CompanyName
	FROM Patient p
		INNER JOIN InsurancePlan ip ON p.InsuranceID = ip.InsuranceID
		LEFT JOIN Address a ON p.PatientID = a.PatientID;

	CLOSE SYMMETRIC KEY NewKey;
END;

--------------------------------------------------------CREATE VIEWS-------------------------------------------------------------------
-- View for displaying patient vitals
-- DROP VIEW vw_PatientVitals	
CREATE VIEW vw_PatientVitals
AS
	SELECT CONCAT(p.PatientFName, ' ', p.PatientLName)[Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		(SELECT d.DoctorFName + ' ' + d.DoctorLName
		FROM Doctor d
		WHERE d.DoctorID = mr.DoctorID) [Doctor],
		mr.Diagnosis,
		mr.Prescription,
		mr.RecordDate,
		vs.Temperature,
		vs.RespirationRate,
		vs.PulseRate,
		vs.BloodPressure,
		vs.Weight,
		vs.Height
	FROM Patient p
		INNER JOIN MedicalRecord mr
		ON p.PatientID = mr.PatientID
		INNER JOIN VitalSign vs
		ON mr.RecordID = vs.RecordID

-- View for displaying admitted patients
-- DROP VIEW vw_PatientAdmitted	
CREATE VIEW vw_PatientAdmitted
AS
	SELECT CONCAT(p.PatientFName, ' ', p.PatientLName)[Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		mr.Diagnosis,
		mr.Prescription,
		mr.RecordDate,
		(SELECT n.NurseFName + ' ' + n.NurseLName
		FROM Nurse n
		WHERE n.NurseID = a.NurseID) [Nurse Assigned],
		a.AdmitDate,
		a.DischargeDate
	FROM Patient p
		INNER JOIN MedicalRecord mr
		ON p.PatientID = mr.PatientID
		INNER JOIN Admit a
		ON mr.RecordID = a.RecordID

-- View for displaying patient test records
-- DROP VIEW vw_PatientTestRecords	
CREATE VIEW vw_PatientTestRecords
AS
	SELECT p.PatientID,
		CONCAT(p.PatientFName,' ', p.PatientLName) [Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		(Select CONCAT(d.DoctorFName,' ', d.DoctorLName)
		from Team9_Database.dbo.Doctor d
		where d.DoctorID = m.DoctorID) [Doctor],
		m.Diagnosis,
		m.Prescription,
		m.RecordDate,
		t.TestID,
		t.TestName,
		t.Description,
		t.Cost,
		te.[Result]
	FROM Team9_Database.dbo.Patient p
		INNER JOIN Team9_Database.dbo.MedicalRecord m ON p.PatientID = m.PatientID
		LEFT JOIN Team9_Database.dbo.Testing te ON m.RecordID = te.RecordID
		LEFT JOIN Team9_Database.dbo.Tests t ON te.TestID = t.TestID;

-- View for displaying patient bills
-- DROP VIEW vw_PatientBills
CREATE VIEW vw_PatientBills
AS
	WITH
		TestData
		AS
		(
			SELECT t.TestName, t.Cost, mr.RecordID
			FROM Tests t
				INNER JOIN Testing te
				ON t.TestID = te.TestID
				INNER JOIN MedicalRecord mr
				ON te.RecordID = mr.RecordID
		),
		MedData
		AS
		(
			SELECT m.Name, m.Cost, mr.RecordID
			FROM Medicine m
				INNER JOIN Medication md
				ON m.MedID = md.MedID
				INNER JOIN MedicalRecord mr
				ON md.RecordID = mr.RecordID
		)
	SELECT b.BillingID,
		p.PatientID,
		CONCAT(p.PatientFName,' ', p.PatientLName) [Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		(Select CONCAT(d.DoctorFName,' ', d.DoctorLName)
		from Team9_Database.dbo.Doctor d
		where d.DoctorID = m.DoctorID) [Doctor],
		m.RecordDate,
		m.AppointmentCost,
		STUFF((SELECT TOP 3
			', ' + tn.TestName + ' ($' + CAST(tn.Cost AS VARCHAR(10)) + ')'
		FROM TestData tn
		WHERE tn.RecordID = m.RecordID
		FOR XML PATH('')), 1, 2, '') AS Tests,
		STUFF((SELECT TOP 3
			', ' + md.Name + ' ($' + CAST(md.Cost AS VARCHAR(10)) + ')'
		FROM MedData md
		WHERE md.RecordID = m.RecordID
		FOR XML PATH('')), 1, 2, '') AS Medicines,
		b.RoomCost,
		b.OtherCharges,
		b.Total
	FROM Team9_Database.dbo.Patient p
		INNER JOIN Team9_Database.dbo.MedicalRecord m ON p.PatientID = m.PatientID
		INNER JOIN Team9_Database.dbo.Billing b ON m.RecordID = b.RecordID

-- View for displaying patient medicine records	
-- DROP VIEW vw_PatientMedicineRecords
CREATE VIEW vw_PatientMedicineRecords
AS
	SELECT p.PatientID,
		CONCAT(p.PatientFName,' ', p.PatientLName) [Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		(Select CONCAT(d.DoctorFName,' ', d.DoctorLName)
		from Team9_Database.dbo.Doctor d
		where d.DoctorID = m.DoctorID) [Doctor],
		m.Diagnosis,
		m.Prescription,
		m.RecordDate,
		md.MedID,
		md.Name,
		md.Brand,
		md.Description,
		md.Cost
	FROM Team9_Database.dbo.Patient p
		INNER JOIN Team9_Database.dbo.MedicalRecord m ON p.PatientID = m.PatientID
		LEFT JOIN Team9_Database.dbo.Medication med ON m.RecordID = med.RecordID
		LEFT JOIN Team9_Database.dbo.Medicine md ON med.MedID = md.MedID;

-- View for displaying hospital details and health force
-- DROP VIEW vw_HospitalManagement	   
CREATE VIEW vw_HospitalManagement
AS
	SELECT h.HospitalName,
		h.Address,
		h.City,
		h.State,
		h.Zipcode,
		h.ContactNo,
		h.Email,
		d.DepartmentName,
		CONCAT(dr.DoctorFName,' ',dr.DoctorLName) [Doctor],
		CONCAT(n.NurseFName,' ',n.NurseLName) [Nurse]
	FROM Hospital h
		INNER JOIN HospitalDepartment hd
		ON h.HospitalID = hd.HospitalID
		INNER JOIN Department d
		ON hd.DepartmentID = d.DepartmentID
		LEFT JOIN Doctor dr
		ON hd.HosDepID = dr.HosDepID
		LEFT JOIN Nurse n
		ON hd.HosDepID = n.HosDepID;

-- View for displaying doctor information
-- DROP VIEW vw_DoctorInfo
CREATE VIEW vw_DoctorInfo
AS
	SELECT CONCAT(dr.DoctorFName, ' ', dr.DoctorLName) AS DoctorName,
		dr.Gender,
		dr.ContactNo,
		hd.HosDepID,
		d.DepartmentName,
		d.DepartmentHead,
		h.HospitalName,
		h.Address [Hospital Address],
		h.ContactNo [Hospital ContactNo]
	FROM Doctor dr
		JOIN HospitalDepartment hd
		ON dr.HosDepID = hd.HosDepID
		JOIN Department d
		ON hd.DepartmentID = d.DepartmentID
		JOIN Hospital h
		ON hd.HospitalID = h.HospitalID

-- View for displaying nurse information
-- DROP VIEW vw_NurseInfo
CREATE VIEW vw_NurseInfo
AS
	SELECT CONCAT(n.NurseFName,' ', n.NurseLName) AS NurseName,
		n.Gender,
		n.ContactNo,
		hd.HosDepID,
		d.DepartmentName,
		d.DepartmentHead,
		h.HospitalName,
		h.Address [Hospital Address],
		h.ContactNo [Hospital ContactNo]
	FROM Nurse n
		JOIN HospitalDepartment hd
		ON n.HosDepID = hd.HosDepID
		JOIN Department d
		ON hd.DepartmentID = d.DepartmentID
		JOIN Hospital h
		ON hd.HospitalID = h.HospitalID