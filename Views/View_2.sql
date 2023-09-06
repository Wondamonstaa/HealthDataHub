/*Drops the table if it already exists*/
DROP VIEW IF EXISTS Invoice_Analysis;
CREATE VIEW Invoice_Analysis AS
SELECT p.Patient_ID AS PID, p.Name AS Patient, p.Address AS Address, p.Phone AS Phone_Num, i.Invoice_ID, (i.RoomCharge + i.InstructionCharge) AS Total, i.Paid_Amount AS Paid,i.Paid_Date AS Date,
	/*Allows to run the if-else statement: in this case, if the amount paid = to the amount owed, then the patient paid in full, and the transcaction was approved*/
       CASE
		   /*https://learn.microsoft.com/en-us/sql/t-sql/language-elements/case-transact-sql?view=sql-server-ver16*/
           WHEN ((i.RoomCharge + i.InstructionCharge) = i.Paid_Amount && i.Paid_Amount - (i.RoomCharge + i.InstructionCharge) = 0) 
           THEN 'Approved'
           /*Otherwise, the transaction was rejected, as well as patient failed to cover his invoice in full*/
           ELSE 'Rejected'
       END AS Status
FROM Patient p
JOIN Invoice i ON p.Patient_ID = i.Patient_ID
ORDER BY Status ASC;




