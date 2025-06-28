-- 1. Rank employees by salary within each department
SELECT 
    e.name,
    e.salary,
    d.department_name,
    ROW_NUMBER() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) as row_num,
    RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) as rank_num,
    DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) as dense_rank_num
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, e.salary DESC;

-- 2. Calculate running total of sales by employee
SELECT 
    e.name,
    s.sale_date,
    s.sale_amount,
    SUM(s.sale_amount) OVER (
        PARTITION BY s.employee_id 
        ORDER BY s.sale_date 
        ROWS UNBOUNDED PRECEDING
    ) as running_total
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
ORDER BY e.name, s.sale_date;

-- 3. Find top 3 highest paid employees in each department
WITH ranked_employees AS (
    SELECT 
        e.name,
        e.salary,
        d.department_name,
        DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) as salary_rank
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT 
    department_name,
    name,
    salary,
    salary_rank
FROM ranked_employees
WHERE salary_rank <= 3
ORDER BY department_name, salary_rank;

-- 4. Calculate salary percentile within each department
SELECT 
    e.name,
    e.salary,
    d.department_name,
    NTILE(4) OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) as salary_quartile
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, salary_quartile, e.salary DESC;

-- 5. Find employees with salary above department average
SELECT 
    e.name,
    e.salary,
    d.department_name,
    AVG(e.salary) OVER (PARTITION BY e.department_id) as dept_avg_salary,
    e.salary - AVG(e.salary) OVER (PARTITION BY e.department_id) as salary_difference
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT AVG(salary) 
    FROM employees 
    WHERE department_id = e.department_id
)
ORDER BY d.department_name, e.salary DESC;

-- 6. Calculate month-over-month sales growth
WITH monthly_sales AS (
    SELECT 
        e.name,
        DATE_FORMAT(s.sale_date, '%Y-%m') as sale_month,
        SUM(s.sale_amount) as monthly_total,
        LAG(SUM(s.sale_amount)) OVER (
            PARTITION BY s.employee_id 
            ORDER BY DATE_FORMAT(s.sale_date, '%Y-%m')
        ) as prev_month_total
    FROM sales s
    JOIN employees e ON s.employee_id = e.employee_id
    GROUP BY e.name, s.employee_id, DATE_FORMAT(s.sale_date, '%Y-%m')
)
SELECT 
    name,
    sale_month,
    monthly_total,
    prev_month_total,
    CASE 
        WHEN prev_month_total IS NULL THEN NULL
        ELSE ROUND(((monthly_total - prev_month_total) / prev_month_total) * 100, 2)
    END as growth_percentage
FROM monthly_sales
ORDER BY name, sale_month; 