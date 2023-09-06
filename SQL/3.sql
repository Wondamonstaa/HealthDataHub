/*
The following query is used to determine the average amount of medication the patients received,
and then find out by which percentage it exceeds the reasonable limits using the formula.
Type: Aggregation*/

SELECT 
    AVG(m.Amount) AS Avg_Dosage,
    /*
    I assume that the exceed_level should not be more than 5.
    Thus:
    5 - 100% (The max)
    AVG(m.Amount) = x
    
    x = (AVG(m.Amount) - 5) * 100 / 5 = the % by which we exceed 5%
    */
    (AVG(m.Amount) - 5) / 5 * 100 AS Exceed_Level,
    CASE
        WHEN (AVG(m.Amount) - 5) / 5 * 100 > 5 THEN 'Alert'
        ELSE 'Clean'
    END AS Status
FROM Medication m;

