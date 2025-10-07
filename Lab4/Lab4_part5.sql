--Task 5.1
SELECT employee_id,employees.first_name || ' ' || employees.last_name AS full_name, employees.salary
FROM employees
WHERE salary > 65000

UNION

SELECT employee_id,employees.first_name || ' ' || employees.last_name AS full_name, employees.salary
FROM employees
WHERE hire_date > '2020-01-01';

--Task 5.2
SELECT employee_id, first_name || ' ' || last_name AS full_name, salary
FROM employees
WHERE department = 'IT'

INTERSECT

SELECT employee_id, first_name || ' ' || last_name AS full_name, salary
FROM employees
WHERE salary > 65000;

--Task 5.3
SELECT employee_id
FROM employees

EXCEPT

SELECT employee_id
FROM assignments;
