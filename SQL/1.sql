/*The following query allows to get the IDs of all nurses, their certification numbers, instruction codes from Instruction, 
and the instructions that physicians assigned to them to complete
Type: Join*/
SELECT n.NID, n.Certification_NUM, i.Code, i.Description
FROM Nurse n
/*We use all rows from both tables: 
https://www.geeksforgeeks.org/sql-join-set-1-inner-left-right-and-full-joins/*/
INNER JOIN Executes e ON n.NID = e.NID
INNER JOIN Instruction i ON e.Code = i.Code
ORDER BY NID ASC;
