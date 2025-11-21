/* ===========================
   DATASET: ORCHESTRAS
   Tables: orchestras, concerts, members
   =========================== */


/* Exercise 1:
   Select the names of all orchestras that have the same city of origin
   as any city in which any orchestra performed in 2013.
   Columns: name
*/

SELECT DISTINCT
    o.name
FROM orchestras o
WHERE o.city_origin IN (
    SELECT DISTINCT c.city
    FROM concerts c
    WHERE c.year = 2013
);



/* Exercise 2:
   Select the names and positions of all orchestra members that:
   - have experience > 10 years
   - do NOT belong to orchestras with rating below 8.0
   So: orchestra.rating >= 8.0
   Columns: name, position
*/

SELECT
    m.name,
    m.position
FROM members m
JOIN orchestras o
    ON m.orchestra_id = o.id
WHERE m.experience > 10
  AND o.rating >= 8.0;



/* Exercise 3:
   Show the name and position of orchestra members who earn more than
   the average wage of all violinists.
   Columns: name, position
   (Assume violinists have position like 'Violinist')
*/

SELECT
    m.name,
    m.position
FROM members m
WHERE m.wage > (
    SELECT AVG(v.wage)
    FROM members v
    WHERE LOWER(v.position) = 'violinist'
);



/* Exercise 4:
   Show the names of orchestras that were created after the
   'Chamber Orchestra' and have rating > 7.5.
   Assume orchestras.year is founding year.
   Columns: name
*/

SELECT
    o.name
FROM orchestras o
WHERE o.year > (
    SELECT o2.year
    FROM orchestras o2
    WHERE o2.name = 'Chamber Orchestra'
)
AND o.rating > 7.5;



/* Exercise 5:
   Show the name and number of members for each orchestra that has
   more members than the average membership across all orchestras.
   Columns: name, members_number
*/

SELECT
    o.name,
    COUNT(m.id) AS members_number
FROM orchestras o
LEFT JOIN members m
    ON m.orchestra_id = o.id
GROUP BY o.id, o.name
HAVING COUNT(m.id) > (
    SELECT AVG(member_count)
    FROM (
        SELECT
            o2.id,
            COUNT(m2.id) AS member_count
        FROM orchestras o2
        LEFT JOIN members m2
            ON m2.orchestra_id = o2.id
        GROUP BY o2.id
    ) AS x
);



/* ===========================
   DATASET: UNIVERSITY
   Tables: course, lecturer, student,
           academic_semester, course_edition, course_enrollment
   =========================== */


/* Exercise 6:
   Display the IDs and titles of all courses that took place
   during any spring term.
   Columns: id, title
   Assume academic_semester.term = 'Spring'
*/

SELECT DISTINCT
    c.id,
    c.title
FROM course c
JOIN course_edition ce
    ON ce.course_id = c.id
JOIN academic_semester s
    ON s.id = ce.academic_semester_id
WHERE s.term = 'Spring';



/* Exercise 7:
   Select the IDs and names of students who passed at least one course.
   Columns: id, first_name, last_name
   Assume passed is a boolean or 1/0; using = TRUE here.
*/

SELECT DISTINCT
    st.id,
    st.first_name,
    st.last_name
FROM student st
JOIN course_enrollment e
    ON e.student_id = st.id
WHERE e.passed = TRUE;      -- or: e.passed = 1



/* Exercise 8:
   Find the lecturer(s) with the least number of courses taught.
   Show: first_name, last_name, no_of_courses
   (Counting how many course_edition rows per lecturer)
*/

WITH lect_counts AS (
    SELECT
        l.id,
        l.first_name,
        l.last_name,
        COUNT(ce.id) AS no_of_courses
    FROM lecturer l
    LEFT JOIN course_edition ce
        ON ce.lecturer_id = l.id
    GROUP BY l.id, l.first_name, l.last_name
)
SELECT
    first_name,
    last_name,
    no_of_courses
FROM lect_counts
WHERE no_of_courses = (
    SELECT MIN(no_of_courses) FROM lect_counts
);



/* Exercise 9:
   Find the student(s) enrolled in the greatest number of course editions.
   Show: id, first_name, last_name, no_of_course_ed
*/

WITH stud_counts AS (
    SELECT
        st.id,
        st.first_name,
        st.last_name,
        COUNT(e.course_edition_id) AS no_of_course_ed
    FROM student st
    LEFT JOIN course_enrollment e
        ON e.student_id = st.id
    GROUP BY st.id, st.first_name, st.last_name
)
SELECT
    id,
    first_name,
    last_name,
    no_of_course_ed
FROM stud_counts
WHERE no_of_course_ed = (
    SELECT MAX(no_of_course_ed) FROM stud_counts
);
