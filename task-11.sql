use juit_project1;

CREATE TABLE Departments 
(
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Students 
(
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

INSERT INTO Departments VALUES
(1, 'CSE'),
(2, 'ECE'),
(3, 'Mechanical');

INSERT INTO Students VALUES
(101, 'Aman', 1),
(102, 'Riya', 2);

CREATE VIEW StudentDetails AS
SELECT 
    s.student_id,
    s.name,
    s.dept_id,
    d.dept_name
FROM Students s
JOIN Departments d
ON s.dept_id = d.dept_id;

INSERT INTO StudentDetails (student_id, name, dept_id, dept_name)
VALUES (10, 'Rohan', 5, 'Civil');

DROP VIEW StudentDetails;

CREATE VIEW StudentDetails AS
SELECT 
    s.student_id,
    s.name,
    s.dept_id,
    d.dept_name
FROM Students s
JOIN Departments d
ON s.dept_id = d.dept_id
WITH CHECK OPTION;

INSERT INTO StudentDetails (student_id, name, dept_id)
VALUES (11, 'Aarav', 3);

INSERT INTO StudentDetails (student_id, name, dept_id)
VALUES (12, 'Karan', 99);
