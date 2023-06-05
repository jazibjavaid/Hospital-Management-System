# Hospital-Management-System

<b>I. Mission Statement</b>


The healthcare industry has always faced the challenge of consolidating patient data and healthcare information in one place. Unfortunately, this usually results in the loss or mismanagement of critical information and may hinder the delivery of effective and timely care. In this project, we aim to provide a comprehensive and integrated database system for a healthcare management system to improve patient information management efficiency. Furthermore, this database system has the potential to be employed on an international scale in order to keep up with the modern demands of public health.
The following challenges will be addressed by the developed healthcare management system:

• <b>Management of patient information: </b>typically, healthcare providers rely on paper-based records or multiple systems to store patient data. This makes it challenging for providers to maintain accurate and up-to-date records, leading to errors and inefficiencies in the care delivery process. The Healthcare Management System will centralize all patient data, making it easy to access and update for all authorized healthcare providers. Furthermore, moving from paper-based records to an online storage system can reduce unnecessary expenses for health centers.

• <b>Limited access to patient data: </b>Healthcare providers need immediate access to a patient's medical history, including prior diagnoses, treatments, and medications. This information is difficult to access, leading to incomplete or inaccurate patient data. The Healthcare Management System will enhance the accessibility of healthcare providers to patient data, which is critical when rapid clinical decisions have to be made, such as in emergency cases.

• <b>Fragmented healthcare system: </b>Healthcare providers may work across multiple hospitals or clinics with numerous designs to manage patient information. This can cause various difficulties in sharing information, leading to delays in treatment and poor quality of services. The Healthcare Management System will facilitate the sharing of patient information between different healthcare centers, which has the capability to be employed on an international scale for multiple hospitals.

• <b>Inefficient appointment scheduling: </b>Scheduling appointments can be time-consuming as healthcare providers rely on paper-based or manual systems. The Healthcare Management System will provide an automated appointment scheduling system, reducing the administrative burden on providers and improving the patient experience.

Overall, the Healthcare Management System not only improves patient information management and the quality of health services but also reduces inefficiencies in the healthcare system. By providing straightforward access to patient data, enhancing appointment scheduling, and facilitating information sharing, we aim to provide a system that will benefit both patients and healthcare providers.


<b>II. Business Rules:</b>

● Each patient needs to be registered

● Each patient has an address assigned

● Each patient can or cannot have an insurance plan

● Each patient can have multiple medical records

● Each department can have multiple doctors

● Each department can have multiple nurses

● Each hospital can have multiple departments

● A doctor can add diagnosis in a medical record for patient

● A doctor can prescribe medicines to patient

● A doctor can prescribe tests to patient

● A patient can be admitted to the hospital

● Nurse will be assigned to the admitted patient

● Each bill will be assigned for a medical record

● Each medical record will have a vital sign


<b>III. Design Decisions:</b>

<table>
<th>
<td>
Entity Name
</td>
<td>
Why Entity Included?
</td>
<td>
How is Entity Related to other entities?
</td>
</th>
<tr>
<td>
1
</td>
<td>
Patient
</td>
<td>
The primary purpose of our database is to store the details of patient, medical records, insurance, etc. Patient entity is maintain information about the patient such as name, dob, phone, email, age.
</td>
<td>
Patient entity’s primary key PatientID relates to Medical Record, Address, Insurance. A patient can have multiple cases and hence Patient has a one-to-many relationship with Medical Record
</td>
</tr>
<tr>
<td>2</td>
<td>
Medical Record
</td>
<td>
Every time a patient visits a hospital, a medical record is created. This record stores diagnosis, prescription, cost and timestamp of the record.
</td>
<td>
It is a core entity of the database, Medical Record’s primary key RecordID relates it to Admit, VitalSign, Testing, Medication entities. It also contains DoctorID as foreign key as a doctor is assigned to a particular case/record of the patient.
</td>
</tr>
<tr>
<td>3</td>
<td>
Vital Sign
</td>
<td>
Every time a patient visits a hospital, its vital signs are taken and are linked with the medical record. The vital sign entity stores temperature, respiratoryrate, pulserate, bloodpressure, weight, height
</td>
<td>
Vital Sign Entity’s is linked with Medical record with RecordID foreign key which is also the primary key of Vital Sign entity. Every medical record generated will have one vital sign
</td>
</tr>
<tr>
<td>4</td>
<td>
Doctor
</td>
<td>
Doctor entity is to maintain information about the doctor such as name, department name and hospital name
</td>
<td>
Doctor entity’s primary key DoctorID is linked with medical record. Each doctor can be assigned to multiple patients, hence doctor has one to many relationship with medical record. Each doctor is assigned to a department
</td>
</tr>
<tr>
<td>5</td>
<td>
Department
</td>
<td>
Department entity is to maintain information about the medical department such as department name and hospital name
</td>
<td>
Department entity’s primary key DepartmentID is linked with doctor entity. Each department can have multiple doctors, hence department has one to many relationship with doctor. Each department is assigned to a hospital
</td>
</tr>
<tr>
<td>6</td>
<td>
Hospital
</td>
<td>
Hospital entity is to main information about the hospital such as hospital name and address including city, state and zip code
</td>
<td>
Hospital entity’s primary key HospitalID is linked with department through an associative entity since each hospital can have multiple departments and each department can be a part of multiple hospitals
</td>
</tr>
<tr>
<td>7</td>
<td>
Hospital Department
</td>
<td>
Hospital Department is an associative entity that connects the department entity with the hospital entity
</td>
<td>
Hospital Department entity has many to one relationship with hospital entity and department entity
</td>
</tr>
<tr>
<td>8</td>
<td>
Nurse
</td>
<td>
Nurse entity is created to store details of the nurse like name, department
</td>
<td>
Nurse entity’s primary key NurseID is foreign key for admit entity as a particular nurse will be assigned to the admitted patient
</td>
</tr>
<tr>
<td>9</td>
<td>
Admit
</td>
<td>
Admit entity is created to store details of those patients that have been admitted in the hospital. It contains record id of the admitted patient and nurse id of the assigned nurse along with admit time and date
</td>
<td>
Admit entity is linked with Medical record entity using RecordID foreign key. It is also linked with the nurse entity with NurseID foreign key
</td>
</tr>
<tr>
<td>10</td>
<td>
Tests
</td>
<td>
Test Report entity contains details about test details, its
cost, and results
</td>
<td>
Multiple tests can be assigned to a patient for a
medical record. That’s why we created a associative entity Testing to map record with tests
</td>
</tr>
<tr>
<td>11</td>
<td>
Testing
</td>
<td>
Testing entity is created to establish a valid connection between Medical Record and Tests to avoid many to many relationship. The entity also contains the results for a particular test
</td>
<td>
Testing is a associative entity to model many to many relationship between Medical Record and Tests entity. RecordID and TestID would be combined primary key for each test result
</td>
</tr>
<tr>
<td>12</td>
<td>
Medicine
</td>
<td>
Medicine entity is created to store details of medicine that can be prescribed to a patient for a medical record
</td>
<td>
Medicine entity’s primary key MedicineID relates it to Medication entity
</td>
</tr>
<tr>
<td>13</td>
<td>
Medication
</td>
<td>
Medication entity is created to establish a valid connection between Medicine and Medical Record
</td>
<td>
It is a staging entity to model many to many relationship
</td>
</tr>
<tr>
<td>14</td>
<td>
Billing
</td>
<td>
Billing entity is created to maintain billing details for a medical record. It has attributes like billing date, total cost, payment mode
</td>
<td>
Billing is related to Medical Record entity through RecordID which is primary key in Record entity and a foreign key in Billing. It has a one-to-one relationship with Record entity
</td>
</tr>
<tr>
<td>15</td>
<td>
Insurance Plan
</td>
<td>
Insurance Plan entity is created to store details of a insurance plan and member id for a particular patient
</td>
<td>
Insurance Plan entity’s primary key InsuranceId relates to Patient entity and has one to one relationship
</td>
</tr>
<tr>
<td>16</td>
<td>
Address
</td>
<td>
Address entity is created to maintain address of the patient
</td>
<td>
Address entity is related to Patient entity through the foreign key PatientID which is also a primary key here
</td>
</tr>
</table>