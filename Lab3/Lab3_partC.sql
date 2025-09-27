UPDATE employees
SET salary=salary*1.1;

UPDATE employees
SET status='Senior'
WHERE salary>60000 AND hire_date<'2020-01-01';

UPDATE employees
SET department = CASE
    WHEN salary > 80000 THEN 'Management'
    WHEN salary BETWEEN 50000 AND 80000 THEN 'Senior'
    ELSE 'Junior'
END;

UPDATE employees
SET department = DEFAULT
WHERE status = 'Inactive';

UPDATE departments d
SET budget = sub.avg_salary * 1.2
FROM (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
) AS sub
WHERE d.dept_name = sub.department;

UPDATE employees
SET salary = salary*1.15,
    status = 'Promoted'
WHERE department='Sales';
