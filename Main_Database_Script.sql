-- Inserting the main database into PHPMyAdmin
CREATE DATABASE IF NOT EXISTS `maindatabase`;

-- If there is no "Rooms" table into the database, create a new one with the requested values
CREATE TABLE IF NOT EXISTS `Rooms` (
  `ID` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`));

-- The Module_Leaders table, which shows every Leaders' information
CREATE TABLE IF NOT EXISTS `Module_Leaders` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Office_Hours` VARCHAR(45) NULL,
  `Phone_Number` VARCHAR(45) NULL,
  `Office_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),

-- Adding a constraint with the name of fk_Module_Leaders_Rooms, that adds ID as a foreign key
-- that references the "Rooms" table and specifically the ID value
    CONSTRAINT `fk_Module_Leaders_Rooms`
    FOREIGN KEY (`ID`)
    REFERENCES `Rooms` (`ID`)
    );


CREATE TABLE IF NOT EXISTS `Modules` (
  `Module_Code` VARCHAR(20) NOT NULL,
  `Module_Title` VARCHAR(45) NULL,
  `Module_Leader_ID` INT UNSIGNED NULL,

  -- Setting the Primary Key to Module_Code
  PRIMARY KEY (`Module_Code`),

    CONSTRAINT `fk_Modules_Module_Leaders`
    FOREIGN KEY (`Module_Leader_ID`)
    REFERENCES `Module_Leaders` (`ID`)
    );

CREATE TABLE IF NOT EXISTS `Assesments` (
  -- Automatically setting the ID value to increase with the values
  `Assessments_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Assessment_Desc` VARCHAR(150) NULL,
  `Module_Code` VARCHAR(10) NOT NULL,
  `Deadline_Date` DATETIME NOT NULL,
  PRIMARY KEY (`Assessments_ID`),

    CONSTRAINT `fk_Assessments_Modules`
    FOREIGN KEY (`Module_Code`)
    REFERENCES `Modules` (`Module_Code`)
    );

CREATE TABLE IF NOT EXISTS `Module_Tutors` (
  `ID` INT UNSIGNED NOT NULL,
  `Module_Code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`ID`, `Module_Code`),

    CONSTRAINT `fk_Module_Tutors_Module_Leaders`
    FOREIGN KEY (`ID`)
    REFERENCES `Module_Leaders` (`ID`),

    CONSTRAINT `fk_Module_Tutors_Modules`
    FOREIGN KEY (`Module_Code`)
    REFERENCES `Modules` (`Module_Code`)
    );

CREATE TABLE IF NOT EXISTS `Students` (
  -- Setting each UNSIGNED integer to be of positive value
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Password` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`ID`));

CREATE TABLE IF NOT EXISTS `Enrollment` (
  `Module_Code` VARCHAR(10) NOT NULL,
  `Student_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Module_Code`, `Student_ID`),

    CONSTRAINT `fk_Module_Enrollment`
    FOREIGN KEY (`Module_Code`)
    REFERENCES `Modules` (`Module_Code`),

    CONSTRAINT `fk_Student_ID`
    FOREIGN KEY (`Student_ID`)
    REFERENCES `Students` (`ID`)
    );

CREATE TABLE IF NOT EXISTS `Student_Calendar` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Student_ID` INT UNSIGNED NOT NULL,
  `Description` VARCHAR(150) NOT NULL,
  `Start_Time` TIME NOT NULL,
  `End_Time` TIME NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`ID`),

  CONSTRAINT `fk_Student_Calendar_Student`
    FOREIGN KEY (`Student_ID`)
    REFERENCES `Students` (`ID`)
    );

CREATE TABLE IF NOT EXISTS `Week_Days` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Day` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`));

CREATE TABLE IF NOT EXISTS `Session_Type` (
  `Session_Type` INT NOT NULL,
  `Session_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Session_Type`, `Session_Name`));

CREATE TABLE IF NOT EXISTS `Module_Sessions` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Module_Code` VARCHAR(10) NOT NULL,
  `Start_Time` VARCHAR(45) NOT NULL,
  `End_Time` VARCHAR(45) NOT NULL,
  `Days_ID` INT NOT NULL,
  `Room_ID` INT UNSIGNED NOT NULL,
  `Session_Type_ID` INT NOT NULL,

  PRIMARY KEY (`ID`),

  CONSTRAINT `fk_Modules`
    FOREIGN KEY (`Module_Code`)
    REFERENCES `Modules` (`Module_Code`),

  CONSTRAINT `fk_Week_Day`
    FOREIGN KEY (`Days_ID`)
    REFERENCES `Week_Days` (`ID`),

  CONSTRAINT `fk_Module_Rooms`
    FOREIGN KEY (`Room_ID`)
    REFERENCES `Rooms` (`ID`),

  CONSTRAINT `fk_Session_Type`
    FOREIGN KEY (`Session_Type_ID`)
    REFERENCES `Session_Type` (`Session_Type`)

    );

CREATE TABLE IF NOT EXISTS `Student_Module_Sessions` (
  `Module_ID` INT UNSIGNED NOT NULL,
  `Student_ID` INT UNSIGNED NOT NULL,

  PRIMARY KEY (`Module_ID`, `Student_ID`),

  CONSTRAINT `fk_Module_Sessions`
    FOREIGN KEY (`Module_ID`)
    REFERENCES `Module_Sessions` (`ID`),

  CONSTRAINT `fk_Student_Module_Sessions`
    FOREIGN KEY (`Student_ID`)
    REFERENCES `Students` (`ID`)
    );


-- Inserting values into each table with their respected values
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (1, 'MS038');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (2, 'B302');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (3, 'MS316');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (4, 'OL2');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (5, 'MS308');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (6, 'MS310');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (7, 'MS304');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (8, 'MS218');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (9, 'E512');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (10, 'MS213');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (11, 'MS304a');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (12, 'MS212');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (13, 'MS214');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (14, 'N416');
INSERT INTO `Rooms` (`ID`, `Name`) VALUES (15, 'No room');


INSERT INTO `Module_Leaders` (`ID`, `Name`, `Email`, `Office_Hours`, `Phone_Number`, `Office_ID`) VALUES (1, 'Dave Voorhis', 'd.voorhis@derby.ac.uk', 'Thu 13 - 17', '1410', 1);
INSERT INTO `Module_Leaders` (`ID`, `Name`, `Email`, `Office_Hours`, `Phone_Number`, `Office_ID`) VALUES (2, 'Chris Windmill', 'c.windmill@derby.ac.uk', 'Fri 12 - 16', '9216', 3);
INSERT INTO `Module_Leaders` (`ID`, `Name`, `Email`, `Office_Hours`, `Phone_Number`, `Office_ID`) VALUES (3, 'Yongjun Zheng', 'y.zheng@derby.ac.uk', 'Tue 13 - 17', '9989', 4);
INSERT INTO `Module_Leaders` (`ID`, `Name`, `Email`, `Office_Hours`, `Phone_Number`, `Office_ID`) VALUES (4, 'Wayne Rippin', 'w.rippin@derby.ac.uk', 'Thu 9 - 12', '8989', 1);
INSERT INTO `Module_Leaders` (`ID`, `Name`, `Email`, `Office_Hours`, `Phone_Number`, `Office_ID`) VALUES (5, 'Nige', 'n.jones@derby.ac.uk', NULL, NULL,15 );
INSERT INTO `Module_Leaders` (`ID`, `Name`, `Email`, `Office_Hours`, `Phone_Number`, `Office_ID`) VALUES (6, 'Farhan', NULL, NULL, NULL, 15);
INSERT INTO `Module_Leaders` (`ID`, `Name`, `Email`, `Office_Hours`, `Phone_Number`, `Office_ID`) VALUES (7, 'Pat', 'p.zog@derby.ac.uk', NULL, NULL, 15);
INSERT INTO `Module_Leaders` (`ID`, `Name`, `Email`, `Office_Hours`, `Phone_Number`, `Office_ID`) VALUES (8, 'Andy', 'a.zhang@derby.ac.uk', NULL, NULL, 15);
INSERT INTO `Module_Leaders` (`ID`, `Name`, `Email`, `Office_Hours`, `Phone_Number`, `Office_ID`) VALUES (9, 'Jack', NULL, NULL, NULL, 15);


INSERT INTO `Modules` (`Module_Code`, `Module_Title`, `Module_Leader_ID`) VALUES ('5CC507', 'Databases', 1);
INSERT INTO `Modules` (`Module_Code`, `Module_Title`, `Module_Leader_ID`) VALUES ('5CC518', 'Team Project', 1);
INSERT INTO `Modules` (`Module_Code`, `Module_Title`, `Module_Leader_ID`) VALUES ('5CC516', 'Software Engineering', 2);
INSERT INTO `Modules` (`Module_Code`, `Module_Title`, `Module_Leader_ID`) VALUES ('4CC510', 'Programming I', 3);
INSERT INTO `Modules` (`Module_Code`, `Module_Title`, `Module_Leader_ID`) VALUES ('4CC511', 'Programming II', 4);


INSERT INTO `Assesments` (`Assessments_ID`, `Assessment_Desc`, `Module_Code`, `Deadline_Date`) VALUES (1, 'Milestone 1', '5CC507', '2021-10-06 17:00:00');
INSERT INTO `Assesments` (`Assessments_ID`, `Assessment_Desc`, `Module_Code`, `Deadline_Date`) VALUES (2, 'Performance review', '5CC518', '2021-12-12 23:59:59');
INSERT INTO `Assesments` (`Assessments_ID`, `Assessment_Desc`, `Module_Code`, `Deadline_Date`) VALUES (3, 'Portfolio hand-in', '5CC516', '2021-12-12 23:59:59');
INSERT INTO `Assesments` (`Assessments_ID`, `Assessment_Desc`, `Module_Code`, `Deadline_Date`) VALUES (4, 'Portfolio hand-in', '4CC510', '2021-12-12 17:00:00');
INSERT INTO `Assesments` (`Assessments_ID`, `Assessment_Desc`, `Module_Code`, `Deadline_Date`) VALUES (5, 'Project hand-in', '4CC511', '2021-10-18 23:59:59');
INSERT INTO `Assesments` (`Assessments_ID`, `Assessment_Desc`, `Module_Code`, `Deadline_Date`) VALUES (6, 'Milestone 1', '5CC507', '2021-11-06 17:00:00');
INSERT INTO `Assesments` (`Assessments_ID`, `Assessment_Desc`, `Module_Code`, `Deadline_Date`) VALUES (7, 'Quiz', '4CC511', '2021-12-12 12:00:00');
INSERT INTO `Assesments` (`Assessments_ID`, `Assessment_Desc`, `Module_Code`, `Deadline_Date`) VALUES (8, 'Project hand-in', '5CC507', '2021-12-12 23:59:59');


INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (1, '5CC507');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (1, '5CC518');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (1, '4CC511');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (2, '5CC516');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (3, '4CC510');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (4, '4CC511');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (5, '5CC507');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (6, '5CC507');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (6, '5CC518');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (7, '5CC518');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (8, '4CC511');
INSERT INTO `Module_Tutors` (`ID`, `Module_Code`) VALUES (9, '5CC516');

-- Added ID and Password for each table, for students to log in
INSERT INTO `Students` (`ID`, `Password`) VALUES (328145291, 'zogbogfrog');
INSERT INTO `Students` (`ID`, `Password`) VALUES (578274289, 'superman');


INSERT INTO `Enrollment` (`Module_Code`, `Student_ID`) VALUES ('5CC507', 328145291);
INSERT INTO `Enrollment` (`Module_Code`, `Student_ID`) VALUES ('5CC518', 578274289);
INSERT INTO `Enrollment` (`Module_Code`, `Student_ID`) VALUES ('5CC518', 328145291);
INSERT INTO `Enrollment` (`Module_Code`, `Student_ID`) VALUES ('5CC516', 578274289);
INSERT INTO `Enrollment` (`Module_Code`, `Student_ID`) VALUES ('5CC516', 328145291);
INSERT INTO `Enrollment` (`Module_Code`, `Student_ID`) VALUES ('4CC510', 328145291);


INSERT INTO `Student_Calendar` (`ID`, `Student_ID`, `Description`, `Start_Time`, `End_Time`, `Date`) VALUES (1, 328145291, 'Pub - Standing Order', '19:00:00', '23:59:00', '2023/10/01');
INSERT INTO `Student_Calendar` (`ID`, `Student_ID`, `Description`, `Start_Time`, `End_Time`, `Date`) VALUES (2, 328145291, 'Sunday lunch', '13:00:00', '15:00:00', '2029/11/01');
INSERT INTO `Student_Calendar` (`ID`, `Student_ID`, `Description`, `Start_Time`, `End_Time`, `Date`) VALUES (3, 578274289, 'Gym', '12:00:00', '13:00:00', '2013/11/01');
INSERT INTO `Student_Calendar` (`ID`, `Student_ID`, `Description`, `Start_Time`, `End_Time`, `Date`) VALUES (4, 578274289, 'Project meeting', '13:00:00', '15:00:00', '2012/11/01');


INSERT INTO `Week_Days` (`ID`, `Day`) VALUES (1, 'Monday');
INSERT INTO `Week_Days` (`ID`, `Day`) VALUES (2, 'Tuesday');
INSERT INTO `Week_Days` (`ID`, `Day`) VALUES (3, 'Wednesday');
INSERT INTO `Week_Days` (`ID`, `Day`) VALUES (4, 'Thursday');
INSERT INTO `Week_Days` (`ID`, `Day`) VALUES (5, 'Friday');
INSERT INTO `Week_Days` (`ID`, `Day`) VALUES (6, 'Saturday');
INSERT INTO `Week_Days` (`ID`, `Day`) VALUES (7, 'Sunday');


INSERT INTO `Session_Type` (`Session_Type`, `Session_Name`) VALUES (1, 'Lectures');
INSERT INTO `Session_Type` (`Session_Type`, `Session_Name`) VALUES (2, 'Labs');


INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (1, '5CC507', '09:00:00', '10:00:00', 1, 7, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (2, '5CC518', '09:00:00', '10:00:00', 1, 10, 2);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (3, '5CC516', '11:00:00', '12:00:00', 3, 13, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (4, '4CC510', '09:00:00', '17:00:00', 2, 11, 2);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (5, '4CC511', '09:00:00', '10:00:00', 1, 7, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (6, '5CC507', '11:00:00', '12:00:00', 1, 7, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (7, '5CC507', '13:00:00', '14:00:00', 1, 10, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (8, '5CC507', '10:00:00', '11:00:00', 2, 11, 2);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (9, '5CC507', '11:00:00', '12:00:00', 2, 12, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (10, '5CC507', '13:00:00', '14:00:00', 4, 13, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (11, '5CC518', '11:00:00', '12:00:00', 1, 13, 2);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (12, '5CC518', '13:00:00', '14:00:00', 1, 10, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (13, '5CC518', '10:00:00', '11:00:00', 2, 11, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (14, '5CC518', '11:00:00', '12:00:00', 2, 12, 2);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (15, '5CC518', '13:00:00', '14:00:00', 4, 13, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (16, '5CC518', '10:00:00', '11:00:00', 5, 14, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (17, '5CC516', '11:00:00', '12:00:00', 4, 1, 2);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (18, '4CC510', '09:00:00', '17:00:00', 2, 7, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (19, '4CC511', '11:00:00', '12:00:00', 1, 7, 2);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (20, '4CC511', '13:00:00', '14:00:00', 1, 10, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (21, '4CC511', '10:00:00', '11:00:00', 2, 11, 1);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (22, '4CC511', '11:00:00', '12:00:00', 2, 12, 2);
INSERT INTO `Module_Sessions` (`ID`, `Module_Code`, `Start_Time`, `End_Time`, `Days_ID`, `Room_ID`, `Session_Type_ID`) VALUES (23, '4CC511', '13:00:00', '14:00:00', 4, 13, 1);


INSERT INTO `Student_Module_Sessions` (`Module_ID`, `Student_ID`) VALUES (1, 328145291);
INSERT INTO `Student_Module_Sessions` (`Module_ID`, `Student_ID`) VALUES (2, 578274289);


