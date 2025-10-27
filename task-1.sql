/*
Task 1:
1.	Create the following database schema
employee (ecode, name, dept, salary)
2.	Describe the structure of the table employee
3.	Insert 10 rows in this table
4.	Show all the data of that table
5.	Select the employees who work in CSE department
6.	Drop the table
*/

CREATE TABLE Schema_Employee (
  ecode INT,
  Name varchar(50),
  department varchar(50),
  salary INT
);

INSERT INTO Schema_Employee (ecode, Name, department, salary) VALUES
("1", "Pranjal Sharma", "CSCS", "100000"),
("2", "Yug Rohilla", "CSE", "100000"),
("3", "Prajwal Chouhan", "CSECS", "100000"),
("4", "Arnav Garg", "CSE", "100000"),
("5", "Aryan Sharma", "CSECS", "100000"),
("6", "Tanmay Sharma", "CSECS", "100000"),
("7", "Rijul Sharma", "CSECS", "100000"),
("8", "Vansh Thakur", "CSECS", "100000"),
("9", "Pranay Sharma", "CSECS", "100000"),
("10", "Akshat Yadav", "CSECS", "100000");

SELECT ecode, Name, department salary
FROM Schema_Employee;

SELECT ecode, Name, department, salary 
FROM Schema_Employee 
where department = 'CSE';

DROP TABLE Schema_Employee;

/*Name : Vansh Thakur
Roll Number : 241034014
Batch : 24K11
*/