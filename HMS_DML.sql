----------------------------------------------------INSERT STATEMENTS FOR TABLES---------------------------------------------------
-- Insert query for adding data in Hospital table

INSERT INTO dbo.Hospital
	(HospitalName, Address, Zipcode, Phone, Email, City, State)
VALUES
	('Cedar Sinai Medical Center', '8700 Beverly Blvd', '90048', '1555123456', 'info@csmc.com', 'Los Angeles', 'CA'),
	('Mount Sinai Hospital', '1500 S Fairfield Ave', '60608', '1555234567', 'info@sinai.com', 'Chicago', 'IL'),
	('Johns Hopkins Hospital', '1800 Orleans St', '21287', '1555345678', 'info@jhmi.com', 'Baltimore', 'MD'),
	('Massachusetts General Hospital', '55 Fruit St', '02114', '1555456789', 'info@mgh.harvard.com', 'Boston', 'MA'),
	('Brigham and Women''s Hospital', '75 Francis St', '02115', '1555567890', 'info@bwh.harvard.com', 'Boston', 'MA'),
	('New York-Presbyterian Hospital', '525 E 68th St', '10065', '1555678901', 'info@nyp.com', 'New York', 'NY'),
	('Mayo Clinic', '200 1st St SW', '55905', '1555789012', 'info@mayoclinic.com', 'Rochester', 'MN'),
	('Hospitals-Michigan Medicine', '1500 E Medical Center Dr', '48109', '1555901234', 'info@umich.com', 'Ann Arbor', 'MI'),
	('UCSF Medical Center', '505 Parnassus Ave', '94143', '1555012345', 'info@ucsfhealth.com', 'San Francisco', 'CA'),
	('Duke University Hospital', '2301 Erwin Rd', '27710', '1555123456', 'info@duke.com', 'Durham', 'NC');

-- Insert query for adding data in Department table-----

INSERT INTO dbo.Department
	(DepartmentName, DepartmentHead)
VALUES
	('Cardiology', 'John Smith'),
	('Neurology', 'Jane Johnson'),
	('Orthopedics', 'Robert Williams'),
	('Pediatrics', 'Sarah Lee'),
	('Oncology', 'David Davis'),
	('Dermatology', 'Michael Brown'),
	('Radiology', 'Susan Lee'),
	('Gynecology', 'Jennifer Jackson'),
	('Psychiatry', 'William Wilson'),
	('Endocrinology', 'Karen Lee');

-- Insert query for adding data in HospitalDepartment, this data is used to map hospital and department

INSERT INTO dbo.HospitalDepartment
	(HospitalID, DepartmentID)
VALUES
	(28, 1),
	(29, 1),
	(30, 1),
	(31, 1),
	(32, 1),
	(33, 1),
	(34, 1),
	(35, 1),
	(36, 1),
	(28, 2),
	(29, 2),
	(30, 2),
	(31, 2),
	(32, 2),
	(33, 2),
	(34, 2),
	(35, 2),
	(36, 2),
	(28, 3),
	(29, 3),
	(30, 3),
	(31, 3),
	(32, 4),
	(33, 4),
	(34, 4),
	(35, 4),
	(36, 4),
	(28, 5),
	(29, 5),
	(30, 5),
	(31, 5),
	(32, 5),
	(33, 6),
	(34, 6),
	(35, 6),
	(36, 6),
	(28, 7),
	(29, 7),
	(30, 7),
	(31, 7),
	(32, 8),
	(33, 8),
	(34, 8),
	(35, 9),
	(36, 9);

-- Insert query for adding data in doctor table----

INSERT INTO dbo.Doctor
	(HosDepID, DoctorFName, DoctorLName, Gender, ContactNo)
VALUES
	(1, 'John', 'Doe', 'M', '5551234567'),
	(31, 'Jane', 'Smith', 'F', '5555678901'),
	(2, 'Bob', 'Johnson', 'M', '5552468013'),
	(44, 'Sarah', 'Lee', 'F', '5551357902'),
	(18, 'Mike', 'Brown', 'M', '5557890123'),
	(12, 'Emily', 'Davis', 'F', '5553698701'),
	(7, 'Adam', 'Wilson', 'M', '5550246813'),
	(19, 'Samantha', 'Taylor', 'F', '5552468013'),
	(20, 'Peter', 'Chen', 'M', '5558023456'),
	(23, 'Lisa', 'Garcia', 'F', '5559753102');

-- Insert query for adding data in Nurse table-----

INSERT INTO dbo.Nurse
	(HosDepID, NurseFName, NurseLName, Gender, ContactNo)
VALUES
	(2 , 'Lisa', 'Brown', 'F', '8571234432'),
	(3 , 'Mark', 'Johnson', 'M', '8544234432'),
	(7 , 'Julie', 'Smith', 'F', '9971278432'),
	(9 , 'Andrew', 'Lee', 'M', '8588230909'),
	(13 , 'Emily', 'Williams', 'F', '1271234432'),
	(18 , 'Richard', 'Davis', 'M', '8881234432'),
	(21 , 'Karen', 'Wilson', 'F', '8571214432'),
	(22 , 'Jennifer', 'Garcia', 'F', '9091333432'),
	(34 , 'Thomas', 'Brown', 'M', '8577774432'),
	(41 , 'Laura', 'Clark', 'F', '2271330032');

-- Insert query for adding data in Tests table-----

INSERT INTO dbo.Tests
	(TestName, [Description], Cost)
VALUES
	('Urine Test', 'Checks various urine levels', 50.00),
	('X-Ray', 'Examines bones and organs', 200.00),
	('MRI', 'Produces detailed images of organs', 500.00),
	('Blood Test', 'Checks various blood levels', 50.00),
	('CT Scan', 'Examines bones and organs with X-rays', 400.00),
	('Echocardiogram', 'Examines the heart', 300.00),
	('Stress Test', 'Monitors the heart while exercising', 250.00),
	('Colonoscopy', 'Examines the colon and rectum', 600.00),
	('Hair Follicle', 'Examines the condition of hair follicles', 500.00),
	('Ultrasound', 'Produces images using high-frequency sound waves', 150.00);

-- Insert query for adding data in Medicine table-----

INSERT INTO dbo.Medicine
	([Name], Brand, [Description], Cost)
VALUES
	('Aspirin', 'Bayer', 'Pain reliever and fever reducer', 10.00),
	('Lisinopril', 'Zestril', 'Treats high blood pressure and heart failure', 20.00),
	('Metformin', 'Glucophage', 'Treats type 2 diabetes', 15.00),
	('Fluoxetine', 'Prozac', 'Treats depression and anxiety', 25.00),
	('Ibuprofen', 'Advil', 'Pain reliever and fever reducer', 10.00),
	('Lorazepam', 'Ativan', 'Treats anxiety and seizure disorders', 30.00),
	('Prednisone', 'Deltasone', 'Treats inflammation and autoimmune disorders', 18.00),
	('Chemotherapy', 'Various', 'Treats cancer', 100.00),
	('Dialysis', 'Various', 'Treats kidney failure', 500.00),
	('Topiramate', 'Topamax', 'Treats seizures and migraine headaches', 35.00);

--Insert query for adding data in InsurancePlan table-------

INSERT INTO Team9_Database.dbo.InsurancePlan
	(PlanCode, CompanyName, ContactNo, Email, InsuranceDate)
VALUES
	(1001, 'Acme Insurance Group', 1234567890, 'info@acmeinsurancegroup.com', '2022-01-01'),
	(1002, 'Liberty Mutual Insurance', 2345678901, 'support@libertymutual.com', '2022-02-01'),
	(1003, 'Allstate Insurance Company', 3456789012, 'contact@allstate.com', '2022-03-01'),
	(1004, 'Nationwide Mutual Insurance', 4567890123, 'customerservice@nationwide.com', '2022-04-01'),
	(1005, 'Progressive Corporation', 5678901234, 'feedback@progressive.com', '2022-05-01'),
	(1006, 'Geico Insurance', 6789012345, 'support@geico.com', '2022-06-01'),
	(1007, 'State Farm Insurance', 7890123456, 'customerservice@statefarm.com', '2022-07-01'),
	(1008, 'Travelers Insurance', 8901234567, 'contact@travelers.com', '2022-08-01'),
	(1009, 'USAA Insurance', 9012345678, 'info@usaa.com', '2022-09-01'),
	(1010, 'Chubb Insurance', 1234567890, 'feedback@chubb.com', '2022-10-01');


----Inserting 10 rows in Patient table------------------------

INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(18, 'John', 'Wick', '1998-06-25', convert(varbinary, '7899004533'), convert(varbinary, 'john@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(14, 'Jason', 'Durelo', '1993-06-19', convert(varbinary, '76000904533'), convert(varbinary, 'jason@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(18, 'David', 'Lee', '1998-06-25', convert(varbinary, '7896234533'), convert(varbinary, 'david@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(18, 'David', 'Lee', '1998-06-25', convert(varbinary, '7896234533'), convert(varbinary, 'david@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(19, 'Sarah', 'Kim', '1992-09-18', convert(varbinary, '3453452211'), convert(varbinary, 'sarah@info.com'), 'F');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(20, 'Michael', 'Garcia', '1977-07-03', convert(varbinary, '8679092211'), convert(varbinary, 'mick@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(21, 'Emily', 'Davis', '1996-11-08', convert(varbinary, '8907776555'), convert(varbinary, 'emily@info.com'), 'F');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(14, 'Alex', 'Wilson', '2001-04-22', convert(varbinary, '2349880909'), convert(varbinary, 'alex@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(16, 'Olivia', 'Brown', '1988-08-11', convert(varbinary, '8798779090'), convert(varbinary, 'olivia@info.com'), 'F');

----Inserting 10 row in Address table----------------------------- 

INSERT INTO Address
	(PatientId, StreetAddress, City, States, ZipCode)
VALUES
	(31, '123 Main St', 'New York', 'NY', '10001'),
	(32, '456 Elm St', 'Los Angeles', 'CA', '90001'),
	(39, '789 Oak St', 'Chicago', 'IL', '60601'),
	(40, '234 Maple St', 'Houston', 'TX', '77001'),
	(41, '567 Pine St', 'Phoenix', 'AZ', '85001'),
	(42, '890 Cedar St', 'Philadelphia', 'PA', '19101'),
	(43, '123 Walnut St', 'San Francisco', 'CA', '94101'),
	(44, '456 Chestnut St', 'Boston', 'MA', '02101'),
	(50, '789 Spruce St', 'Dallas', 'TX', '75201'),
	(51, '234 Birch St', 'Atlanta', 'GA', '30301');

-----Inserting 10 row in Medical Record table------------------------------

INSERT INTO dbo.MedicalRecord
	(PatientID, DoctorID, Diagnosis, Prescription, AppointmentCost, RecordDate)
VALUES
	(31, 1, 'Asthma', 'Albuterol', 200.00, '2022-02-05'),
	(32, 2, 'Eczema', 'Hydrocortisone', 175.00, '2022-03-10'),
	(39, 3, 'Flu', 'Tamiflu', 125.00, '2022-04-15'),
	(40, 4, 'Hypertension', 'Lisinopril', 150.00, '2022-01-01'),
	(41, 5, 'Type 2 Diabetes', 'Metformin', 200.00, '2022-01-02'),
	(42, 6, 'Depression', 'Fluoxetine', 175.00, '2022-01-03'),
	(43, 2, 'Breast Cancer', 'Surgery', 500.00, '2022-01-04'),
	(44, 7, 'Migraine', 'Topiramate', 125.00, '2022-01-05'),
	(50, 9, 'Arthritis', 'Ibuprofen', 100.00, '2022-01-06'),
	(51, 10, 'Anxiety', 'Lorazepam', 225.00, '2022-01-07');

-------Inserting 10 row in Testing table------------------------------------

INSERT INTO dbo.Testing
	(RecordID, TestID, Result)
VALUES
	(1, 14, 'Abnormal'),
	(1, 15, 'Normal'),
	(2, 16, 'Abnormal'),
	(3, 17, 'Normal'),
	(3, 18, 'Abnormal'),
	(2, 19, 'Abnormal'),
	(3, 20, 'Normal'),
	(4, 21, 'Abnormal'),
	(5, 22, 'Normal'),
	(6, 23, 'Abnormal');

-------Inserting 10 row in Medication table------------------------------------

INSERT INTO dbo.Medication
	(RecordID, MedID)
VALUES
	(1, 2),
	(2, 3),
	(3, 4),
	(4, 6),
	(5, 1),
	(6, 5),
	(7, 8),
	(8, 9),
	(9, 10),
	(10, 1);

-----Inserting 10 rows in Vital Sign table--------------------------------

INSERT INTO VitalSign
	(RecordID, Temperature, RespirationRate, PulseRate, BloodPressure, Weight, Height)
VALUES
	(1, 98, 16, 80, 120, 150, 65),
	(2, 99, 18, 75, 110, 160, 68),
	(3, 100, 20, 85, 130, 170, 71),
	(4, 98, 16, 90, 140, 160, 70),
	(5, 99, 18, 78, 120, 155, 67),
	(6, 100, 20, 82, 130, 165, 72),
	(7, 98, 16, 88, 125, 158, 69),
	(8, 99, 18, 80, 115, 152, 66),
	(9, 100, 20, 90, 135, 172, 73),
	(10, 98, 16, 85, 130, 162, 68);

-----Inserting 10 rows in Billing table--------------------------------

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(1, '2023-04-07', 50.00, 10.00, 'Cash');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(2, '2023-04-08', 75.00, 20.00, 'Credit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(3, '2023-04-09', 0.00, 5.00, 'Debit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(4, '2023-04-10', 100.00, 30.00, 'Cash');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(5, '2023-04-11', 25.00, 5.00, 'Credit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(6, '2023-03-07', 150.00, 20.00, 'Debit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(7, '2023-02-07', 75.00, 10.00, 'Cash');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(8, '2023-01-07', 50.00, 15.00, 'Credit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(9, '2023-04-12', 0.00, 0.00, 'Debit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(10, '2023-04-13', 100.00, 25.00, 'Cash');

-----Inserting 10 rows in Admit table----------------------------------

INSERT INTO Team9_Database.dbo.Admit
	(RecordID, NurseID, AdmitDate, DischargeDate)
VALUES
	(1, 2, '2022-01-01', '2022-01-05'),
	(2, 4, '2022-02-01', '2022-02-02'),
	(3, 9, '2022-03-01', '2022-03-04'),
	(4, 3, '2022-04-01', '2022-04-03'),
	(5, 5, '2022-05-01', '2022-05-01'),
	(6, 7, '2022-06-01', '2022-06-03'),
	(7, 2, '2022-07-01', '2022-07-06'),
	(8, 3, '2022-08-01', '2022-08-02'),
	(9, 8, '2022-09-01', '2022-09-04'),
	(10, 5, '2022-10-01', NULL);

