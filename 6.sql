/*
The following query allows to calculate the total number of invoices and the amount paid by patients.
Then, it produces the number of invoices which were not covered in full, and, finally, the amount of money owed to a hospital.
Type: Aggregation*/

SELECT 
    (SUM(Paid_Amount) + '$') AS Total_Paid,
    /*Simply counts the number of invoices in the DB*/
    COUNT(*) AS Num_Of_Invoices,
    COUNT(
    CASE 
    /*The comparison between the actual amount paid, and what had to be charged*/
    WHEN Paid_Amount < (RoomCharge + InstructionCharge) 
    THEN TRUE END) AS Num_Of_Unpaid_Invoices, /*Produces the number of unpaid invoices*/
    (SUM(RoomCharge) + SUM(InstructionCharge)) - SUM(Paid_Amount) AS Amount_Owed
FROM Invoice
ORDER BY Total_Paid ASC;

