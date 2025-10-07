--Task 7.1
SELECT e.first_name || ' ' || e.last_name AS full_name,
       e.department,
       AVG(a.hours_worked) AS avg_hours,
       RANK() OVER (PARTITION BY e.department ORDER BY e.salary DESC) AS salary_rank
FROM employees e
LEFT JOIN assignments a ON e.employee_id = a.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.department, e.salary;

--Task 7.2
SELECT p.project_name,
       SUM(a.hours_worked) AS total_hours,
       COUNT(DISTINCT a.employee_id) AS num_employees
FROM projects p
JOIN assignments a ON p.project_id = a.project_id
GROUP BY p.project_name
HAVING SUM(a.hours_worked) > 150;

--Task 7.3
SELECT e.department,
       COUNT(*) AS total_employees,
       AVG(e.salary) AS avg_salary,
       MAX(e.salary) AS max_salary,
       MIN(e.salary) AS min_salary,
       GREATEST(MAX(e.salary), AVG(e.salary)) AS highest_vs_avg,
       LEAST(MIN(e.salary), AVG(e.salary)) AS lowest_vs_avg,
       (SELECT first_name || ' ' || last_name
        FROM employees e2
        WHERE e2.department = e.department
        ORDER BY e2.salary DESC
        LIMIT 1) AS highest_paid_employee
FROM employees e
GROUP BY e.department;
