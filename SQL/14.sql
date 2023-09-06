/* The following query allows to retreive the ID and name of the patient with the highest 
invoice balance, which is calculated by adding the subtotal (Before tax) amount + tax = 0.1175 = 11.75%. 
Type: Join*/

SELECT p.Patient_ID AS PID, p.Name AS Patient, (SUM(i.RoomCharge + i.InstructionCharge) + 0.1175 * SUM(i.RoomCharge + i.InstructionCharge)) AS Total
FROM Patient p
LEFT JOIN Invoice i ON p.Patient_ID = i.Patient_ID GROUP BY p.Patient_ID
ORDER BY Total DESC
LIMIT 1;
