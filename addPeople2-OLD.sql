-- Insert data into 'Person'
INSERT INTO Person (person_id, name, address)
VALUES
(1, 'John Doe', '123 Main St'),
(2, 'Jane Smith', '456 Broadway St'),
(3, 'Alice Johnson', '789 Second St');

-- Insert data into 'SiblingGroup'
INSERT INTO SiblingGroup (sibling_group_id, person_id)
VALUES
(1, 2),
(2, 3);

-- Insert data into 'School'
INSERT INTO School (school_id, max_students, available_spots)
VALUES
(1, 100, 10);

-- Insert data into 'Student'
INSERT INTO Student (person_id, school_id, contact_person, sibling_group_id)
VALUES
(1, 1, NULL, NULL),
(2, 1, 1, 1),
(3, 1, 1, 2);

-- Insert data into 'Instructor'
INSERT INTO Instructor (person_id, instruments_taught, school_id, payment_id)
VALUES
(4, 'Guitar', 1, NULL);

-- Insert data into 'Lesson'
INSERT INTO Lesson (lesson_id, lesson_type, skill_level, genre, person_id)
VALUES
(1, 'Group', 'Beginner', 'Rock', 4);

-- Insert data into 'Payment'
INSERT INTO Payment (payment_id, amount, payment_date, person_id)
VALUES
(1, 100.00, '2023-11-01', 1);

-- Insert data into 'Application'
INSERT INTO Application (application_id, person_id, school_id, name, personal_number, address)
VALUES
(1, 1, 1, 'John Doe', '123456789', '123 Main St');

-- Insert data into 'Instrument'
INSERT INTO Instrument (instrument_id, instrument_type, instrument_category, instrument_price)
VALUES
(1, 'Guitar', 'String', 100);

-- Insert data into 'InstrumentRental'
INSERT INTO InstrumentRental (rental_id, instrument_id, rental_period, end_date, person_id)
VALUES
(1, 1, 6, '2023-12-01', 1);

-- Insert data into 'Email'
INSERT INTO Email (email, person_id)
VALUES
('john@example.com', 1),
('jane@example.com', 2);

-- Insert data into 'Phone'
INSERT INTO Phone (phone, person_id)
VALUES
(1234567890, 1),
(2345678901, 2);
