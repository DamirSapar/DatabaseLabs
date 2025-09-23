
\c university_main;

DROP TABLE IF EXISTS student_book_loans CASCADE;
DROP TABLE IF EXISTS library_books CASCADE;
DROP TABLE IF EXISTS grade_scale CASCADE;
DROP TABLE IF EXISTS semester_calendar CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS student_records CASCADE;
DROP TABLE IF EXISTS class_schedule CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS professors CASCADE;
DROP TABLE IF EXISTS students CASCADE;

\c postgres;

DROP DATABASE IF EXISTS university_main;
DROP DATABASE IF EXISTS university_archive;
UPDATE pg_database
SET datistemplate = false
WHERE datname = 'university_test';
DROP DATABASE IF EXISTS university_test;
DROP DATABASE IF EXISTS university_distributed;
DROP DATABASE IF EXISTS university_backup;

DROP TABLESPACE IF EXISTS student_data;
DROP TABLESPACE IF EXISTS course_data;
