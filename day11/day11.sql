-- 1. Find 2nd highest salary in each department
WITH RankedSalaries AS (
    SELECT 
        department_id,
        salary,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) as salary_rank
    FROM employees
)
SELECT 
    d.department_name,
    rs.salary as second_highest_salary
FROM RankedSalaries rs
JOIN departments d ON rs.department_id = d.department_id
WHERE rs.salary_rank = 2;

-- 2. Recursive CTE to find reporting hierarchy of an employee
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: start with employee 101 (CEO)
    SELECT 
        employee_id,
        name,
        manager_id,
        0 as level,
        CAST(name AS CHAR(1000)) as hierarchy_path
    FROM employees
    WHERE employee_id = 101
    
    UNION ALL
    
    -- Recursive case: find all direct reports
    SELECT 
        e.employee_id,
        e.name,
        e.manager_id,
        eh.level + 1,
        CONCAT(eh.hierarchy_path, ' -> ', e.name) as hierarchy_path
    FROM employees e
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT 
    level,
    hierarchy_path
FROM EmployeeHierarchy
ORDER BY level, employee_id;

-- 3. Find employees with salary above department average using CTE
WITH DeptAverages AS (
    SELECT 
        department_id,
        AVG(salary) as avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT 
    e.name,
    e.salary,
    d.department_name,
    da.avg_salary,
    e.salary - da.avg_salary as salary_difference
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN DeptAverages da ON e.department_id = da.department_id
WHERE e.salary > da.avg_salary;

-- 4. Calculate running total of salaries by department
WITH SalaryRunningTotal AS (
    SELECT 
        e.employee_id,
        e.name,
        e.salary,
        d.department_name,
        SUM(e.salary) OVER (
            PARTITION BY e.department_id 
            ORDER BY e.salary DESC
            ROWS UNBOUNDED PRECEDING
        ) as running_total
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT 
    name,
    salary,
    department_name,
    running_total
FROM SalaryRunningTotal
ORDER BY department_name, salary DESC;

-- 5. Find top 3 employees by salary in each department
WITH RankedEmployees AS (
    SELECT 
        e.name,
        e.salary,
        d.department_name,
        ROW_NUMBER() OVER (
            PARTITION BY e.department_id 
            ORDER BY e.salary DESC
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
WHERE salary_rank <= 3
ORDER BY department_name, salary_rank;

-- 6. Create a CTE to show employee count and average salary by department
WITH DeptStats AS (
    SELECT 
        department_id,
        COUNT(*) as employee_count,
        AVG(salary) as avg_salary,
        SUM(salary) as total_salary
    FROM employees
    GROUP BY department_id
)
SELECT 
    d.department_name,
    ds.employee_count,
    ROUND(ds.avg_salary, 2) as avg_salary,
    ds.total_salary
FROM DeptStats ds
JOIN departments d ON ds.department_id = d.department_id
ORDER BY ds.avg_salary DESC; 