use juit_project1;

CREATE TABLE Employees 
(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    dept_id INT
);

CREATE TABLE Departments 
(
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Orders 
(
    order_id INT PRIMARY KEY,
    employee_id INT,
    customer_id INT,
    order_amount DECIMAL(10,2),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Departments VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'Finance');

INSERT INTO Employees VALUES
(101, 'Amit', 1),
(102, 'Riya', 1),
(103, 'Karan', 2),
(104, 'Megha', 3);

INSERT INTO Orders VALUES
(1, 101, 9001, 500),
(2, 101, 9002, 700),
(3, 101, 9003, 800),
(4, 101, 9004, 600),
(5, 101, 9005, 900),
(6, 101, 9006, 450),
(7, 101, 9007, 1200),
(8, 101, 9008, 300),
(9, 101, 9009, 750),
(10, 101, 9010, 620),
(11, 101, 9011, 400);

INSERT INTO Orders VALUES
(12, 102, 9020, 1000),
(13, 102, 9021, 800);


CREATE VIEW Employee_Sales_Summary AS
SELECT 
    employee_id,
    SUM(order_amount) AS total_sales_amount,
    COUNT(customer_id) AS total_customers_served,
    AVG(order_amount) AS average_order_value
FROM Orders
GROUP BY employee_id
HAVING COUNT(*) > 10;

DROP VIEW Employee_Sales_Summary;

CREATE VIEW Employee_Sales_Summary AS
SELECT 
    o.employee_id,
    SUM(o.order_amount) AS total_sales_amount,
    COUNT(o.customer_id) AS total_customers_served,
    AVG(o.order_amount) AS average_order_value,
    d.dept_name
FROM Orders o
JOIN Employees e
    ON o.employee_id = e.employee_id
JOIN Departments d
    ON e.dept_id = d.dept_id
GROUP BY 
    o.employee_id,
    d.dept_name
HAVING COUNT(*) > 10;
