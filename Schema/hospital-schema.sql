DROP SCHEMA IF EXISTS `hospital` ;
CREATE SCHEMA IF NOT EXISTS `hospital`;
USE `hospital`;


/*Part 1: Patient => DONE*/
DROP TABLE IF EXISTS `hospital`.`Patient` ;
CREATE TABLE IF NOT EXISTS `hospital`.`Patient` (
  `Patient_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(90) NULL,
  `Address` VARCHAR(500) NULL,
  `Phone` BIGINT NULL,
  PRIMARY KEY (`Patient_ID`),
  UNIQUE INDEX `Patient_ID_UNIQUE` (`Patient_ID` ASC) )
ENGINE = InnoDB;


/*Part 2: Room => DONE*/
DROP TABLE IF EXISTS `hospital`.`Room` ;
CREATE TABLE IF NOT EXISTS `hospital`.`Room` (
  `RNumber` INT NOT NULL,
  `Capacity` INT NOT NULL,
  `Fee` INT NOT NULL,
  PRIMARY KEY (`RNumber`),
  UNIQUE INDEX `RNumber_UNIQUE` (`RNumber` ASC) )
ENGINE = InnoDB;


/*Part 3: Hospital_Staff => DONE
Hospital_Staff is the superclass for Physician and Nurse.
It is supposed to store those attributes which are common for both Physician and Nurse tables.
I assumed that Ceritication_NUM is the primary key and unique for both Physician and Nurse,
since in real world each ceriticate number is indeed unique => no duplicates.*/
DROP TABLE IF EXISTS `hospital`.`Hospital_Staff`;
CREATE TABLE IF NOT EXISTS `hospital`.`Hospital_Staff` (
  `Certification_NUM` VARCHAR(45) NOT NULL,
  `Phone` BIGINT NULL,
  `Address` VARCHAR(500) NULL,
  `Name` VARCHAR(90) NULL,
  PRIMARY KEY (`Certification_NUM`)
)
ENGINE = InnoDB;


/*Part 4: Physician => DONE => Subclass of the Hospital_Staff*/
DROP TABLE IF EXISTS `hospital`.`Physician` ;
CREATE TABLE IF NOT EXISTS `hospital`.`Physician` (
  `PhID` INT NOT NULL,
  `Certification_NUM` VARCHAR(45) NOT NULL, /* FK ref to Hospital_Staff, which holds the key */
  `Field` VARCHAR(250) NULL,
  PRIMARY KEY (`PhID`),
  CONSTRAINT `FK_Physician_Hospital_Staff`
    FOREIGN KEY (`Certification_NUM`)
    REFERENCES `hospital`.`Hospital_Staff` (`Certification_NUM`)
    ON DELETE NO ACTION /*Safety: Delete or Update won't be allowed if there are any related rows in the dependent table left that ref the deleted or updated row.*/
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


/*Part 5: Nurse => DONE => Subclass of the Hospital_Staff*/
DROP TABLE IF EXISTS `hospital`.`Nurse` ;
CREATE TABLE IF NOT EXISTS `hospital`.`Nurse` (
  `NID` INT NOT NULL AUTO_INCREMENT,
  `Certification_NUM` VARCHAR(45) NOT NULL, /* FK to Hospital_Staff */
  PRIMARY KEY (`NID`),
  CONSTRAINT `FK_Nurse_Hospital_Staff`
    FOREIGN KEY (`Certification_NUM`)
    REFERENCES `hospital`.`Hospital_Staff` (`Certification_NUM`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


/*Part 6: Invoice => DONE => must compile before the tables below to preserve the logic*/
DROP TABLE IF EXISTS `hospital`.`Invoice` ;
CREATE TABLE IF NOT EXISTS `hospital`.`Invoice` (
  `Invoice_ID` INT NOT NULL,
  `Patient_ID` INT NULL, /*FK*/
  `RoomCharge` INT NULL,
  `InstructionCharge` INT NULL,
  `Paid_Date` DATE NULL,
  `Paid_Amount` INT NULL,
  PRIMARY KEY (`Invoice_ID`),
  INDEX `fk_Patient_IDx` (`Patient_ID` ASC),
  CONSTRAINT `fk_Patient_ID`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `hospital`.`Patient` (`Patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


/*Part 7: Instruction => DONE*/
DROP TABLE IF EXISTS `hospital`.`Instruction`;
CREATE TABLE IF NOT EXISTS `hospital`.`Instruction` (
  `Code` INT NOT NULL, 
  `Description` VARCHAR(2500) NULL,
  `Fee` INT NULL,
  `Invoice_ID` INT NULL, /*FK here*/
  PRIMARY KEY (`Code`),
  INDEX `fk_invoice_idx` (`Invoice_ID` ASC),
  CONSTRAINT `fk_Invoice_ID`
    FOREIGN KEY (`Invoice_ID`)
    REFERENCES `hospital`.`Invoice` (`Invoice_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


/*Part 8: Executes*/
DROP TABLE IF EXISTS `hospital`.`Executes`;
CREATE TABLE IF NOT EXISTS `hospital`.`Executes` (
  `NID` INT NOT NULL, /* FK reference to Nurse */
  `Code` INT NOT NULL, /* FK reference to Instruction */
  `Date` DATE NULL,
  `Status` VARCHAR(45) NULL,
  PRIMARY KEY (`NID`, `Code`), /* Composite PK = NID + Code */
  INDEX `fk_nurse_idx` (`NID` ASC),
  INDEX `fk_instruction_idx` (`Code` ASC),
  CONSTRAINT `fk_NID`
    FOREIGN KEY (`NID`)
    REFERENCES `hospital`.`Nurse` (`NID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Code`
    FOREIGN KEY (`Code`)
    REFERENCES `hospital`.`Instruction` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;



/*Part 9: HealthRecord => DONE*/
DROP TABLE IF EXISTS `hospital`.`HealthRecord` ;
CREATE TABLE IF NOT EXISTS `hospital`.`HealthRecord` (
  `HRID` INT NOT NULL,
  `Patient_ID` INT NOT NULL,
  `Disease` VARCHAR(200) NULL,
  `Description` VARCHAR(2500) NULL,
  `Date` DATE NULL,
  `Status` VARCHAR(45) NULL,
  PRIMARY KEY (`HRID`),
  UNIQUE INDEX `HRID_UNIQUE` (`HRID` ASC) ,
  INDEX `FK_PatientID_idx` (`Patient_ID` ASC) ,
  CONSTRAINT `FK_PatientID`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `hospital`.`Patient` (`Patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


/*Part 10: Medication => DONE*/
CREATE TABLE IF NOT EXISTS `hospital`.`Medication` (
  `Prescription_ID` INT NOT NULL AUTO_INCREMENT,
  `Amount` INT NULL,
  `NID` INT NULL, /* FK to Nurse */
  `Patient_ID` INT NOT NULL, /* FK to Patient */
  
  PRIMARY KEY (`Prescription_ID`),
  UNIQUE INDEX `Prescription_ID_UNIQUE` (`Prescription_ID` ASC),
  
  INDEX `FK_NIDx` (`NID` ASC),
  CONSTRAINT `FK_Nurse`
    FOREIGN KEY (`NID`)
    REFERENCES `hospital`.`Nurse` (`NID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Patient`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `hospital`.`Patient` (`Patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


/*Part 11: Prescribes => DONE*/
CREATE TABLE IF NOT EXISTS `hospital`.`Prescribes` (
  `Prescription_ID` INT NOT NULL, /* FK to Medication */
  `PhID` INT NOT NULL, /* FK to Physician based on the EER */
  
  PRIMARY KEY (`Prescription_ID`, `PhID`),
  
  CONSTRAINT `FK_Medication`
    FOREIGN KEY (`Prescription_ID`)
    REFERENCES `hospital`.`Medication` (`Prescription_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Physician`
    FOREIGN KEY (`PhID`)
    REFERENCES `hospital`.`Physician` (`PhID`) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


/*Part 12: Nurses_Execute_Instructions_On => DONE*/
DROP TABLE IF EXISTS `hospital`.`Nurses_Execute_Instructions_On`;
CREATE TABLE IF NOT EXISTS `hospital`.`Nurses_Execute_Instructions_On` (
  `Code` INT NOT NULL, /*FK*/
  `Patient_ID` INT NOT NULL, /*FK*/
  `Status` VARCHAR(45) NULL,
  INDEX `fk_Patient_IDx` (`Patient_ID` ASC),
  /*Here I tried to represent the relationship I created on the diagram:
  Nurses are supposed to execute what the doctor instructs,
  and execute some of the instructions on patients*/
  CONSTRAINT `fk_Nurses_Execute_Patient`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `hospital`.`Patient` (`Patient_ID`) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  INDEX `fk_Codex` (`Code` ASC),
  CONSTRAINT `fk_Nurses_Execute_Instruction`
    FOREIGN KEY (`Code`)
    REFERENCES `hospital`.`Instruction` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;




/*The relationships between keys => this is what we need to add to the report + the schema itself*/

/*
Hospital_Staff (Certificate_NUM, Phone, Address, Name)
Primary Key: {Certificate_NUM}

Nurse (NID, Certificate_NUM)
Primary Key: {NID}
Foreign Key: {Certificate_NUM references Hospital Staff (Certificate_Num)}

Physician (PhID, Field, Certificate_NUM, Patient _ID)
Primary Key: {PhID}
Foreign Key: {Certificate_NUM references Hospital Staff (Certificate_Num), Patient_ID references Patient (Patient_ID)}

Patient (Patient_ID, Name, Address, Phone, Nights_NUM, RNumber)
Primary Key: {Patient_ID}
Foreign Key: {RNumber references Room (RNumber)}

Health Record (HRID, Disease, Date, Status, Description, Patient_ID)
Primary Key: {HRID}
Foreign Key: {Patient_ID references Patient (Patient_ID)}

Orders (PhID, Code, Date)
Primary Key: {PhID, Code}
Foreign Key: {PhID references Physician (PhID), Code references Instruction (Code, Description)}

Instruction (Code, Fee, Description, Invoice_ID)
Primary Key: {Code}
Foreign Key: {Invoice_ID, references Invoice (Invoice_ID, InstructionCharge)}

Executes (NID, Code, Date, Status)
Primary Key: {NID, Code}
Foreign Key: {NID references Nurse (NID), Code references Instruction (Code, Description)}

Invoice (Invoice_ID, RoomCharge, InstructionCharge, Paid_Date, Paid_Amount, Patient_ID)
Primary Key: {Invoice_ID}
Foreign Key: {Patient_ID references Patient (Patient_ID, Name, Address, Phone, Nights_NUM, RNumber)}

Medication (Prescription_ID, Amount, NID, Patient_ID)
Primary Key: {Prescription_ID}
Foreign Key: {NID references Nurse (NID), Patient_ID references Patient (Patient_ID, RNumber)}

Room (RNumber, Capacity, Fee, Invoice_ID)
Primary Key: {RNumber}
Foreign Key: {Invoice_ID references Invoice (Invoice_ID, Nights_NUM)}

Nurses Execute Instructions On (Code, PatientID, Status)
Primary Key: {Code, PatientID}
Foreign Key: {Code references Instruction (Code, Description), PatientID references Patient (Patient_ID)}
*/
