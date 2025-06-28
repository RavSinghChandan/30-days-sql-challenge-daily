-- 1. Pivot sales data by product category and month
SELECT 
    product_category,
    SUM(CASE WHEN MONTH(sale_date) = 1 THEN sale_amount ELSE 0 END) as January,
    SUM(CASE WHEN MONTH(sale_date) = 2 THEN sale_amount ELSE 0 END) as February,
    SUM(CASE WHEN MONTH(sale_date) = 3 THEN sale_amount ELSE 0 END) as March,
    SUM(CASE WHEN MONTH(sale_date) = 4 THEN sale_amount ELSE 0 END) as April,
    SUM(CASE WHEN MONTH(sale_date) = 5 THEN sale_amount ELSE 0 END) as May,
    SUM(CASE WHEN MONTH(sale_date) = 6 THEN sale_amount ELSE 0 END) as June,
    SUM(sale_amount) as Total_Sales
FROM sales
GROUP BY product_category
ORDER BY Total_Sales DESC;

-- 2. Create pivot table for employee count by department and status
SELECT 
    d.department_name,
    SUM(CASE WHEN e.status = 'Active' THEN 1 ELSE 0 END) as Active_Employees,
    SUM(CASE WHEN e.status = 'Inactive' THEN 1 ELSE 0 END) as Inactive_Employees,
    COUNT(e.employee_id) as Total_Employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_name;

-- 3. Pivot project budget by department and status
SELECT 
    d.department_name,
    SUM(CASE WHEN p.status = 'In Progress' THEN p.budget ELSE 0 END) as In_Progress_Budget,
    SUM(CASE WHEN p.status = 'Completed' THEN p.budget ELSE 0 END) as Completed_Budget,
    SUM(CASE WHEN p.status = 'On Hold' THEN p.budget ELSE 0 END) as On_Hold_Budget,
    SUM(p.budget) as Total_Budget,
    ROUND(SUM(p.budget) / SUM(SUM(p.budget)) OVER() * 100, 2) as Budget_Percentage
FROM departments d
LEFT JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_id, d.department_name
ORDER BY Total_Budget DESC;

-- 4. Create pivot table for salary ranges by department
SELECT 
    d.department_name,
    SUM(CASE 
        WHEN e.salary < 65000 THEN 1 
        ELSE 0 
    END) as Low_Salary_Count,
    SUM(CASE 
        WHEN e.salary >= 65000 AND e.salary < 80000 THEN 1 
        ELSE 0 
    END) as Medium_Salary_Count,
    SUM(CASE 
        WHEN e.salary >= 80000 THEN 1 
        ELSE 0 
    END) as High_Salary_Count,
    COUNT(e.employee_id) as Total_Employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_name;

-- 5. Pivot sales performance by employee and quarter
SELECT 
    e.name,
    SUM(CASE WHEN s.quarter = 'Q1 2023' THEN s.sale_amount ELSE 0 END) as Q1_2023_Sales,
    SUM(CASE WHEN s.quarter = 'Q2 2023' THEN s.sale_amount ELSE 0 END) as Q2_2023_Sales,
    SUM(s.sale_amount) as Total_Sales,
    CASE 
        WHEN SUM(CASE WHEN s.quarter = 'Q1 2023' THEN s.sale_amount ELSE 0 END) > 0 
        THEN ROUND(
            (SUM(CASE WHEN s.quarter = 'Q2 2023' THEN s.sale_amount ELSE 0 END) - 
             SUM(CASE WHEN s.quarter = 'Q1 2023' THEN s.sale_amount ELSE 0 END)) / 
            SUM(CASE WHEN s.quarter = 'Q1 2023' THEN s.sale_amount ELSE 0 END) * 100, 2
        )
        ELSE NULL 
    END as QoQ_Growth_Percentage
FROM employees e
LEFT JOIN sales s ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.name
ORDER BY Total_Sales DESC;

-- 6. Create pivot table for project timeline by department
SELECT 
    d.department_name,
    SUM(CASE 
        WHEN p.status = 'Completed' THEN 1 
        ELSE 0 
    END) as Completed_Projects,
    SUM(CASE 
        WHEN p.status = 'In Progress' AND p.end_date >= CURDATE() THEN 1 
        ELSE 0 
    END) as On_Time_Projects,
    SUM(CASE 
        WHEN p.status = 'In Progress' AND p.end_date < CURDATE() THEN 1 
        ELSE 0 
    END) as Overdue_Projects,
    COUNT(p.project_id) as Total_Projects,
    ROUND(
        SUM(CASE WHEN p.status = 'Completed' THEN 1 ELSE 0 END) / 
        COUNT(p.project_id) * 100, 2
    ) as Completion_Rate
FROM departments d
LEFT JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_id, d.department_name
ORDER BY Completion_Rate DESC; 