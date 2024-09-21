DROP TABLE IF EXISTS Locker;
CREATE TABLE Locker
(
  locker_num INT PRIMARY KEY AUTO_INCREMENT,
  rent_cost DECIMAL(12,2) NOT NULL,
  availability VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS Members;
CREATE TABLE Members
(
  member_num INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  address VARCHAR(100) NOT NULL,
  phone_num VARCHAR(10) UNIQUE NOT NULL,
  email VARCHAR(30) UNIQUE NOT NULL,
  dob DATE NOT NULL,
  medical_hist VARCHAR(100),
  lockerNum INT,
  FOREIGN KEY locker_fk(lockerNum) REFERENCES Locker(locker_num)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

DROP TABLE IF EXISTS Membership;
CREATE TABLE Membership
(
  membership_id INT PRIMARY KEY AUTO_INCREMENT,
  description VARCHAR(50) NOT NULL,
  duration INT(10) NOT NULL,
  referral VARCHAR(20)
);

DROP TABLE IF EXISTS CardPayments;
CREATE TABLE CardPayments
(
  memberNum INT NOT NULL,
  membershipID INT NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  payment_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  receipt VARCHAR(3) NOT NULL,
  discount DECIMAL(12,2),
  card_type VARCHAR(20) NOT NULL,
  card_num INT(30) NOT NULL,
  expiry_date DATE NOT NULL,
  ccv INT(11) NOT NULL,
  PRIMARY KEY (memberNum, membershipID),
  FOREIGN KEY member_fk(memberNum) REFERENCES Members(member_num),
  FOREIGN KEY membership_fk(membershipID) REFERENCES Membership(membership_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

DROP TABLE IF EXISTS CheckPayments;
CREATE TABLE CheckPayments
(
  memberNum INT NOT NULL,
  membershipID INT NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  payment_date DATE NOT NULL,
  status VARCHAR(10) NOT NULL,
  receipt VARCHAR(3) NOT NULL,
  discount DECIMAL(12,2),
  check_num INT(11) NOT NULL,
  bank_num INT(11) NOT NULL,
  PRIMARY KEY (memberNum, membershipID),
  FOREIGN KEY member_fk(memberNum) REFERENCES Members(member_num),
  FOREIGN KEY membership_fk(membershipID) REFERENCES Membership(membership_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

DROP TABLE IF EXISTS CashPayments;
CREATE TABLE CashPayments
(
  memberNum INT NOT NULL,
  membershipID INT NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  payment_date DATE NOT NULL,
  status VARCHAR(10) NOT NULL,
  receipt VARCHAR(3) NOT NULL,
  discount DECIMAL(12,2),
  currency_type VARCHAR(10) NOT NULL,
  PRIMARY KEY (memberNum, membershipID),
  FOREIGN KEY member_fk(memberNum) REFERENCES Members(member_num),
  FOREIGN KEY membership_fk(membershipID) REFERENCES Membership(membership_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

DROP TABLE IF EXISTS Qualifications;
CREATE TABLE Qualifications
(
  code INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(50) NOT NULL,
  description VARCHAR(50) NOT NULL,
  issuing_body VARCHAR(30) NOT NULL,
  date_issued DATE NOT NULL
);

DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff
(
  staff_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  ppsn VARCHAR(20) UNIQUE NOT NULL,
  iban VARCHAR(20) UNIQUE NOT NULL,
  email VARCHAR(30) UNIQUE NOT NULL,
  address VARCHAR(100) NOT NULL,
  phone_num INT(10) UNIQUE NOT NULL,
  start_date DATE NOT NULL,
  role VARCHAR(10),
  Code INT,
  managerID INT,
  FOREIGN KEY qualifications_fk(Code) REFERENCES Qualifications(code),
  FOREIGN KEY manager_fk(managerID) REFERENCES Staff(staff_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

CREATE TABLE FitnessLesson
(
  lesson_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  description VARCHAR(50) NOT NULL,
  duration VARCHAR(20) NOT NULL,
  capacity INT(3) NOT NULL,
  fitness_level INT(3) NOT NULL,
  staffID INT NOT NULL,
  FOREIGN KEY staff_fk(staffID) REFERENCES Staff(staff_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

DROP TABLE IF EXISTS Yoga;
CREATE TABLE Yoga
(
  lesson_id INT NOT NULL,
  style VARCHAR(20) NOT NULL,
  equipment VARCHAR(20) NOT NULL,
  FOREIGN KEY lesson_fk(lesson_id) REFERENCES FitnessLesson(lesson_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

DROP TABLE IF EXISTS Spinning;
CREATE TABLE Spinning
(
  lesson_id INT NOT NULL,
  intensity_num INT(2) NOT NULL,
  bike_num INT(2) NOT NULL,
  FOREIGN KEY lesson_fk(lesson_id) REFERENCES FitnessLesson(lesson_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

DROP TABLE IF EXISTS WeightTraining;
CREATE TABLE WeightTraining
(
  lesson_id INT NOT NULL,
  weight_type CHAR(20) NOT NULL,
  FOREIGN KEY lesson_fk(lesson_id) REFERENCES FitnessLesson(lesson_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

DROP TABLE IF EXISTS Attendance;
CREATE TABLE Attendance (
    memberNum INT NOT NULL,
    lessonID INT NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    PRIMARY KEY (memberNum, lessonID),
    FOREIGN KEY member_fk(memberNum) REFERENCES Members(member_num),
    FOREIGN KEY lesson_fk(lessonID) REFERENCES FitnessLesson(lesson_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

DROP TABLE IF EXISTS Manufacturer;
CREATE TABLE Manufacturer
(
  manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  address VARCHAR(100) NOT NULL,
  phone_num INT(10) UNIQUE NOT NULL,
  email VARCHAR(30) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS GymEquipment;
CREATE TABLE GymEquipment
(
  equipment_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE NOT NULL,
  instructions VARCHAR(50) NOT NULL,
  availability VARCHAR(10) NOT NULL,
  type VARCHAR(10) NOT NULL,
  equipment_condition VARCHAR(10),
  staffID INT NOT NULL,
  manufacturerID INT NOT NULL,
  FOREIGN KEY staff_fk(staffID) REFERENCES Staff(staff_id),
  FOREIGN KEY manufactuerer_fk(manufacturerID) REFERENCES Manufacturer(manufacturer_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

CREATE TABLE Cardio 
(
    equipment_id INT NOT NULL,
    max_speed INT(2) NOT NULL,
    num_of_machines INT(2) NOT NULL,
    FOREIGN KEY equipment_fk(equipment_id) REFERENCES GymEquipment(equipment_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Weights 
(
    equipment_id INT NOT NULL,
    muscle_target VARCHAR(20) NOT NULL,
    num_of_weights INT(2) NOT NULL,
    FOREIGN KEY equipment_fk(equipment_id) REFERENCES GymEquipment(equipment_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE FreeWeight 
(
    equipment_id INT NOT NULL,
    weight_range VARCHAR(10) NOT NULL,
    FOREIGN KEY equipment_fk(equipment_id) REFERENCES GymEquipment(equipment_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);


DROP TABLE IF EXISTS Maintenance;
CREATE TABLE Maintenance
(
  request_id INT PRIMARY KEY AUTO_INCREMENT,
  description VARCHAR(100) NOT NULL,
  date DATE NOT NULL,
  status VARCHAR(30) NOT NULL,
  equipmentID INT,
  FOREIGN KEY equipment_fk(equipmentID) REFERENCES GymEquipment(equipment_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL
);

DROP TABLE IF EXISTS Reservation;
CREATE TABLE Reservation (
    memberNum INT NOT NULL,
    equipmentID INT NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    duration VARCHAR(30) NOT NULL,
    PRIMARY KEY (memberNum, equipmentID),
    FOREIGN KEY member_fk(memberNum) REFERENCES Members(member_num),
    FOREIGN KEY equipment_fk(equipmentID) REFERENCES GymEquipment(equipment_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

DESCRIBE Locker;
DESCRIBE Members;
DESCRIBE Membership;
DESCRIBE CardPayments;
DESCRIBE CheckPayments;
DESCRIBE CashPayments;
DESCRIBE Staff;
DESCRIBE FitnessLesson;
DESCRIBE Yoga;
DESCRIBE Spinning;
DESCRIBE WeightTraining;
DESCRIBE Attendance;
DESCRIBE Qualifications;
DESCRIBE Manufacturer;
DESCRIBE GymEquipment;
DESCRIBE Cardio;
DESCRIBE Weights;
DESCRIBE FreeWeight;
DESCRIBE Maintenance;
DESCRIBE Reservation;

INSERT INTO Locker (locker_num, rent_cost, availability) 
VALUES (DEFAULT, 50.00, 'Available'),
       (DEFAULT, 60.00, 'Unavailable'),
       (DEFAULT, 55.00, 'Available'),
       (DEFAULT, 65.00, 'Unavailable');

INSERT INTO Members (member_num, first_name, last_name, address, phone_num, email, dob, medical_hist, lockerNum) 
VALUES (DEFAULT, 'John', 'Doe', 'Dublin', '0123456789', 'john.doe@example.com', '1980-01-01', 'None', 1),
       (DEFAULT, 'Jane', 'Smith', 'Cork', '0123456789', 'jane.smith@example.com', '1985-01-01', 'None', 2),
       (DEFAULT, 'Alice', 'Johnson', 'Galway', '0123456789', 'alice.johnson@example.com', '1990-01-01', 'None', 3),
       (DEFAULT, 'Bob', 'Williams', 'Limerick', '0123456789', 'bob.williams@example.com', '1995-01-01', 'None', 4);

INSERT INTO Membership (membership_id, description, duration, referral) 
VALUES (DEFAULT, 'Basic Membership', 12, 'None'),
       (DEFAULT, 'Premium Membership', 12, 'John Doe'),
       (DEFAULT, 'Basic Membership', 6, 'Jane Smith'),
       (DEFAULT, 'Premium Membership', 6, 'Alice Johnson');

INSERT INTO CardPayments (memberNum, membershipID, amount, payment_date, status, receipt, discount, card_type, card_num, expiry_date, ccv) 
VALUES (1, 1, 100.00, '2023-01-01', 'Paid', 'Yes', 0.00, 'Visa', 12345678, '2025-01-01', 123),
       (2, 2, 200.00, '2023-01-01', 'Paid', 'Yes', 0.00, 'MasterCard', 23456789, '2025-01-01', 234),
       (3, 3, 150.00, '2023-01-01', 'Paid', 'Yes', 0.00, 'Visa', 34567890, '2025-01-01', 345),
       (4, 4, 250.00, '2023-01-01', 'Paid', 'Yes', 0.00, 'MasterCard', 45678901, '2025-01-01', 456);

INSERT INTO CheckPayments (memberNum, membershipID, amount, payment_date, status, receipt, discount, check_num, bank_num) 
VALUES (1, 1, 100.00, '2023-01-01', 'Paid', 'Yes', 0.00, 1234, 5678),
       (2, 2, 200.00, '2023-01-01', 'Paid', 'Yes', 0.00, 2345, 6789),
       (3, 3, 150.00, '2023-01-01', 'Paid', 'Yes', 0.00, 3456, 7890),
       (4, 4, 250.00, '2023-01-01', 'Paid', 'Yes', 0.00, 4567, 8901);

INSERT INTO CashPayments (memberNum, membershipID, amount, payment_date, status, receipt, discount, currency_type) 
VALUES (1, 1, 100.00, '2023-01-01', 'Paid', 'Yes', 0.00, 'Euro'),
       (2, 2, 200.00, '2023-01-01', 'Paid', 'Yes', 0.00, 'Euro'),
       (3, 3, 150.00, '2023-01-01', 'Paid', 'Yes', 0.00, 'Euro'),
       (4, 4, 250.00, '2023-01-01', 'Paid', 'Yes', 0.00, 'Euro');

INSERT INTO Qualifications (code, title, description, issuing_body, date_issued) 
VALUES (DEFAULT, 'Certified Personal Trainer', 'Certification for personal training', 'Fitness Ireland', '2023-01-01'),
       (DEFAULT, 'Certified Yoga Instructor', 'Certification for yoga instruction', 'Yoga Ireland', '2023-02-01'),
       (DEFAULT, 'Certified Spinning Instructor', 'Certification for spinning instruction', 'Spinning Ireland', '2023-03-01'),
       (DEFAULT, 'Certified Weight Training Instructor', 'Certification for weight training instruction', 'Weight Training Ireland', '2023-04-01');

INSERT INTO Staff (staff_id, first_name, last_name, ppsn, iban, email, address, phone_num, start_date, role, Code, managerID) 
VALUES (DEFAULT, 'John', 'Doe', '1234567A', 'IE00BANK1234567890', 'john.doe@example.com', 'Dublin', '0123456789', '2023-01-01', 'Trainer', 1, NULL),
       (DEFAULT, 'Jane', 'Smith', '2345678B', 'IE00BANK2345678901', 'jane.smith@example.com', 'Cork', '0123456789', '2023-01-01', 'Trainer', 2, 1),
       (DEFAULT, 'Alice', 'Johnson', '3456789C', 'IE00BANK3456789012', 'alice.johnson@example.com', 'Galway', '0123456789', '2023-01-01', 'Trainer', 3, 1),
       (DEFAULT, 'Bob', 'Williams', '4567890D', 'IE00BANK4567890123', 'bob.williams@example.com', 'Limerick', '0123456789', '2023-01-01', 'Manager', 4, NULL);

INSERT INTO FitnessLesson (lesson_id, name, description, duration, capacity, fitness_level, staffID) 
VALUES (DEFAULT, 'Yoga 101', 'Beginner yoga class', '60 minutes', 10, 1, 1),
       (DEFAULT, 'Spinning 101', 'Beginner spinning class', '60 minutes', 10, 1, 2),
       (DEFAULT, 'Weight Training 101', 'Beginner weight training class', '60 minutes', 10, 1, 3),
       (DEFAULT, 'Yoga 201', 'Intermediate yoga class', '60 minutes', 10, 2, 1);

INSERT INTO Yoga (lesson_id, style, equipment) 
VALUES (1, 'Hatha', 'Mat'),
       (2, 'Vinyasa', 'Mat'),
       (3, 'Ashtanga', 'Mat'),
       (4, 'Iyengar', 'Mat and props');

INSERT INTO Spinning (lesson_id, intensity_num, bike_num) 
VALUES (1, 5, 10),
       (2, 6, 10),
       (3, 7, 10),
       (4, 8, 10);

INSERT INTO WeightTraining (lesson_id, weight_type) 
VALUES (1, 'Dumbbells'),
       (2, 'Barbells'),
       (3, 'Kettlebells'),
       (4, 'Resistance Bands');

INSERT INTO Attendance (memberNum, lessonID, date, time) 
VALUES (1, 1, '2023-12-01', '10:00:00'),
       (2, 2, '2023-12-02', '11:00:00'),
       (3, 3, '2023-12-03', '12:00:00'),
       (4, 4, '2023-12-04', '13:00:00');

INSERT INTO Manufacturer (manufacturer_id, name, address, phone_num, email) 
VALUES (DEFAULT, 'Irish Fitness Equipment', '123 Main St, Dublin, Ireland', '0123456789', 'info@irishfitnessequipment.ie'),
       (DEFAULT, 'Bodhi Fitness Equipment', '456 Elm St, Cork, Ireland', '0123456789', 'info@bodhifitnessequipment.ie'),
       (DEFAULT, 'Chakra Fitness Equipment', '789 Pine St, Galway, Ireland', '0123456789', 'info@chakrafinessequipment.ie'),
       (DEFAULT, 'Dharma Fitness Equipment', '101112 Oak St, Limerick, Ireland', '0123456789', 'info@dharmafitnessequipment.ie');

INSERT INTO GymEquipment (equipment_id, name, instructions, availability, type, equipment_condition, staffID, manufacturerID) 
VALUES (DEFAULT, 'Treadmill', 'Start slow and increase speed as needed', 'Available', 'Cardio', 'Good', 1, 1),
       (DEFAULT, 'Exercise Bike', 'Adjust seat height before starting', 'Available', 'Cardio', 'Good', 2, 2),
       (DEFAULT, 'Yoga Mat', 'Clean with disinfectant after use', 'Available', 'FreeWeight', 'Good', 3, 3),
       (DEFAULT, 'Dumbbells', 'Do not drop on floor', 'Available', 'Weights', 'Good', 4, 4);

INSERT INTO Cardio (equipment_id, max_speed, num_of_machines) 
VALUES (1, 10, 5),
       (2, 15, 4),
       (3, 20, 3),
       (4, 25, 2);

INSERT INTO Weights (equipment_id, muscle_target, num_of_weights) 
VALUES (1, 'Legs', 10),
       (2, 'Arms', 15),
       (3, 'Chest', 20),
       (4, 'Back', 25);

INSERT INTO FreeWeight (equipment_id, weight_range) 
VALUES (1, '5-50 kg'),
       (2, '10-100 kg'),
       (3, '15-150 kg'),
       (4, '20-200 kg');

INSERT INTO Maintenance (request_id, description, date, status, equipmentID) 
VALUES (DEFAULT, 'Routine maintenance', '2023-12-01', 'Completed', 1),
       (DEFAULT, 'Repair treadmill', '2023-12-02', 'In progress', 2),
       (DEFAULT, 'Replace yoga mat', '2023-12-03', 'Pending', 3),
       (DEFAULT, 'Inspect dumbbells', '2023-12-04', 'Scheduled', 4);

INSERT INTO Reservation (memberNum, equipmentID, date, time, duration) 
VALUES (1, 1, '2023-12-01', '10:00:00', '30 minutes'),
       (2, 2, '2023-12-02', '11:00:00', '45 minutes'),
       (3, 3, '2023-12-03', '12:00:00', '60 minutes'),
       (4, 4, '2023-12-04', '13:00:00', '90 minutes');

#Selecting the total number of yoga classes for each style taught by staff from Dublin
SELECT 
	y.style AS "Yoga Style", 
    COUNT(y.lesson_id) AS "Total Lessons"
FROM 
    Yoga y
JOIN 
    FitnessLesson fl ON y.lesson_id = fl.lesson_id
JOIN 
    Staff st ON fl.staffID = st.staff_id
WHERE 
    st.address = 'Dublin'
GROUP BY 
    y.style;

#Selecting the total amount paid by members from Dublin for each membership type
SELECT 
	m.description AS "Membership Description", 
    SUM(cp.amount) AS "Total Amount"
FROM 
    Membership m
JOIN 
    CardPayments cp ON m.membership_id = cp.membershipID
JOIN 
    Members me ON cp.memberNum = me.member_num
WHERE 
    me.address = 'Dublin'
GROUP BY 
    m.description;

#Selecting the total number of spinning classes for each intensity number taught by staff with a specific qualification
SELECT 
	s.intensity_num AS "Intensity Number", 
    COUNT(s.lesson_id) AS "Total Lessons"
FROM 
    Spinning s
JOIN 
    FitnessLesson fl ON s.lesson_id = fl.lesson_id
JOIN 
    Staff st ON fl.staffID = st.staff_id
JOIN 
    Qualifications q ON st.Code = q.code
WHERE 
    q.title = 'Certified Spinning Instructor'
GROUP BY 
    s.intensity_num;

#Selecting the total number of gym equipment from a specific manufacturer
SELECT 
	m.name AS "Manufacturer Name", 
    COUNT(ge.equipment_id) AS "Total Equipment"
FROM 
    GymEquipment ge
JOIN 
    Manufacturer m ON ge.manufacturerID = m.manufacturer_id
WHERE 
    m.name = 'Irish Fitness Equipment'
GROUP BY 
    m.name;

