/*Disable safe mode since I couldn't use some features for whatever reason is*/
SET SQL_SAFE_UPDATES = 0;

/*I drop the procedure if it exists for debugging purposes*/
DROP PROCEDURE IF EXISTS Exclude_Patient;

DELIMITER //
CREATE PROCEDURE Exclude_Patient(IN PID INT)
BEGIN
    DECLARE toPay INT;
    DECLARE paidAmount INT;
	
    SELECT (SUM(i.RoomCharge + i.InstructionCharge)) AS TotalAmount, (SUM(i.Paid_Amount)) AS PaidAmount
    FROM Invoice i
    WHERE i.Patient_ID = PID
    /*In these fields the result of the above operations will be redirected*/
    INTO toPay, paidAmount;

    /*If the invoice covered in full, then the info should be removed*/
    IF paidAmount >= toPay THEN
        DELETE FROM Invoice WHERE Patient_ID = PID;
        DELETE FROM HealthRecord WHERE Patient_ID = PID;
        DELETE FROM Patient WHERE Patient_ID = PID;
        
        SELECT CONCAT('The good patient  ', PID, ' paid all the debts and will be removed from the DB!') AS Success;
    ELSE
        SELECT CONCAT('Someone with the ID ', PID, ' forgot to pay the bills, and cannot be removed from the DB now.') AS Warning;
    END IF;
END//
DELIMITER ;


CALL Exclude_Patient(11);
CALL Exclude_Patient(12);
CALL Exclude_Patient(10);


