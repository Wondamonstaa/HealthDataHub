/*I drop the procedure if it exists for debugging purposes*/
DROP PROCEDURE IF EXISTS Incoming_Patient_Registration;

DELIMITER //
/*The following procedure is supposed to accept info from a DB operator when the patients' info becomes available*/
CREATE PROCEDURE Incoming_Patient_Registration(
    IN fullName VARCHAR(175), /*Might be more, but I stick to these values*/
    IN pAddress VARCHAR(300),
    IN contactPhone BIGINT
)
BEGIN
    START TRANSACTION;
    /*Here we insert a new record into the Patient table, as shown in the Lecture*/
    INSERT INTO Patient (Name, Address, Phone) VALUES (fullName, pAddress, contactPhone);
    COMMIT;
END//
DELIMITER ;

/*Function call to procedure*/
CALL Incoming_Patient_Registration('Moana', 'Hawaii', 12248439920);
CALL Incoming_Patient_Registration('Encanto', 'Colombia', 12247281932);
CALL Incoming_Patient_Registration('Ed Sheeran', 'England', 12249996547);
CALL Incoming_Patient_Registration('Hasbulla', 'Dagestan', 12248890761);
CALL Incoming_Patient_Registration('Zendaya', 'LA', 12247658901);
