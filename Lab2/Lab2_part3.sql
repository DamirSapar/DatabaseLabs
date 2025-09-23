/* Part 3
   Task 3.1 */
ALTER TABLE students
    ADD COLUMN middle_name VARCHAR(30),
    ADD COLUMN student_status VARCHAR(20) DEFAULT 'ACTIVE',
    ALTER COLUMN phone SET DATA TYPE VARCHAR(20),
    ALTER COLUMN gpa SET DEFAULT 0.00;

ALTER TABLE professors
    ADD COLUMN department_code CHAR(5),
    ADD COLUMN research_area TEXT,
    ALTER COLUMN years_experience SET DATA TYPE SMALLINT,
    ALTER COLUMN is_tenured SET DEFAULT false,
    ADD COLUMN last_promotion_date DATE;

ALTER TABLE courses
    ADD COLUMN prerequisite_course_id INTEGER,
    ADD COLUMN difficulty_level SMALLINT,
    ALTER COLUMN course_code SET DATA TYPE VARCHAR(10),
    ALTER COLUMN credits SET DEFAULT 3,
    ADD COLUMN lab_required BOOLEAN DEFAULT false;

/* Task 3.2 */
ALTER TABLE class_schedule
    ADD COLUMN room_capacity INTEGER,
    DROP COLUMN IF EXISTS duration,
    ADD COLUMN session_type VARCHAR(15),
    ALTER COLUMN classroom SET DATA TYPE VARCHAR(30),
    ADD COLUMN equipment_needed TEXT;

ALTER TABLE student_records
    ADD COLUMN extra_credit_points NUMERIC(4,1) DEFAULT 0.0,
    ALTER COLUMN grade SET DATA TYPE VARCHAR(5),
    ADD COLUMN final_exam_date DATE,
    DROP COLUMN IF EXISTS last_updated;
