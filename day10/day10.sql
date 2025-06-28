-- 1. Grade employees (A/B/C) by salary slabs
SELECT 
    name,
    salary,
    CASE 
        WHEN salary >= 70000 THEN 'A'
        WHEN salary >= 50000 THEN 'B'
        ELSE 'C'
    END as grade
FROM employees;

-- 2. Mark employees as 'New Joiner' if joined in last 90 days else 'Tenured'
SELECT 
    name,
    hire_date,
    CASE 
        WHEN hire_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY) THEN 'New Joiner'
        ELSE 'Tenured'
    END as employee_status
FROM employees;

-- 3. Categorize sales performance based on amount
SELECT 
    s.sale_id,
    e.name,
    s.amount,
    CASE 
        WHEN s.amount >= 20000 THEN 'Excellent'
        WHEN s.amount >= 15000 THEN 'Good'
        WHEN s.amount >= 10000 THEN 'Average'
        ELSE 'Below Average'
    END as performance_category
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id;

-- 4. Assign project priority levels using CASE
SELECT 
    project_name,
    status,
    CASE priority
        WHEN 'High' THEN 'Urgent - Immediate attention required'
        WHEN 'Medium' THEN 'Important - Plan accordingly'
        WHEN 'Low' THEN 'Normal - Handle when possible'
        ELSE 'Undefined'
    END as priority_description
FROM projects;

-- 5. Calculate bonus based on performance rating and tenure
SELECT 
    name,
    salary,
    performance_rating,
    DATEDIFF(CURDATE(), hire_date) as days_employed,
    CASE 
        WHEN performance_rating >= 4.5 AND DATEDIFF(CURDATE(), hire_date) > 365 THEN salary * 0.15
        WHEN performance_rating >= 4.0 AND DATEDIFF(CURDATE(), hire_date) > 365 THEN salary * 0.10
        WHEN performance_rating >= 3.5 THEN salary * 0.05
        ELSE 0
    END as bonus_amount
FROM employees;

-- 6. Categorize employees by department and salary range
SELECT 
    d.department_name,
    e.name,
    e.salary,
    CASE 
        WHEN e.salary >= 70000 THEN 'High Earner'
        WHEN e.salary >= 50000 THEN 'Mid Level'
        WHEN e.salary >= 35000 THEN 'Entry Level'
        ELSE 'Junior'
    END as salary_category
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, e.salary DESC; 