--Task 2.1
SELECT * FROM employees
WHERE hire_date > '2020-01-01';

--Task 2.2
SELECT * FROM employees
WHERE salary BETWEEN 60000 AND 70000;

--Task 2.3
SELECT * FROM employees
WHERE last_name LIKE 'S%'
   OR last_name LIKE 'J%';

--Task 2.4
SELECT * FROM employees
WHERE manager_id IS NOT NULL AND department='IT';