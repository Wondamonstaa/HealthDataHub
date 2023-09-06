/*The following query allows to calculate the total amount of fees charged for each of the patients in the DB specifically.
For those patients who have not got charged for procedures or rooms yet for whatever reason is, the Total column should display NULL.
Type: Aggregation*/

SELECT p.Patient_ID, p.Name AS Patient, SUM(i.Fee) AS Total
FROM Patient p
LEFT JOIN Invoice v ON p.Patient_ID = v.Patient_ID
LEFT JOIN Instruction i ON v.Invoice_ID = i.Invoice_ID
GROUP BY p.Patient_ID, p.Name
ORDER BY Patient_ID ASC;
