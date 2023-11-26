INSERT INTO instructor (first_name, last_name, person_number, street, zip, city, ensamble, phone_number)
VALUES
('John', 'Doe', '123456789012', '123 Main St', '12345', 'Anytown', FALSE, '1234567890'),
('Jane', 'Smith', '234567890123', '456 Elm St', '23456', 'Othertown', TRUE, '2345678901'),
;

INSERT INTO student (first_name, last_name, person_number, street, zip, city, sibling)
VALUES
('Alice', 'Johnson', '345678901234', '789 Oak St', '34567', 'Thistown', NULL),
('Bob', 'Brown', '456789012345', '012 Pine St', '45678', 'Thatown', NULL),
;

INSERT INTO contact (contact_id, phone_number)
VALUES
(1, '555-1234'),
(2, '555-2345'),
(3, '555-3456'),
;

INSERT INTO instrument (type, brand, price, category, available)
VALUES
('Guitar', 'Fender', 500, 'String', TRUE),
('Piano', 'Yamaha', 1500, 'Keyboard', TRUE),
('Violin', 'Stradivarius', 1200, 'String', FALSE),
('Drums', 'Pearl', 800, 'Percussion', TRUE),
;

INSERT INTO instructor_instrument (instructor_instrument_id, instructor_id, instructor_instrument_type)
VALUES
(1, 1, 'Guitar'),  -- Linking the first instrument to the first instructor
(2, 1, 'Violin'),  -- Linking the second instrument to the first instructor
(3, 2, 'Drums'),  -- Linking the third instrument to the second instructor
-- Add more rows as needed
;

INSERT INTO price (payment_id, lecture_price, skill_price, discount)
VALUES
(1, 30, 10, FALSE),
(2, 50, 15, FALSE),
(3, 40, 12, FALSE),
;

INSERT INTO location (classroom_id, room_nr, minimum_students, maximum_students)
VALUES
(1, 101, 5, 30),
(2, 102, 3, 20),
(3, 103, 10, 40),
;

