/*
Task 8:

1. Run at least 5 built-in functions applicable on numeric data (not discussed in lab)
2. Run at least 5 built-in functions applicable on character strings (not discussed in
lab)
3. Run any 5 built-in date-time functions.
*/

USE juit_project1;

CREATE TABLE Employes
(
    UID INT(5) PRIMARY KEY,
    Name VARCHAR(50),
    Class VARCHAR(10),
    Phone_Number VARCHAR(50),
    Pincode INT(20),
    Salary INT(10)
);

INSERT INTO Employes VALUES
('1', 'Vansh Thakur', '10', '9418793120', 400054, 40000),
('2', 'Mayank Sharma', '11', '8580438452', 780001, 36000),
('3', 'Ajay', '12', '8544700833', 400054, 30000),
('4', 'Protector', '10', '9418433745', 400054, 50000),
('5', 'Ravi', '11', '9418791000', 100001, 50000),
('6', 'Prajwal', '12', '9816068100', 132001, 38000);

SELECT *
FROM Employes
WHERE MOD(Salary, 30) = 0;

SELECT *
FROM Employes;
-- 1. Run at least 5 built-in functions applicable on numeric data

SELECT 
MAX(Salary) AS Maximum_Salary,
MIN(Salary) AS Minimum_Salary,
SUM(Salary) AS Total_Salary,
AVG(Salary) AS Average_Salary
FROM Employes;

-- 2. Run at least 5 built-in functions applicable on character strings

SELECT
UPPER(Name),
LOCATE(10, Class),
REVERSE(Name),
LOWER(Name),
POSITION(11 IN Class)
FROM Employes;

-- 3. Run any 5 built-in date-time functions.

SELECT 
CURRENT_DATE() AS Date,
CURRENT_TIMESTAMP() AS TimeStamp,
CURRENT_TIME() AS Time,
DATE_ADD(CURRENT_DATE(), INTERVAL 10 DAY) AS Dates,
DAYNAME(CURRENT_DATE()) AS CurrentDay;

