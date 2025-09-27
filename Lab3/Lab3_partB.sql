INSERT INTO employees ( first_name, last_name, department)
VALUES ('John', 'Doe', 'IT');

INSERT INTO employees (first_name, last_name, department, salary, hire_date)
VALUES ('Emily', 'Clark', 'Finance', DEFAULT, '2023-02-01');

INSERT INTO employees(department)
VALUES ('Finance'),
('Marketing'),
('IT');

INSERT INTO employees (first_name, last_name, department, salary, hire_date)
VALUES ('Alice', 'Johnson', 'HR', 50000 * 1.1, CURRENT_DATE);

CREATE TEMP TABLE temp_employees AS
SELECT * FROM employees WHERE 1=0;

INSERT INTO temp_employees
SELECT * FROM employees WHERE department= 'IT';