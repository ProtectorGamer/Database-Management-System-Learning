USE juit_project1;

CREATE TABLE Department(
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    DeptID INT,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

INSERT INTO Department (DeptID, DeptName, Location) VALUES
(1, 'HR', 'Delhi'),
(2, 'IT', 'Mumbai'),
(3, 'Finance', 'Delhi'),
(4, 'Admin', 'Bangalore');

INSERT INTO Employee (EmpID, EmpName, DeptID, Salary) VALUES
(201, 'Rohan', 1, 35000),
(202, 'Neha', 2, 45000),
(203, 'Karan', 1, 30000),
(204, 'Mehul', 3, 50000),
(205, 'Shalini', 2, 40000);

SELECT E.EmpName
FROM Employee E
JOIN Department D ON E.DeptID = D.DeptID
WHERE D.DeptName = 'IT';

SELECT DeptName
FROM Department
WHERE Location = 'Delhi';

SELECT E.EmpName, D.Location
FROM Employee E
INNER JOIN Department D ON E.DeptID = D.DeptID;


SELECT D.DeptName, E.EmpName
FROM Employee E
RIGHT JOIN Department D ON E.DeptID = D.DeptID;
