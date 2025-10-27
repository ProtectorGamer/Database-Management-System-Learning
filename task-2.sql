/*
Task 2:
Create a table with the name “Friends” and store the record of 5 friends which includes their Name, DOB, Email, City and Mobile. 
*/

CREATE TABLE Friends 
(
    Name VARCHAR(50),
    DOB DATE,
    Email VARCHAR(50),
    City VARCHAR(50),
    PhoneNumber INT(15)
);

INSERT INTO Friends (Name, DOB, Email, City, PhoneNumber) VALUES
("Vansh Thakur", "21-10-2005", "vanshc509@gmail.com", "Himachal Pradesh", "9418793120"),
("Yug Rohilla", "08-07-2006", "yugrohilla@gmail.com", "Haryana", "9418817010"),
("Rijul Sharma", "12-01-2007", "rijulsharma@gmail.com", "Uttar Pradesh", "8752103489"),
("Aryan Sharma", "14-04-2006", "aryansharma@gmail.com", "Himachal Pradesh", "9876541001"),
("Jamshed Singh", "08-08-2006", "Jamshed@gmail.com", "Delhi", "9856324780");

SELECT * FROM Friends;

/*Name : Vansh Thakur
Roll Number : 241034014
Batch : 24K11
*/
