--Task 1.1
SELECT employees.department, employees.salary, employees.first_name ||' '|| employees.last_name AS full_name
FROM employees;

--Task 1.2
SELECT DISTINCT employees.department FROM employees;

--Task 1.3
SELECT projects.project_name, projects.budget FROM projects;
ALTER TABLE projects
ADD COLUMN budget_category VARCHAR(50);
UPDATE projects
SET budget_category = CASE
    WHEN budget > 150000 THEN 'Large'
    WHEN budget BETWEEN 100000 AND 150000 THEN 'Medium'
    ELSE 'Small'
END;

--Task 1.4
SELECT first_name || ' ' || last_name AS full_name,
       COALESCE(email, 'No Email provided')
FROM employees;

