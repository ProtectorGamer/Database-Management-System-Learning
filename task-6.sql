/*
Task 1:
1. Create the following relational schema & add appropriate constraints:
student (rolln, name, age, branch, marks)
2.	Insert record of 10 students
3.	Find sum of marks of all the students
4.	Find youngest student among the students.
5.	Find the average marks of students of ‘IT’ branch.
6.	Retrieve the total number of students
7.	Display record of students in decreasing order of their marks
8.	Find average marks of students of each branch (branch wise)
*/

USE juit_project1;

CREATE TABLE student
(
    rollnumber INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    branch VARCHAR(10),
    marks INT
);

INSERT INTO student VALUES
(001, 'Rijul Sharma', 18, 'CSE', 85),
(002, 'Yug Rohilla', 19, 'ITI', 10),
(003, 'Vansh Thakur', 19, 'CSE', 75),
(004, 'Akshita Sood' , 19, 'IT', 90),
(005, 'Pranjal Sharma', 20, 'CSE', 80),
(006, 'Nayan Sharma', 19, 'IT', 85),
(007, 'Prajwal Chouhan', 20, 'ECE', 90),
(008, 'Tanmay Sharma', 19, 'ECE', 70),
(009, 'Aryan Sharma', 19, 'IT', 77),
(010, 'Tanish Jain', 19, 'CSE', 88),
(011, 'Akshat Yadav', 19, 'IT', 85);


SELECT *
FROM student
WHERE age >= 20;

SELECT SUM(marks)
AS total_marks
FROM student;

SELECT *
FROM student
WHERE age = (SELECT MIN(age) FROM student);

SELECT AVG(marks)
AS avg_it_marks
FROM student
WHERE branch = 'IT';

SELECT COUNT(*)
AS total_students
FROM student;

SELECT *
FROM student
ORDER BY marks DESC;

SELECT branch, AVG(marks)
AS avg_branch_marks
FROM student
GROUP BY branch;