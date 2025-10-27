/*
1.	Add two new columns with the name Gender & Email in this employee table
employee (ecode, name, dept, salary)
2.	Describe the structure of the table employee
3.	Update the values of gender for all employees & Email for some of the employees
4.	Display the table
5.	Delete salary column
6.	Modify the datatype of ecode column.
*/

CREATE TABLE employee (
  ecode INT,
  Name varchar(50),
  department varchar(50),
  salary INT
);

INSERT INTO employee (ecode, Name, department, salary) VALUES
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

ALTER TABLE employee ADD Gender VARCHAR(50);
ALTER TABLE employee ADD Email VARCHAR(50);

UPDATE employee SET Gender = 'Male';

UPDATE employee SET Email = 'Test@gmail.com' WHERE name = 'Vansh Thakur';
UPDATE employee SET Email = 'testing@gmail.com' WHERE name = 'Rijul Sharma';

SELECT * FROM employee;

ALTER TABLE employee DROP salary;

ALTER TABLE employee MODIFY COLUMN ecode VARCHAR(50);
