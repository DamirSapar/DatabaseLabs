--Task 3.1
SELECT
    UPPER(employees.first_name || ' ' || employees.last_name) AS full_name_upper,
    LENGTH(employees.last_name),
    SUBSTRING(employees.email FROM 1 FOR 3)
FROM employees;

--Task 3.2
SELECT
    employees.salary * 12 AS annual_salary,
    ROUND(salary/12.0 , 2) AS monthly_salary,
    employees.salary * 0.10 AS raise_amount
FROM employees;

--Task 3.3
SELECT
    FORMAT('Project: %s - Budget: $%s - Status: %s',projects.project_name, projects.budget, projects.status)
FROM projects;

--Task 3.4
SELECT
    employees.first_name || ' ' || employees.last_name AS full_name,
    DATE_PART('year', AGE(CURRENT_DATE, hire_date)) AS years_with_company
FROM employees;