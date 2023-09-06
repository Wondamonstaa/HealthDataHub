/* The following query allows to retreive the description of a patient's current health status using patient's ID.
The final report contains no duplicates for diseases' description for one patient, i.e., if the diagnoses are the same
for one patient, and the description is the same, duplicates will be removed. If a patient has no diseases or descriptions of it, 
then the default NULL value will be used for that column. 
Type: Join*/

SELECT DISTINCT p.Patient_ID AS PID, p.Name, hr.Description
FROM Patient p
LEFT JOIN HealthRecord hr ON p.Patient_ID = hr.Patient_ID
ORDER BY PID ASC;
