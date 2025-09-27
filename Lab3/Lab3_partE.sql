INSERT INTO employees (first_name, last_name, salary, department, hire_date)
VALUES ('Null', 'Tester', NULL, NULL, CURRENT_DATE);

UPDATE employees
SET department = 'Unassigned'
WHERE department IS NULL;

DELETE FROM employees
WHERE salary IS NULL
   OR department IS NULL;
