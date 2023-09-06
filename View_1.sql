/*Drops the table if it already exists*/
DROP VIEW IF EXISTS Full_Health_Record_Of_Patients;
CREATE VIEW Full_Health_Record_Of_Patients AS
SELECT 
  /*Patient => Disease => Doctor*/
  p.Patient_ID AS PID, p.Name AS Patient, p.Address AS Address, p.Phone AS Phone,
  /*I have chosen not to display health record ID since it provides no necessary info for a regular observer*/
  h.Disease, h.Description, h.Date, h.Status,
  ph.PhID, s.Name AS Physician, s.Phone AS Ph_Phone
FROM Patient p 
/*https://learn.microsoft.com/en-us/office/client-developer/access/desktop-database-reference/left-join-right-join-operations-microsoft-access-sql*/
LEFT JOIN HealthRecord h ON p.Patient_ID = h.Patient_ID
LEFT JOIN Physician ph ON p.Patient_ID = ph.PhID
LEFT JOIN Hospital_Staff s ON ph.Certification_NUM = s.Certification_NUM
ORDER BY p.Patient_ID ASC;




