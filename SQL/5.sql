/* 
The following query allows to retreive the data about those patients who covered their invoices in full, and currently free of any charges.
Type: Nested*/

SELECT p.Name AS Patient_Name, i.Paid_Date, i.Paid_Amount
FROM Patient p
INNER JOIN Invoice i ON p.Patient_ID = i.Patient_ID
WHERE i.Paid_Amount >= (
  /*By doing so, we check if the patient is covered the invoice in full or overpaid*/
  /*In both cases, the hospital is safe, so the patient is good*/
  SELECT SUM(InstructionCharge)
  FROM Invoice 
  WHERE Patient_ID = p.Patient_ID
)
ORDER BY Paid_Amount ASC;
