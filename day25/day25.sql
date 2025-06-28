-- 1. Analyze query execution plans
-- Slow query to analyze
EXPLAIN SELECT 
    e.name,
    d.department_name,
    COUNT(ep.project_id) as project_count
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE e.status = 'Active'
GROUP BY e.employee_id, e.name, d.department_name
ORDER BY project_count DESC;

-- 2. Optimize slow-running queries
-- Original inefficient query (subquery)
SELECT 
    e.name,
    e.salary,
    (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id) as dept_avg
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

-- Optimized version using JOIN
SELECT 
    e.name,
    e.salary,
    dept_stats.avg_salary as dept_avg
FROM employees e
JOIN (
    SELECT department_id, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department_id
) dept_stats ON e.department_id = dept_stats.department_id
WHERE e.salary > dept_stats.avg_salary;

-- 3. Create appropriate indexes
-- Index for frequently queried columns
CREATE INDEX idx_employees_status ON employees(status);
CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_employees_hire_date ON employees(hire_date);

-- Composite index for complex queries
CREATE INDEX idx_employees_dept_status ON employees(department_id, status);
CREATE INDEX idx_employee_projects_emp ON employee_projects(employee_id);
CREATE INDEX idx_sales_employee_date ON sales(employee_id, sale_date);

-- 4. Use query hints for optimization
-- Force index usage
SELECT 
    e.name,
    e.salary
FROM employees e FORCE INDEX (idx_employees_dept_status)
WHERE e.department_id = 1 AND e.status = 'Active';

-- Use specific join order
SELECT STRAIGHT_JOIN
    e.name,
    d.department_name,
    COUNT(ep.project_id) as project_count
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE e.status = 'Active'
GROUP BY e.employee_id, e.name, d.department_name;

-- 5. Optimize joins and subqueries
-- Convert IN subquery to EXISTS
-- Original (inefficient for large datasets)
SELECT 
    e.name,
    e.department_id
FROM employees e
WHERE e.employee_id IN (
    SELECT DISTINCT employee_id 
    FROM employee_projects
);

-- Optimized with EXISTS
SELECT 
    e.name,
    e.department_id
FROM employees e
WHERE EXISTS (
    SELECT 1 
    FROM employee_projects ep 
    WHERE ep.employee_id = e.employee_id
);

-- Convert correlated subquery to JOIN
-- Original (correlated subquery)
SELECT 
    e.name,
    e.salary,
    (SELECT COUNT(*) FROM employee_projects ep WHERE ep.employee_id = e.employee_id) as project_count
FROM employees e;

-- Optimized with LEFT JOIN
SELECT 
    e.name,
    e.salary,
    COUNT(ep.project_id) as project_count
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
GROUP BY e.employee_id, e.name, e.salary;

-- 6. Implement query result caching
-- Create materialized view (using regular view as approximation)
CREATE VIEW employee_project_summary AS
SELECT 
    e.employee_id,
    e.name,
    e.department_id,
    d.department_name,
    COUNT(ep.project_id) as total_projects,
    SUM(ep.hours_worked) as total_hours,
    AVG(e.salary) as avg_dept_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE e.status = 'Active'
GROUP BY e.employee_id, e.name, e.department_id, d.department_name;

-- Query from cached view
SELECT 
    name,
    department_name,
    total_projects,
    total_hours
FROM employee_project_summary
WHERE total_projects > 0
ORDER BY total_hours DESC;

-- Performance monitoring queries
-- Check index usage
SHOW INDEX FROM employees;
SHOW INDEX FROM employee_projects;

-- Analyze table statistics
ANALYZE TABLE employees;
ANALYZE TABLE employee_projects;
ANALYZE TABLE departments; 