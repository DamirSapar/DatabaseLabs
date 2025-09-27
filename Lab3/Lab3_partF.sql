INSERT INTO employees (first_name, last_name, department, salary, hire_date)
VALUES ('Michael', 'Scott', 'Sales', 60000, CURRENT_DATE)
RETURNING emp_id, first_name || ' ' || last_name AS full_name;

UPDATE employees
SET salary=salary+5000
WHERE department='IT'
RETURNING emp_id, salary-5000 AS old_salary, salary AS new_salary;

DELETE FROM employees
WHERE hire_date<'2020-01-01'
RETURNING *;
