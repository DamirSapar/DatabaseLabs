--Task 6.1
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS full_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM assignments a
    WHERE a.employee_id = e.employee_id
);

--Task 6.2
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS full_name
FROM employees e
WHERE e.employee_id IN (
    SELECT a.employee_id
    FROM assignments a
    JOIN projects p ON a.project_id = p.project_id
    WHERE p.status = 'Active'
);

--Task 6.3
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS full_name, e.salary
FROM employees e
WHERE e.salary > ANY (
    SELECT salary
    FROM employees
    WHERE department = 'Sales'
);
