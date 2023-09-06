/*Part 1: Patient => DONE => Patient_ID will auto increment, so do not need to insert*/
INSERT INTO Patient (Name, Address, Phone)
VALUES
  ('Kiryl Baravikou', 'Something', '123213131'),
  ('Gendalf Greyhame', 'Valinor', '111111111'),
  ('Frodo Baggins', 'Shire', '222222222'),
  ('Sauron', 'Mordor', '333333333'),
  ('Gollum', 'Gladden Fields', '444444444'),
  /*Test for updates on room charge*/
  ('Shaq', 'NJ', '421134124'),
  ('Jay-Z', 'NYC', '543535435'),
  ('Eminem', 'Detroit', '433442415'),
  ('Rihanna', 'LA', '633445415');


/*Part 2: Room => DONE => the more people in the room, the higher price is*/
INSERT INTO Room (RNumber, Capacity, Fee)
VALUES
  (1, 5, 100),
  (2, 4, 200),
  (3, 3, 300),
  (4, 2, 400),
  (5, 1, 500);
  
  /*Call the trigger*/
INSERT INTO Room (RNumber, Capacity, Fee) VALUES (6, 7, 1234);


/*Part 3: Hospital_Staff => DONE*/
INSERT INTO Hospital_Staff (Certification_NUM, Phone, Address, Name)
VALUES
  ('C_NUM1', '555555555', 'Hogwarts', 'Albus Dumbledore'),
  ('C_NUM2', '666666666', 'Grimmauld Place', 'Sirius Black'),
  ('C_NUM3', '777777777', '4 Privet Drive, Little Whinging', 'Harry Potter'),
  ('C_NUM4', '888888888', 'Hogwarts', 'Rubeus Hagrid'),
  ('C_NUM5', '999999999', 'Little Hangleton', 'Voldemort');


/*Part 4: Physician => DONE*/
INSERT INTO Physician (PhID, Certification_NUM, Field)
VALUES
  (1, 'C_NUM1', 'Prosthodontics'),
  (2, 'C_NUM2', 'Neurosurgery'),
  (3, 'C_NUM3', 'Cardiology'),
  (4, 'C_NUM4', 'Psychiatry'),
  (5, 'C_NUM5', 'Pathology');


/*Part 5: Nurse => DONE => NID will auto increment from 1 to 5*/
INSERT INTO Nurse (Certification_NUM)
VALUES
  ('C_NUM1'),
  ('C_NUM2'),
  ('C_NUM3'),
  ('C_NUM4'),
  ('C_NUM5');


/*Part 6: Invoice => DONE => must compile before the tables below to preserve the logic*/
INSERT INTO Invoice (Invoice_ID, Patient_ID, RoomCharge, InstructionCharge, Paid_Date, Paid_Amount)
VALUES
  (1, 1, 100, 100, '2023-07-23', 200),
  (2, 2, 200, 200, '2023-07-24', 400),
  (3, 3, 300, 300, '2023-07-25', 600),
  (4, 4, 400, 400, '2023-07-26', 800),
  (5, 5, 500, 500, '2023-07-27', 1000),
  (6, 6, 600, 600, '2023-07-25', 1150),
  (7, 7, 700, 700, '2023-07-26', 1200),
  (8, 8, 800, 800, '2023-07-27', 1350);
  
/*Insert a new invoice for Patient 1 (Room 1)*/
INSERT INTO Invoice (Invoice_ID, Patient_ID, RoomCharge, InstructionCharge, Paid_Date, Paid_Amount)
VALUES (9, 1, 100, 100, '2023-07-23', 20000);

  
  

/*Part 7: Instruction => DONE => random procedures*/
INSERT INTO Instruction (Code, Description, Fee, Invoice_ID)
VALUES
  (11, 'CAT', 1000, 1),
  (22, 'Breast biopsy', 2000, 2),
  (33, 'Aortography', 3000, 3),
  (44, 'Fluoroscopy', 4000, 4),
  (55, 'MRI', 5000, 5),
  (66, 'EKG', 6000, 6),
  (77, 'Implantation', 7000, 7),
  (88, 'Doppler', 8000, 8);


/*Part 8: Executes*/
INSERT INTO Executes (NID, Code, Date, Status)
VALUES
  (1, 11, '2023-07-23', 'Done'),
  (2, 22, '2023-07-24', 'Pending'),
  (3, 33, '2023-07-25', 'Done'),
  (4, 44, '2023-07-26', 'Pending'),
  (5, 55, '2023-07-27', 'Done'),
  /*Test for the query*/
  (3, 66, '2023-07-25', 'Done'),
  (4, 77, '2023-07-26', 'Pending'),
  (5, 88, '2023-07-27', 'Done');
  


/*Part 9: HealthRecord => DONE:
NB: HRID = Health Record ID => I just enumerate them from 1 to 5, same applies to Patient_ID*/
INSERT INTO HealthRecord (HRID, Patient_ID, Disease, Description, Date, Status)
VALUES
  (1, 1, 'No diseases', 'Healthy.', '2023-07-23', 'Resolved'),
  (2, 2, 'Colon cancer', 'Abdominal Pain and Bloating. Stomach bloating, distention, cramps or pain in the abdominal or bowel region. Anemia.', '2023-07-24', 'Pending'),
  (3, 3, 'COVID-19', 'Fever or chills. Cough. Shortness of breath. Fatigue. Body aches.', '2023-07-25', 'Pending'),
  (4, 4, 'Mononucleosis', 'Extreme fatigue. Fever. Sore throat. Head and body aches. Swollen lymph nodes in the neck and armpits.', '2023-07-26', 'Pending'),
  (5, 5, 'Diabetes', 'Feeling more thirsty than usual. Urinating often. Weight loss. Presence of ketones in the urine.', '2023-07-27', 'Resolved'),
  /*Test for queries*/
  (6, 5, 'Broken Arm', 'Feeling more thirsty than usual. Urinating often. Weight loss. Presence of ketones in the urine.', '2023-07-27', 'Resolved'),
  (7, 5, 'Pneumonia', 'Weight loss. Fever.', '2023-07-27', 'Resolved'),
  (8, 5, 'Diabetes Type 2', 'Feeling more thirsty than usual. Urinating often. Weight loss. Presence of ketones in the urine.', '2023-07-27', 'Pending');


/*Part 10: Medication => DONE*/
INSERT INTO Medication (Amount, NID, Patient_ID)
VALUES
  (1, 1, 1),
  (4, 4, 4),
  (5, 5, 5),
  (432, 3, 3),
  (532, 3, 3),
  (425, 3, 3),
  (54, 3, 3),
  (555, 3, 2);


/*Part 11: Prescribes => DONE*/
INSERT INTO Prescribes (Prescription_ID, PhID)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);


/*Part 12: Nurses_Execute_Instructions_On => DONE*/
INSERT INTO Nurses_Execute_Instructions_On (Code, Patient_ID, Status)
VALUES
  (11, 1, 'Done'),
  (22, 2, 'Pending'),
  (33, 3, 'Done'),
  (44, 4, 'Pending'),
  (55, 5, 'Done'),
  (55, 2, 'Pending'),
  (44, 3, 'Done'),
  (44, 4, 'Pending'),
  (55, 5, 'Done');
