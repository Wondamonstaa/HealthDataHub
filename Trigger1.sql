/*Drops the trigger if exists*/
DROP TRIGGER IF EXISTS UpdatedRoom_Charge;

DELIMITER //
CREATE TRIGGER UpdatedRoom_Charge
AFTER INSERT ON Invoice
FOR EACH ROW
BEGIN
    UPDATE Invoice
    SET RoomCharge = (SELECT Fee FROM Room WHERE RNumber = NEW.Patient_ID)
    WHERE Invoice_ID = NEW.Invoice_ID;
END;
//
DELIMITER ;






