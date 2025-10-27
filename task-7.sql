/*
1. Create the table Client to store information about clients with following fields
Client_no as varchar of size 6 (primary key/first letter must start with ‘C’)
Name as varchar of size 20(not null)
City as varchar of size 15
State as varchar of size 15
Pincode as number of size 6
Salary as number of size 6
Insert following records into the client table
Client_no Name City State Pincode Salary
C00001 Ivan Bombay Maharashtra 400054 40,000
C00002 Vandana Madras Tamil Nadu 780001 36,000
C00003 Pramda Bombay Maharashtra 400054 30,000
C00004 Basu Bombay Maharashtra 400054 55,965
C00005 Ravi Delhi ---- 100001 28,563
C00006 Preeti Karnal Haryana 132001 38,000
2. Find the records of those person who either live in Delhi or Bombay
3. Find out the names of the Clients having ‘a’ as second character in their names and live
in ‘Maharashtra’
4. Find the clients whose salary lies between 30,000 and 40,000
5. List the names, city and state of clients not in the state of ‘Maharashtra’
*/

USE juit_project1;

CREATE TABLE Clients
(
    Client_no VARCHAR(6) PRIMARY KEY CHECK (Client_no LIKE 'C%'),
    Name VARCHAR(20) NOT NULL,
    City VARCHAR(15),
    State VARCHAR(15),
    Pincode NUMERIC(6),
    Salary NUMERIC(6)
);

INSERT INTO Clients (Client_no, Name, City, State, Pincode, Salary) VALUES
('C00001', 'Ivan', 'Bombay', 'Maharashtra', 400054, 40000),
('C00002', 'Vandana', 'Madras', 'Tamil Nadu', 780001, 36000),
('C00003', 'Pramda', 'Bombay', 'Maharashtra', 400054, 30000),
('C00004', 'Basu', 'Bombay', 'Maharashtra', 400054, 55965),
('C00005', 'Ravi', 'Delhi', NULL, 100001, 28563),
('C00006', 'Preeti', 'Karnal', 'Haryana', 132001, 38000);

SELECT * 
FROM Clients
WHERE City IN ('Delhi', 'Bombay');

SELECT Name 
FROM Clients
WHERE Name LIKE '_a%' 
  AND State = 'Maharashtra';

SELECT * 
FROM Clients
WHERE Salary BETWEEN 30000 AND 40000;

SELECT Name, City, State
FROM Clients
WHERE State <> 'Maharashtra'; 