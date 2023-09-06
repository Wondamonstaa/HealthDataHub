/* The following query allows to get the patients' health records from the DB, and 
analyze some of them by specifically providing the name of a disease that must be present in a record. 
Some patients repeat twice in the produced table: the garbage values were added for testing purposes.
Type: Nested.*/

SELECT p.Patient_ID AS PID, p.Name AS Patient, hr.Disease, hr.Description
FROM Patient p
INNER JOIN HealthRecord hr ON p.Patient_ID = hr.Patient_ID
WHERE hr.Disease IN ('Colon cancer','COVID-19', 'Diabetes', 'Pneumonia')
ORDER BY Disease ASC;
