DELETE FROM employees WHERE status='Terminated';

DELETE FROM employees
WHERE salary<40000 AND hire_date>'2023-01-01' AND department IS NULL;

ALTER TABLE employees
ADD COLUMN dept_id INTEGER REFERENCES departments(dept_id);

DELETE FROM departments
WHERE dept_id NOT IN (
    SELECT DISTINCT dept_id
    FROM employees
    WHERE dept_id IS NOT NULL
);


DELETE FROM projects
WHERE end_date<'2023-01-01'
RETURNING *;