/* ===========================================================
   COURSE REGISTRATION & TIMETABLE CLASH CHECKER
   Database : juit_project1
   Made By : Vansh Thakur (241034014) & Yug Rohilla (241034022)
   =========================================================== */
USE juit_project1;

-- 3.1 STUDENT table
CREATE TABLE student (
    student_id      INT PRIMARY KEY AUTO_INCREMENT,
    roll_no         VARCHAR(20) NOT NULL UNIQUE,
    name            VARCHAR(100) NOT NULL,
    department      VARCHAR(50),
    year_of_study   INT CHECK (year_of_study BETWEEN 1 AND 4),
    email           VARCHAR(100)
) ENGINE = InnoDB;

-- 3.2 COURSE table
CREATE TABLE course (
    course_id    INT PRIMARY KEY AUTO_INCREMENT,
    course_code  VARCHAR(10) NOT NULL UNIQUE,
    title        VARCHAR(100) NOT NULL,
    credits      INT NOT NULL CHECK (credits BETWEEN 1 AND 5),
    department   VARCHAR(50)
) ENGINE = InnoDB;

-- 3.3 SECTION table
CREATE TABLE section (
    section_id    INT PRIMARY KEY AUTO_INCREMENT,
    course_id     INT NOT NULL,
    section_code  VARCHAR(10) NOT NULL,
    faculty_name  VARCHAR(100),
    day_of_week   ENUM('MON','TUE','WED','THU','FRI','SAT') NOT NULL,
    start_time    TIME NOT NULL,
    end_time      TIME NOT NULL,
    room          VARCHAR(20),
    max_seats     INT NOT NULL CHECK (max_seats > 0),

    CONSTRAINT fk_section_course
        FOREIGN KEY (course_id)
        REFERENCES course(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT uq_course_section UNIQUE (course_id, section_code),
    CONSTRAINT chk_section_time CHECK (start_time < end_time)
) ENGINE = InnoDB;

-- 3.4 ENROLLMENT table
CREATE TABLE enrollment (
    enrollment_id  INT PRIMARY KEY AUTO_INCREMENT,
    student_id     INT NOT NULL,
    section_id     INT NOT NULL,
    enroll_time    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status         ENUM('ENROLLED','DROPPED') DEFAULT 'ENROLLED',

    CONSTRAINT fk_enroll_student
        FOREIGN KEY (student_id)
        REFERENCES student(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_enroll_section
        FOREIGN KEY (section_id)
        REFERENCES section(section_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT uq_student_section UNIQUE (student_id, section_id)
) ENGINE = InnoDB;

-- 4.1 Students
INSERT INTO student (roll_no, name, department, year_of_study, email) VALUES
('CSE23001', 'Arjun Sharma', 'CSE', 2, 'arjun@juit.ac.in'),
('CSE23002', 'Sneha Verma', 'CSE', 2, 'sneha@juit.ac.in'),
('CSE23003', 'Rohan Gupta', 'CSE', 2, 'rohan@juit.ac.in'),
('ECE23001', 'Priya Singh', 'ECE', 2, 'priya@juit.ac.in'),
('IT23001',  'Rahul Mehta', 'IT',  2, 'rahul@juit.ac.in');

-- 4.2 Courses
INSERT INTO course (course_code, title, credits, department) VALUES
('CSE201', 'Data Structures',       4, 'CSE'),
('CSE202', 'Database Systems',      4, 'CSE'),
('CSE203', 'Operating Systems',     4, 'CSE');

-- 4.3 Sections
INSERT INTO section (course_id, section_code, faculty_name,
                     day_of_week, start_time, end_time, room, max_seats)
VALUES
-- CSE201 - Data Structures
(1, 'A', 'Dr. A. Kumar', 'MON', '09:00:00', '10:00:00', 'LT-101', 2), 
(1, 'B', 'Dr. A. Kumar', 'TUE', '11:00:00', '12:00:00', 'LT-102', 40),

-- CSE202 - DBMS
(2, 'A', 'Dr. B. Verma', 'MON', '09:30:00', '10:30:00', 'LT-103', 40),
(2, 'B', 'Dr. B. Verma', 'WED', '14:00:00', '15:00:00', 'LT-104', 40),

-- CSE203 - OS
(3, 'A', 'Dr. C. Singh', 'THU', '10:00:00', '11:00:00', 'LT-105', 40);

INSERT INTO enrollment (student_id, section_id, status) VALUES
(4, 2, 'ENROLLED'),
(5, 5, 'ENROLLED'); 


-- 5.1 Student timetable view
CREATE VIEW v_student_timetable AS
SELECT
    s.student_id,
    s.roll_no,
    s.name AS student_name,
    c.course_code,
    c.title AS course_title,
    sec.section_code,
    sec.day_of_week,
    sec.start_time,
    sec.end_time,
    sec.room
FROM student s
JOIN enrollment e   ON s.student_id = e.student_id
JOIN section sec    ON e.section_id = sec.section_id
JOIN course c       ON sec.course_id = c.course_id
WHERE e.status = 'ENROLLED';

-- 5.2 Section load (how many enrolled vs max seats)
CREATE VIEW v_section_load AS
SELECT
    sec.section_id,
    c.course_code,
    sec.section_code,
    sec.day_of_week,
    sec.start_time,
    sec.end_time,
    sec.room,
    sec.max_seats,
    COUNT(CASE WHEN e.status = 'ENROLLED' THEN 1 END) AS enrolled_students
FROM section sec
JOIN course c ON sec.course_id = c.course_id
LEFT JOIN enrollment e ON sec.section_id = e.section_id
GROUP BY
    sec.section_id,
    c.course_code,
    sec.section_code,
    sec.day_of_week,
    sec.start_time,
    sec.end_time,
    sec.room,
    sec.max_seats;

-- ===========================================================
-- 6. STORED PROCEDURE WITH TRANSACTION
-- ===========================================================

DELIMITER $$

CREATE PROCEDURE register_student_for_section (
    IN p_student_id INT,
    IN p_section_id INT
)
BEGIN
    DECLARE v_max_seats INT;
    DECLARE v_current_enrolled INT;
    DECLARE v_day_of_week VARCHAR(10);
    DECLARE v_start_time TIME;
    DECLARE v_end_time TIME;
    DECLARE v_clash_count INT;

    -- Ensure we found a section
    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    START TRANSACTION;

    -- 1. Fetch section details (and lock the row)
    SET v_not_found = FALSE;

    SELECT max_seats, day_of_week, start_time, end_time
    INTO v_max_seats, v_day_of_week, v_start_time, v_end_time
    FROM section
    WHERE section_id = p_section_id
    FOR UPDATE;

    IF v_not_found OR v_max_seats IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Section does not exist';
    END IF;

    -- 2. Check capacity for this section
    SELECT COUNT(*)
    INTO v_current_enrolled
    FROM enrollment
    WHERE section_id = p_section_id
      AND status = 'ENROLLED'
    FOR UPDATE;

    IF v_current_enrolled >= v_max_seats THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Section is full';
    END IF;

    -- 3. Check timetable clash:
    SELECT COUNT(*)
    INTO v_clash_count
    FROM enrollment e
    JOIN section s ON e.section_id = s.section_id
    WHERE e.student_id = p_student_id
      AND e.status = 'ENROLLED'
      AND s.day_of_week = v_day_of_week
      AND s.start_time < v_end_time
      AND v_start_time < s.end_time
    FOR UPDATE;

    IF v_clash_count > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Timetable clash detected for this student';
    END IF;

    -- 4. If everything is OK, insert enrollment
    INSERT INTO enrollment (student_id, section_id, status)
    VALUES (p_student_id, p_section_id, 'ENROLLED');

    COMMIT;
END$$

DELIMITER ;

-- 7.1 Check current section loads
SELECT * FROM v_section_load;

CALL register_student_for_section(1, 1);

CALL register_student_for_section(2, 1);

CALL register_student_for_section(1, 4);

SELECT * FROM enrollment;

SELECT *
FROM v_student_timetable
WHERE student_id = 1
ORDER BY
    FIELD(day_of_week,'MON','TUE','WED','THU','FRI','SAT'),
    start_time;

-- 7.9 See all section loads again
SELECT * FROM v_section_load;
