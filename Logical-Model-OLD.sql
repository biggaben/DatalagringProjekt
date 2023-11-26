CREATE TABLE Instrument (
 instrument_id SERIAL NOT NULL,
 instrument_type VARCHAR(30) NOT NULL,
 instrument_category VARCHAR(30) NOT NULL,
 instrument_price INT NOT NULL
);

ALTER TABLE Instrument ADD CONSTRAINT PK_Instrument PRIMARY KEY (instrument_id);


CREATE TABLE Person (
 person_id INT NOT NULL,
 name VARCHAR(30) NOT NULL,
 address VARCHAR(30) NOT NULL
);

ALTER TABLE Person ADD CONSTRAINT PK_Person PRIMARY KEY (person_id);


CREATE TABLE School (
 school_id VARCHAR(30) NOT NULL,
 max_students INT NOT NULL,
 available_spots INT NOT NULL
);

ALTER TABLE School ADD CONSTRAINT PK_School PRIMARY KEY (school_id);


CREATE TABLE SiblingGroup (
 sibling_group_id SERIAL NOT NULL,
 person_id INT
);

ALTER TABLE SiblingGroup ADD CONSTRAINT PK_SiblingGroup PRIMARY KEY (sibling_group_id);


CREATE TABLE Student (
 person_id INT NOT NULL,
 school_id VARCHAR(30) NOT NULL,
 contact_person INT DEFAULT NULL,
 sibling_group_id INT DEFAULT NULL
);

ALTER TABLE Student ADD CONSTRAINT PK_Student PRIMARY KEY (person_id);


CREATE TABLE Application (
 application_id SERIAL NOT NULL,
 person_id INT NOT NULL,
 school_id VARCHAR(30) NOT NULL,
 name VARCHAR(10) NOT NULL,
 personal_number INT NOT NULL,
 address VARCHAR(10) NOT NULL
);

ALTER TABLE Application ADD CONSTRAINT PK_Application PRIMARY KEY (application_id);


CREATE TABLE ContactInfo (
 person_id INT NOT NULL
);

ALTER TABLE ContactInfo ADD CONSTRAINT PK_ContactInfo PRIMARY KEY (person_id);


CREATE TABLE Email (
 email VARCHAR(50) NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE Email ADD CONSTRAINT PK_Email PRIMARY KEY (email);


CREATE TABLE InstrumentRental (
 rental_id SERIAL NOT NULL,
 instrument_id INT NOT NULL,
 rental_period INT NOT NULL,
 end_date DATE NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE InstrumentRental ADD CONSTRAINT PK_InstrumentRental PRIMARY KEY (rental_id);


CREATE TABLE InstrumentSkill (
 person_id INT NOT NULL,
 instrument VARCHAR(30) NOT NULL,
 Instrument_skill_level INT NOT NULL
);

ALTER TABLE InstrumentSkill ADD CONSTRAINT PK_InstrumentSkill PRIMARY KEY (person_id);


CREATE TABLE Payment (
 payment_id SERIAL NOT NULL,
 amount FLOAT(10) NOT NULL,
 payment_date DATE NOT NULL,
 person_id INT
);

ALTER TABLE Payment ADD CONSTRAINT PK_Payment PRIMARY KEY (payment_id);


CREATE TABLE Phone (
 phone INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE Phone ADD CONSTRAINT PK_Phone PRIMARY KEY (phone);


CREATE TABLE Instructor (
 person_id INT NOT NULL,
 instruments_taught VARCHAR(10) NOT NULL,
 school_id VARCHAR(30) NOT NULL,
 payment_id INT
);

ALTER TABLE Instructor ADD CONSTRAINT PK_Instructor PRIMARY KEY (person_id);


CREATE TABLE Lesson (
 lesson_id SERIAL NOT NULL,
 lesson_type VARCHAR(10) NOT NULL,
 lesson_skill_level INT NOT NULL,
 genre VARCHAR(20) DEFAULT 'NULL',
 person_id INT
);

ALTER TABLE Lesson ADD CONSTRAINT PK_Lesson PRIMARY KEY (lesson_id);


ALTER TABLE SiblingGroup ADD CONSTRAINT FK_SiblingGroup_0 FOREIGN KEY (person_id) REFERENCES Student (person_id);


ALTER TABLE Student ADD CONSTRAINT FK_Student_0 FOREIGN KEY (person_id) REFERENCES Person (person_id);
ALTER TABLE Student ADD CONSTRAINT FK_Student_1 FOREIGN KEY (school_id) REFERENCES School (school_id);
ALTER TABLE Student ADD CONSTRAINT FK_Student_2 FOREIGN KEY (sibling_group_id) REFERENCES SiblingGroup (sibling_group_id);


ALTER TABLE Application ADD CONSTRAINT FK_Application_0 FOREIGN KEY (person_id) REFERENCES Student (person_id);
ALTER TABLE Application ADD CONSTRAINT FK_Application_1 FOREIGN KEY (school_id) REFERENCES School (school_id);


ALTER TABLE ContactInfo ADD CONSTRAINT FK_ContactInfo_0 FOREIGN KEY (person_id) REFERENCES Person (person_id);


ALTER TABLE Email ADD CONSTRAINT FK_Email_0 FOREIGN KEY (person_id) REFERENCES Person (person_id);
ALTER TABLE Email ADD CONSTRAINT FK_Email_1 FOREIGN KEY (person_id) REFERENCES ContactInfo (person_id);


ALTER TABLE InstrumentRental ADD CONSTRAINT FK_InstrumentRental_0 FOREIGN KEY (instrument_id) REFERENCES Instrument (instrument_id);
ALTER TABLE InstrumentRental ADD CONSTRAINT FK_InstrumentRental_1 FOREIGN KEY (person_id) REFERENCES Student (person_id);


ALTER TABLE InstrumentSkill ADD CONSTRAINT FK_InstrumentSkill_0 FOREIGN KEY (person_id) REFERENCES Student (person_id);
ALTER TABLE InstrumentSkill ADD CONSTRAINT FK_InstrumentSkill_1 FOREIGN KEY (person_id) REFERENCES Person (person_id);


ALTER TABLE Payment ADD CONSTRAINT FK_Payment_0 FOREIGN KEY (person_id) REFERENCES Student (person_id);


ALTER TABLE Phone ADD CONSTRAINT FK_Phone_0 FOREIGN KEY (person_id) REFERENCES Person (person_id);
ALTER TABLE Phone ADD CONSTRAINT FK_Phone_1 FOREIGN KEY (person_id) REFERENCES ContactInfo (person_id);


ALTER TABLE Instructor ADD CONSTRAINT FK_Instructor_0 FOREIGN KEY (person_id) REFERENCES Person (person_id);
ALTER TABLE Instructor ADD CONSTRAINT FK_Instructor_1 FOREIGN KEY (school_id) REFERENCES School (school_id);
ALTER TABLE Instructor ADD CONSTRAINT FK_Instructor_2 FOREIGN KEY (payment_id) REFERENCES Payment (payment_id);


ALTER TABLE Lesson ADD CONSTRAINT FK_Lesson_0 FOREIGN KEY (person_id) REFERENCES Instructor (person_id);
ALTER TABLE Lesson ADD CONSTRAINT FK_Lesson_1 FOREIGN KEY (person_id) REFERENCES Student (person_id);


