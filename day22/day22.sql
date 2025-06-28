-- 1. Create a CTE to find employees with salary above department average
WITH dept_avg_salary AS (
    SELECT 
        department_id,
        AVG(salary) as avg_salary
    FROM employees
    WHERE status = 'Active'
    GROUP BY department_id
)
SELECT 
    e.name,
    e.salary,
    d.department_name,
    das.avg_salary,
    e.salary - das.avg_salary as salary_difference
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN dept_avg_salary das ON e.department_id = das.department_id
WHERE e.salary > das.avg_salary
ORDER BY d.department_name, e.salary DESC;

-- 2. Use CTE to calculate department budget utilization
WITH dept_budget AS (
    SELECT 
        d.department_id,
        d.department_name,
        SUM(p.budget) as total_budget,
        COUNT(p.project_id) as project_count
    FROM departments d
    LEFT JOIN projects p ON d.department_id = p.department_id
    GROUP BY d.department_id, d.department_name
)
SELECT 
    department_name,
    total_budget,
    project_count,
    CASE 
        WHEN total_budget > 0 THEN 'High Budget'
        WHEN total_budget > 0 THEN 'Medium Budget'
        ELSE 'Low Budget'
    END as budget_category
FROM dept_budget
ORDER BY total_budget DESC;

-- 3. Create recursive CTE to find employee hierarchy
WITH RECURSIVE employee_tree AS (
    -- Base case: top-level employees (no manager)
    SELECT 
        employee_id,
        name,
        manager_id,
        level,
        CAST(name AS CHAR(1000)) as hierarchy_path
    FROM employee_hierarchy
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: employees with managers
    SELECT 
        eh.employee_id,
        eh.name,
        eh.manager_id,
        eh.level,
        CONCAT(et.hierarchy_path, ' -> ', eh.name) as hierarchy_path
    FROM employee_hierarchy eh
    JOIN employee_tree et ON eh.manager_id = et.employee_id
)
SELECT 
    employee_id,
    name,
    level,
    hierarchy_path
FROM employee_tree
ORDER BY level, name;

-- 4. Use CTE to find employees working on multiple projects
WITH employee_project_count AS (
    SELECT 
        e.employee_id,
        e.name,
        e.department_id,
        COUNT(ep.project_id) as project_count
    FROM employees e
    LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
    WHERE e.status = 'Active'
    GROUP BY e.employee_id, e.name, e.department_id
)
SELECT 
    epc.name,
    d.department_name,
    epc.project_count
FROM employee_project_count epc
JOIN departments d ON epc.department_id = d.department_id
WHERE epc.project_count > 1
ORDER BY epc.project_count DESC, epc.name;

-- 5. Create CTE to calculate cumulative salary by department
WITH cumulative_salary AS (
    SELECT 
        e.employee_id,
        e.name,
        e.salary,
        e.department_id,
        e.hire_date,
        SUM(e.salary) OVER (
            PARTITION BY e.department_id 
            ORDER BY e.hire_date 
            ROWS UNBOUNDED PRECEDING
        ) as cumulative_salary
    FROM employees e
    WHERE e.status = 'Active'
)
SELECT 
    cs.name,
    cs.salary,
    d.department_name,
    cs.hire_date,
    cs.cumulative_salary
FROM cumulative_salary cs
JOIN departments d ON cs.department_id = d.department_id
ORDER BY d.department_name, cs.hire_date;

-- 6. Use CTE to find departments with highest average salary
WITH dept_salary_stats AS (
    SELECT 
        d.department_id,
        d.department_name,
        COUNT(e.employee_id) as employee_count,
        AVG(e.salary) as avg_salary,
        SUM(e.salary) as total_salary
    FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
    GROUP BY d.department_id, d.department_name
)
SELECT 
    department_name,
    employee_count,
    ROUND(avg_salary, 2) as avg_salary,
    total_salary,
    RANK() OVER (ORDER BY avg_salary DESC) as salary_rank
FROM dept_salary_stats
WHERE avg_salary IS NOT NULL
ORDER BY avg_salary DESC; 