DROP TRIGGER IF EXISTS InvoiceTotal;
DELIMITER //
CREATE TRIGGER InvoiceTotal
BEFORE INSERT ON Invoice
FOR EACH ROW
BEGIN
SET NEW.Paid_Amount = NEW.RoomCharge + NEW.InstructionCharge;
END;
//
DELIMITER ;

/*Test*/
INSERT INTO Invoice (Invoice_ID, Patient_ID, RoomCharge, InstructionCharge, Paid_Date)
VALUES (10, 3, 120, 180, '2023-07-29');
