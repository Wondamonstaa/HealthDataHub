/* The following query allows to access patient's name from DB, find out what kind of disease he/she has,
and its current status, which can be pending or done (Depends on the current treatment completness).
Type: Join*/

SELECT DISTINCT p.Name AS Patient, h.Disease, h.Status
FROM Patient p
JOIN HealthRecord h ON p.Patient_ID = h.Patient_ID
WHERE h.Status = 'Pending' && h.Disease IS NOT NULL
ORDER BY Name ASC;
