DROP TRIGGER IF EXISTS Patient_Capacity_inRoom;
DELIMITER //
CREATE TRIGGER Patient_Capacity_inRoom
BEFORE INSERT ON Invoice
FOR EACH ROW
BEGIN
DECLARE room_capacity INT;
SELECT Capacity INTO room_capacity FROM Room WHERE RNumber = NEW.Patient_ID;
IF room_capacity <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Sorry, the room is already full!';
END IF;
END;
//
DELIMITER ;

