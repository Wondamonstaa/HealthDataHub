/* The following query calculates the number of health records existing in the DB for each patient.
If the number of health records exceeds 3, this, in our case, will be a sign for placing such a patient 
in a high-risk group, thus, we murk such patient's Risk_Estimate as High in a separate column. Otherwise, low.
Type: Aggregation*/

SELECT h.Patient_ID, COUNT(HRID) AS Num_Of_HRDs,
CASE WHEN COUNT(HRID) > 3 
THEN 'High' 
ELSE 'Low' 
END AS Risk_Estimate
FROM HealthRecord h
GROUP BY Patient_ID
ORDER BY Risk_Estimate ASC;

