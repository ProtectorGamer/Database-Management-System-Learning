USE juit_project1;


CREATE TABLE orchestras (
    id             INT PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    rating         DECIMAL(3,1),
    city_origin    VARCHAR(100),
    country_origin VARCHAR(100),
    year_founded   INT
);

CREATE TABLE concerts (
    id           INT PRIMARY KEY,
    city         VARCHAR(100),
    country      VARCHAR(100),
    year         INT,
    rating       DECIMAL(3,1),
    orchestra_id INT,
    FOREIGN KEY (orchestra_id) REFERENCES orchestras(id)
);

CREATE TABLE members (
    id           INT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    position     VARCHAR(100),  
    wage         DECIMAL(10,2),
    experience   INT,
    orchestra_id INT,
    FOREIGN KEY (orchestra_id) REFERENCES orchestras(id)
);

-- Exercise 1:
SELECT DISTINCT o.name
FROM orchestras o
WHERE o.city_origin IN (
    SELECT DISTINCT c.city
    FROM concerts c
    WHERE c.year = 2013
);


-- Exercise 2:
SELECT m.name,
       m.position
FROM members m
JOIN orchestras o
  ON m.orchestra_id = o.id
WHERE m.experience > 10
  AND o.rating >= 8.0;


-- Exercise 3:

SELECT m.name,
       m.position
FROM members m
WHERE m.wage > (
    SELECT AVG(wage)
    FROM members
    WHERE position = 'Violinist'
);


-- Exercise 4:
SELECT o.name
FROM orchestras o
WHERE o.year_founded > (
    SELECT year_founded
    FROM orchestras
    WHERE name = 'Chamber Orchestra'
)
AND o.rating > 7.5;


-- Exercise 5:
SELECT o.name,
       COUNT(m.id) AS number_of_members
FROM orchestras o
LEFT JOIN members m
  ON m.orchestra_id = o.id
GROUP BY o.id, o.name
HAVING COUNT(m.id) > (
    SELECT AVG(member_count)
    FROM (
        SELECT COUNT(m2.id) AS member_count
        FROM orchestras o2
        LEFT JOIN members m2
          ON m2.orchestra_id = o2.id
        GROUP BY o2.id
    ) AS membership_counts
);

-- Course table
CREATE TABLE course (
    id               INT PRIMARY KEY,
    title            VARCHAR(255) NOT NULL,
    learning_path    VARCHAR(255),
    short_description TEXT,
    lecture_hours    INT,
    tutorial_hours   INT,
    ects_points      DECIMAL(4,1),
    has_exam         BOOLEAN,
    has_project      BOOLEAN
);

-- Lecturer table
CREATE TABLE lecturer (
    id         INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name  VARCHAR(100) NOT NULL,
    degree     VARCHAR(50),
    email      VARCHAR(255)
);

-- Student table
CREATE TABLE student (
    id         INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name  VARCHAR(100) NOT NULL,
    email      VARCHAR(255),
    birth_date DATE,
    start_date DATE
);

-- Academic semester table
CREATE TABLE academic_semester (
    id            INT PRIMARY KEY,
    calendar_year INT,
    term          VARCHAR(20),  -- e.g., 'Spring', 'Fall'
    start_date    DATE,
    end_date      DATE
);

-- Course edition table
CREATE TABLE course_edition (
    id                  INT PRIMARY KEY,
    course_id           INT,
    academic_semester_id INT,
    lecturer_id         INT,
    FOREIGN KEY (course_id) REFERENCES course(id),
    FOREIGN KEY (academic_semester_id) REFERENCES academic_semester(id),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(id)
);

-- Course enrollment table
CREATE TABLE course_enrollment (
    course_edition_id   INT,
    student_id          INT,
    midterm_grade       DECIMAL(4,2),
    final_grade         DECIMAL(4,2),
    course_letter_grade CHAR(2),
    passed              BOOLEAN,
    PRIMARY KEY (course_edition_id, student_id),
    FOREIGN KEY (course_edition_id) REFERENCES course_edition(id),
    FOREIGN KEY (student_id)        REFERENCES student(id)
);

-- Exercise 6:
SELECT DISTINCT c.id,
       c.title
FROM course c
JOIN course_edition ce
  ON ce.course_id = c.id
JOIN academic_semester s
  ON s.id = ce.academic_semester_id
WHERE s.term = 'Spring';


-- Exercise 7:
SELECT DISTINCT s.id,
       s.first_name,
       s.last_name
FROM student s
JOIN course_enrollment ce
  ON ce.student_id = s.id
WHERE ce.passed = TRUE;


-- Exercise 8:
WITH lecturer_course_counts AS (
    SELECT l.id,
           l.first_name,
           l.last_name,
           COUNT(DISTINCT ce.course_id) AS no_of_courses
    FROM lecturer l
    LEFT JOIN course_edition ce
      ON ce.lecturer_id = l.id
    GROUP BY l.id, l.first_name, l.last_name
),
min_courses AS (
    SELECT MIN(no_of_courses) AS min_no
    FROM lecturer_course_counts
)
SELECT lcc.first_name,
       lcc.last_name,
       lcc.no_of_courses
FROM lecturer_course_counts lcc
JOIN min_courses m
  ON lcc.no_of_courses = m.min_no;


-- Exercise 9:
WITH student_enroll_counts AS (
    SELECT s.id,
           s.first_name,
           s.last_name,
           COUNT(DISTINCT ce.course_edition_id) AS no_of_course_ed
    FROM student s
    JOIN course_enrollment ce
      ON ce.student_id = s.id
    GROUP BY s.id, s.first_name, s.last_name
),
max_enroll AS (
    SELECT MAX(no_of_course_ed) AS max_no
    FROM student_enroll_counts
)
SELECT sec.id,
       sec.first_name,
       sec.last_name,
       sec.no_of_course_ed
FROM student_enroll_counts sec
JOIN max_enroll m
  ON sec.no_of_course_ed = m.max_no;
