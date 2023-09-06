/*Drops the table if it already exists*/
DROP VIEW IF EXISTS Alert_If_Dosage_Abuse_Detected;
CREATE VIEW Alert_If_Dosage_Abuse_Detected AS
SELECT
    nest_Flagged.Patient_ID AS PID,
    nest_Flagged.Patient_Name AS Patient,
    /*Calculates the total number of drugs received by a patient*/
    SUM(nest_Flagged.Amount) AS Total,
    CASE
		/*If the flag was set to True, then "Alert" will appear in the last column. Otherwise, the status is "Clear"*/
        WHEN nest_Flagged.Flag = TRUE
        THEN 'Alert'
        ELSE 'Clear'
    END AS Overdose_Detected
FROM
	/*No duplicates will be present in the final view*/
    (SELECT DISTINCT p.Patient_ID, p.Name AS Patient_Name, med.Amount,
        CASE
            WHEN med.Amount >= 10 
            THEN (TRUE || 1)
            ELSE (FALSE || 0)
        END AS Flag
    FROM
        Patient p
	/*Here I count how much medication was given to a patient by nurses, and determine whether or not it exceeds the amount prescribed by a doctor*/
    LEFT JOIN Medication med ON p.Patient_ID = med.Patient_ID
    JOIN Nurse n ON med.NID = n.NID) AS nest_Flagged
    
GROUP BY nest_Flagged.Patient_ID, nest_Flagged.Patient_Name, nest_Flagged.Flag
ORDER BY total DESC;


