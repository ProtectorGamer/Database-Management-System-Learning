/*
Write an SQL query to create a table named Students with the following columns:
•	StudentID (integer, primary key)
•	Name (varchar(50))
•	Age (integer)
•	Major (varchar(50))

•	Write an SQL query to insert the following data into the Students table:
(1, 'Alice', 20, 'Computer Science')
(2, 'Bob', 22, 'Mathematics')
(3, 'Charlie', 19, 'Physics')

Write an SQL query to select all records from the Students table.
Write an SQL query to select only the Name and Major columns from the Students table.
Write an SQL query to find all students who are older than 20.
Write an SQL query to update the Major of student with StudentID 3 to 'Chemistry'.
Write an SQL query to delete the student with StudentID 2 from the Students table.
Write an SQL query to count the number of students in the Students table.
Write an SQL query to select all students ordered by Age in descending order.
Write an SQL query to select all students
*/

CREATE TABLE Students
(
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Major VARCHAR(50)
);

INSERT INTO Students (StudentID, Name, Age, Major) VALUES
(1, 'Alice', 20, 'Computer Science'),
(2, 'Bob', 22, 'Mathematics'),
(3, 'Charlie', 19, 'Physics');

SELECT * FROM Students;

SELECT Name, Major
FROM Students;

SELECT *
FROM Students
WHERE Age > 20;

UPDATE Students 
SET Major = 'Chemistry' 
WHERE StudentID = 3;

DELETE FROM Students 
WHERE StudentID = 2;

SELECT COUNT(*) AS student_count
FROM Students;

SELECT *
FROM Students
ORDER BY Age ASC;

