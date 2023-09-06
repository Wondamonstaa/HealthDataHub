/* The following query allows to retreive the most expensive procedures assigned to patients,
and then calculate the final price for them by taking the subtotal, finding the tax using it, assuming that the tax is 
11.75% in Chicago, IL, and then producing the total amount a patient owes for a procedure;
Type: Nested. */

SELECT p.Patient_ID AS PID, p.Name AS Patient, i.Description AS Procedure_Name, i.Fee AS Subtotal,
(i.Fee * 0.1175) AS Tax, /*I used 11.75% which is the Illinois tax*/
(i.Fee * 1.1175) AS Total /*Total = sub + tax*/
FROM Patient p
LEFT JOIN Invoice inv ON p.Patient_ID = inv.Patient_ID
LEFT JOIN Instruction i ON inv.Invoice_ID = i.Invoice_ID
WHERE i.Fee = (
  SELECT MAX(Fee) 
  FROM Instruction
  WHERE Invoice_ID = inv.Invoice_ID
)
ORDER BY Total DESC;

