/* The following query allows to get the names of physicians as well as their certificate numbers for identification, field of occupacy, 
and the name of a patient they are currently monitoring.
Type: Join*/

SELECT DISTINCT h.Name AS Physician,
    h.Certification_NUM AS Certificate_NUM,
    p.Field AS Discipline,
    p1.Name AS Patient
FROM Physician p
JOIN Hospital_Staff h ON p.Certification_NUM = h.Certification_NUM
/*https://dev.mysql.com/doc/refman/8.0/en/join.html*/
LEFT JOIN Invoice i ON p.PhID = i.Invoice_ID
INNER JOIN Patient p1 ON i.Patient_ID = p1.Patient_ID
ORDER BY Physician ASC;

