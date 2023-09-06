/* The following query gets invoices' ID from the DB, accesses the amounts patients owe to the hospital, the amount 
that was already paid, and the difference between the first two, which results in the amount still owed to the hostpital. 
The last column simply states the status of a specific invoice transactions, whether it is paid in full or not.
Type: Simple Select*/

SELECT
  i.Invoice_ID AS IID,(i.RoomCharge + i.InstructionCharge) AS To_Pay,
  i.Paid_Amount AS Total_Paid,
  (i.InstructionCharge + i.RoomCharge - i.Paid_Amount) AS Total_Owed,
  CASE
    WHEN i.Paid_Amount = (i.RoomCharge + i.InstructionCharge) 
    THEN 'Paid'
    ELSE 'Not Paid'
  END AS iStatus
FROM Invoice i
ORDER BY Total_Owed DESC;

