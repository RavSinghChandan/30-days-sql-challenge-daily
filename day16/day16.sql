-- 1. Employees assigned to at least one project
SELECT 
    e.employee_id,
    e.name,
    e.department_id
FROM employees e
WHERE EXISTS (
    SELECT 1 FROM employee_projects ep 
    WHERE ep.employee_id = e.employee_id
);

-- 2. Employees with no ticket in past month
SELECT 
    e.employee_id,
    e.name,
    e.department_id
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM tickets t 
    WHERE t.employee_id = e.employee_id 
    AND t.created_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
);

-- 3. Customers who have placed orders
SELECT 
    c.customer_id,
    c.customer_name,
    c.email
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o 
    WHERE o.customer_id = c.customer_id
);

-- 4. Departments with no employees
SELECT 
    d.department_id,
    d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e 
    WHERE e.department_id = d.department_id
);

-- 5. Projects with no assigned employees
SELECT 
    p.project_id,
    p.project_name,
    p.status
FROM projects p
WHERE NOT EXISTS (
    SELECT 1 FROM employee_projects ep 
    WHERE ep.project_id = p.project_id
);

-- 6. Employees with salary above department average
SELECT 
    e.employee_id,
    e.name,
    e.salary,
    d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE EXISTS (
    SELECT 1 FROM (
        SELECT department_id, AVG(salary) as avg_salary
        FROM employees
        GROUP BY department_id
    ) dept_avg
    WHERE dept_avg.department_id = e.department_id
    AND e.salary > dept_avg.avg_salary
); 