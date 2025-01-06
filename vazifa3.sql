-- jadval 1 ----------------------------
CREATE TABLE IF NOT EXISTS school(
	school_id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	address VARCHAR(30),
	phone_number CHAR(13),
	davlat_maktabi BOOL Default false
); 

-- jadval 2 ----------------------------
CREATE TABLE IF NOT EXISTS teacher(
	teacher_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL, 
	email VARCHAR(50),
	phone_number CHAR(13),
	school_id INT REFERENCES school(school_id)
); 

-- jadval 3 ----------------------------
CREATE TABLE IF NOT EXISTS student(
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL, 
	date_of_birth DATE,
	gender CHAR(1),
	school_id INT REFERENCES school(school_id)
); 

-- jadval 4 ----------------------------
CREATE TABLE IF NOT EXISTS class(
	class_id SERIAL PRIMARY KEY,
	class_name VARCHAR(50) NOT NULL,
	teacher_id INT REFERENCES teacher(teacher_id),
	school_id INT REFERENCES school(school_id)
);

-- jadval 5 ----------------------------
CREATE TABLE IF NOT EXISTS subject(
	subject_id SERIAL PRIMARY KEY,
	subject_name VARCHAR(50) NOT NULL,
	class_id INT REFERENCES class(class_id),
	teacher_id INT REFERENCES teacher(teacher_id)
);

-- jadval 6 ----------------------------
CREATE TABLE IF NOT EXISTS enrollment(
	enrollment_id SERIAL PRIMARY KEY,
	student_id INT REFERENCES student(student_id),
	class_id INT REFERENCES class(class_id),
	enrollment_date DATE default CURRENT_DATE
);

-- jadval 7 ----------------------------
CREATE TABLE IF NOT EXISTS grade(
	garde_id SERIAL PRIMARY KEY,
	student_id INT REFERENCES student(student_id),
	subject_id INT REFERENCES subject(subject_id),
	grade_value DECIMAL(4, 2),
	date_given TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

-- jadval 8 ----------------------------
CREATE TABLE IF NOT EXISTS attendance(
	attendance_id SERIAL PRIMARY KEY,
	student_id INT REFERENCES student(student_id),
	class_id INT REFERENCES class(class_id),
	attendance_date DATE default CURRENT_DATE
);



INSERT INTO school(name, address, phone_number, davlat_maktabi) VALUES 
('Maktab 1', 'Fergana', '+998777777711', 'False'),
('Maktab 2', 'Fergana', '+998950010203', 'True');

INSERT INTO teacher(first_name, last_name, email, phone_number, school_id) VALUES 
('Toxir', 'Toxirov', 'Toxirov1234@gmail.com', '+998955515151', 1),
('Sobir', 'Sobirov', 'Sobirov1234@gmail.com', '+998900020408', 2);

INSERT INTO student(first_name, last_name, date_of_birth, gender, school_id) VALUES 
('Jalil', 'Jalilov', '2008-08-04', 'M',  1),
('Zarina', 'Karimova', '2009-07-20', 'F', 2);

INSERT INTO class(class_name, teacher_id, school_id) VALUES 
('10-A', 1, 1),
('9-B', 2, 2);

INSERT INTO subject(subject_name, class_id, teacher_id) VALUES 
('Matematika', 1, 1),
('Tarix', 2, 2);

INSERT INTO enrollment(class_id, student_id) VALUES 
(1, 1),
(2, 2);

INSERT INTO grade(student_id, subject_id, grade_value) VALUES
(, 1, 90.5),
(2, 2, 85.0);

INSERT INTO attendance(student_id, class_id) VALUES
(1, 1),
(2, 2);


SELECT school_id, name, address, phone_number, TO_CHAR(davlat_maktabi, 'FMYes/No') AS davlat_maktabi FROM school;
SELECT teacher_id, first_name, last_name, email, phone_number, school_id FROM teachers;
SELECT studentid, first_name, last_name, TO_CHAR(date_of_birth, 'DD-MM-YYYY') AS date_of_birth, gender, school_id FROM student;
SELECT class_id, class_name, teacher_id, school_id FROM class;
SELECT subject_id, subject_name, class_id, teacher_id FROM subject;
SELECT enrollment_id, student_id, class_id, TO_CHAR(enrollment_date, 'DD/MM/YYYY') AS enrollment_date FROM enrollment;
SELECT garde_id, student_id, subject_id, grade_value, TO_CHAR(date_given, 'DD/MM/YYYY HH24:MI:SS') AS date_given FROM grade;
SELECT attendance_id, student_id, class_id, TO_CHAR(attendance_date, 'DD/MM/YYYY') AS DATE FROM attendance;


ALTER TABLE school RENAME TO schools;
ALTER TABLE teacher RENAME TO teachers;


ALTER TABLE student RENAME COLUMN first_name TO given_name;
ALTER TABLE student RENAME COLUMN last_name TO family_name;
ALTER TABLE class RENAME COLUMN class_name TO name;


ALTER TABLE class DROP COLUMN teacher_id;


DELETE FROM attendance WHERE attendance_id = 1;
DELETE FROM grade WHERE garde_id = 2;
DELETE FROM enrollment WHERE enrollment_id = 1;
DELETE FROM subject WHERE subject_id = 2;


