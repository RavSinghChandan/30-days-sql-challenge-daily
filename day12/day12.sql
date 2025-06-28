-- 1. Rank employees by salary within department
SELECT 
    name,
    salary,
    department_name,
    RANK() OVER (PARTITION BY e.department_id ORDER BY salary DESC) as salary_rank,
    DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY salary DESC) as dense_rank
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 2. Running total of salaries
SELECT 
    name,
    salary,
    SUM(salary) OVER (ORDER BY salary DESC) as running_total,
    SUM(salary) OVER (ORDER BY salary DESC ROWS UNBOUNDED PRECEDING) as cumulative_total
FROM employees;

-- 3. Difference between max salary and each employee's salary
SELECT 
    name,
    salary,
    department_name,
    MAX(salary) OVER (PARTITION BY e.department_id) as dept_max_salary,
    MAX(salary) OVER (PARTITION BY e.department_id) - salary as salary_gap
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 4. Calculate moving average of sales amounts
SELECT 
    sale_id,
    amount,
    sale_date,
    AVG(amount) OVER (
        ORDER BY sale_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as moving_avg_3_periods,
    AVG(amount) OVER (
        ORDER BY sale_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) as moving_avg_centered
FROM sales
ORDER BY sale_date;

-- 5. Find employees with top 2 salaries in each department
WITH RankedEmployees AS (
    SELECT 
        name,
        salary,
        department_name,
        ROW_NUMBER() OVER (
            PARTITION BY e.department_id 
            ORDER BY salary DESC
        ) as salary_rank
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT 
    department_name,
    name,
    salary,
    salary_rank
FROM RankedEmployees
WHERE salary_rank <= 2
ORDER BY department_name, salary_rank;

-- 6. Calculate cumulative sum of order amounts by region
SELECT 
    order_id,
    total_amount,
    region,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY region 
        ORDER BY order_date 
        ROWS UNBOUNDED PRECEDING
    ) as cumulative_amount,
    SUM(total_amount) OVER (PARTITION BY region) as total_region_amount
FROM orders
ORDER BY region, order_date; 