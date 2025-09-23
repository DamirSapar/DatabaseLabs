/* Part 5
   Task 5.1 */
DROP TABLE IF EXISTS student_book_loans CASCADE;
DROP TABLE IF EXISTS library_books CASCADE;
DROP TABLE IF EXISTS grade_scale CASCADE;

CREATE TABLE grade_scale (
    grade_id SERIAL PRIMARY KEY,
    letter_grade CHAR(2),
    min_percentage NUMERIC(4,1),
    max_percentage NUMERIC(4,1),
    gpa_points NUMERIC(3,2),
    description TEXT
);


DROP TABLE IF EXISTS semester_calendar CASCADE;

CREATE TABLE semester_calendar (
    semester_id SERIAL PRIMARY KEY,
    semester_name VARCHAR(20),
    academic_year INTEGER,
    start_date DATE,
    end_date DATE,
    registration_deadline TIMESTAMP WITH TIME ZONE,
    is_current BOOLEAN
);


/* Task 5.2 */
-- Чтобы удалить шаблонную базу university_test, сначала снимаем флаг template
UPDATE pg_database
SET datistemplate = false
WHERE datname = 'university_test';

DROP DATABASE IF EXISTS university_test;
DROP DATABASE IF EXISTS university_distributed;

DROP DATABASE IF EXISTS university_backup;
CREATE DATABASE university_backup TEMPLATE university_main;
