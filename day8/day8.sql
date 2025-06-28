-- 1. Employees earning above overall average salary
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Employees who joined before their department head
SELECT e.name, e.hire_date, d.department_name, h.hire_date as head_hire_date
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN employees h ON d.head_employee_id = h.employee_id
WHERE e.hire_date < h.hire_date;

-- 3. Departments where no one earns below 40k
SELECT d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e 
    WHERE e.department_id = d.department_id 
    AND e.salary < 40000
);

-- 4. Find employees with salary higher than the average salary in their department
SELECT e.name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT AVG(salary) 
    FROM employees 
    WHERE department_id = e.department_id
);

-- 5. Find departments that have more employees than the average department
SELECT d.department_name, COUNT(e.employee_id) as employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) > (
    SELECT AVG(emp_count) 
    FROM (
        SELECT COUNT(employee_id) as emp_count
        FROM employees 
        GROUP BY department_id
    ) as dept_counts
);

-- 6. Find employees who earn more than the highest salary in Marketing department
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT MAX(salary) 
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = 'Marketing'
); 