CREATE TABLE Students
(
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    Major VARCHAR(50)
);

CREATE TABLE Courses
(
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT
);

CREATE TABLE Enrollments
(
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(2)
);

INSERT INTO Students (student_id, first_name, last_name, age, Major) VALUES
(1, 'Yug', 'Rohilla', 20, 'Computer Science'),
(2, 'Vansh', 'Thakur', 22, 'Cyber Security'),
(3, 'Tanmay', 'Sharma', 19, 'Electrical Engineering'),
(4, 'Rijul', 'Sharma', 18, 'Computer Science'),
(5, 'Aryan', 'Sharma', 19, 'Computer Science');

INSERT INTO Courses (course_id, course_name, credits) VALUES
(101, 'Mathematics', 3),
(102, 'Physics', 2),
(103, 'Cyber Security', 4),
(104, 'DBMS Lab', 2),
(105, 'Programming Language', 3);

INSERT INTO Enrollments (enrollment_id, student_id, course_id, grade) VALUES
(1, 1, 101, 'A'),
(2, 2, 103, 'B'),
(3, 3, 102, 'A'),
(4, 4, 101, 'C'),
(5, 5, 105, 'A'),
(6, 1, 103, 'B'),
(7, 2, 105, 'A');


SELECT * FROM Students;

SELECT first_name, last_name
FROM Students;

SELECT *
FROM Students
WHERE age >= 20;

SELECT *
FROM Students
WHERE Major = 'Computer Science';

SELECT *
FROM Courses;

SELECT *
FROM Courses
WHERE credits >= 3;

SELECT *
FROM Enrollments
WHERE grade = 'A';


/*
Name : Vansh Thakur
Roll Number : 241034014
Batch : 24K-11
*/