/* The following query allows to calculate the number of tasks performed by each nurse, 
and based on that number determine whether there work overload is present. Such analysis is crucial 
for the management in order to maximize their employees capabilities. 
Type: Aggregation.*/

SELECT 
    n.NID,
    n.Certification_NUM AS Certificate_NUM,
    COUNT(e.Code) AS Num_Of_Tasks,
    CASE 
        WHEN COUNT(e.Code) <= 5 
        THEN 'No'
        ELSE 'Yes'
    END AS Overload
FROM Nurse n
LEFT JOIN Executes e ON n.NID = e.NID
GROUP BY n.NID, n.Certification_NUM
ORDER BY Num_Of_Tasks DESC;

