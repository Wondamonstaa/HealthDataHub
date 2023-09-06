/*
The following query is based on the early lectures we covered this semester, and used to 
simply retreive the patients data from the DB.
Type: Nested */

SELECT p.Name AS Patient, p.Phone AS Phone_Num, h.Date, h.Disease
FROM Patient p
INNER JOIN HealthRecord h ON p.Patient_ID = h.Patient_ID
WHERE h.Date = (
  SELECT MAX(Date)
  FROM HealthRecord
  WHERE Patient_ID = p.Patient_ID
)
ORDER BY Patient ASC;
