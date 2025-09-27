INSERT INTO employees (first_name, last_name, department, salary, hire_date)
SELECT 'Jim', 'Halpert', 'Sales', 55000, CURRENT_DATE
WHERE NOT EXISTS (
    SELECT 1 FROM employees
    WHERE first_name = 'Jim' AND last_name = 'Halpert'
);

UPDATE employees e
SET salary = salary * CASE
    WHEN d.budget > 100000 THEN 1.10
    ELSE 1.05
END
FROM departments d
WHERE e.dept_id = d.dept_id;

INSERT INTO employees (first_name, last_name, department, salary, hire_date)
VALUES
('Pam', 'Beesly', 'Reception', 40000, CURRENT_DATE),
('Dwight', 'Schrute', 'Sales', 60000, CURRENT_DATE),
('Stanley', 'Hudson', 'Sales', 58000, CURRENT_DATE),
('Kevin', 'Malone', 'Accounting', 45000, CURRENT_DATE),
('Angela', 'Martin', 'Accounting', 48000, CURRENT_DATE);
UPDATE employees
SET salary = salary * 1.10
WHERE first_name IN ('Pam', 'Dwight', 'Stanley', 'Kevin', 'Angela');


CREATE TABLE IF NOT EXISTS employee_archive AS
TABLE employees WITH NO DATA;
INSERT INTO employee_archive
SELECT * FROM employees
WHERE status = 'Inactive';
DELETE FROM employees
WHERE status = 'Inactive';

UPDATE projects p
SET end_date = end_date + INTERVAL '30 days'
WHERE p.budget > 50000
  AND (
    SELECT COUNT(*)
    FROM employees e
    WHERE e.dept_id = p.dept_id
  ) > 3;
