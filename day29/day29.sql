-- 1. Top 5 recent high-paying job switchers
SELECT 
    e.name,
    e.salary,
    e.hire_date,
    d.department_name,
    ROW_NUMBER() OVER (ORDER BY e.salary DESC, e.hire_date DESC) as rank_by_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.hire_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
ORDER BY e.salary DESC, e.hire_date DESC
LIMIT 5;

-- 2. Employees never assigned to any project
SELECT 
    e.employee_id,
    e.name,
    e.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE NOT EXISTS (
    SELECT 1 FROM employee_projects ep 
    WHERE ep.employee_id = e.employee_id
);

-- 3. Salary > department average
SELECT 
    e.name,
    e.salary,
    d.department_name,
    dept_avg.avg_salary,
    e.salary - dept_avg.avg_salary as salary_difference
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN (
    SELECT 
        department_id,
        AVG(salary) as avg_salary
    FROM employees
    GROUP BY department_id
) dept_avg ON e.department_id = dept_avg.department_id
WHERE e.salary > dept_avg.avg_salary
ORDER BY salary_difference DESC;

-- 4. Repeated phone/email addresses
SELECT 
    phone,
    COUNT(*) as phone_count,
    GROUP_CONCAT(name) as employees_with_phone
FROM employees
GROUP BY phone
HAVING COUNT(*) > 1

UNION ALL

SELECT 
    email,
    COUNT(*) as email_count,
    GROUP_CONCAT(name) as employees_with_email
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;

-- 5. Customers with most orders in past 60 days
SELECT 
    c.customer_name,
    c.email,
    COUNT(o.order_id) as order_count,
    SUM(o.total_amount) as total_spent,
    AVG(o.total_amount) as avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 60 DAY)
GROUP BY c.customer_id, c.customer_name, c.email
ORDER BY order_count DESC, total_spent DESC;

-- 6. Employees with salary above company average but below department maximum
WITH CompanyStats AS (
    SELECT 
        AVG(salary) as company_avg_salary
    FROM employees
),
DeptStats AS (
    SELECT 
        department_id,
        MAX(salary) as dept_max_salary
    FROM employees
    GROUP BY department_id
)
SELECT 
    e.name,
    e.salary,
    d.department_name,
    cs.company_avg_salary,
    ds.dept_max_salary,
    e.salary - cs.company_avg_salary as above_company_avg,
    ds.dept_max_salary - e.salary as below_dept_max
FROM employees e
JOIN departments d ON e.department_id = d.department_id
CROSS JOIN CompanyStats cs
JOIN DeptStats ds ON e.department_id = ds.department_id
WHERE e.salary > cs.company_avg_salary 
    AND e.salary < ds.dept_max_salary
ORDER BY e.salary DESC; 