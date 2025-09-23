/* Part 1
   Task 1.1 */
CREATE DATABASE university_main
    OWNER = postgres
    TEMPLATE template0
    ENCODING 'UTF8';

CREATE DATABASE university_archive
    CONNECTION LIMIT 50
    TEMPLATE template0;

CREATE DATABASE university_test
    IS_TEMPLATE true
    CONNECTION LIMIT 10;

/* Task 1.2 */
CREATE TABLESPACE student_data
    LOCATION '/Users/damirsapar/pg_tablespaces/students';

CREATE TABLESPACE course_data
    OWNER postgres
    LOCATION '/Users/damirsapar/pg_tablespaces/courses';

CREATE DATABASE university_distributed
    TABLESPACE student_data
    ENCODING 'LATIN9'
    TEMPLATE template0
    LC_COLLATE 'C'
    LC_CTYPE 'C';

