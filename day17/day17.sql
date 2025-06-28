-- 1. Create view_active_employees
CREATE VIEW view_active_employees AS
SELECT 
    employee_id,
    name,
    salary,
    department_id,
    hire_date
FROM employees
WHERE status = 'Active';

-- 2. Create view to show department and average salary
CREATE VIEW view_department_salary AS
SELECT 
    d.department_id,
    d.department_name,
    d.location,
    COUNT(e.employee_id) as employee_count,
    AVG(e.salary) as avg_salary,
    SUM(e.salary) as total_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
GROUP BY d.department_id, d.department_name, d.location;

-- 3. Query from both views
SELECT 
    vae.name,
    vae.salary,
    vds.department_name,
    vds.avg_salary,
    vae.salary - vds.avg_salary as salary_difference
FROM view_active_employees vae
JOIN view_department_salary vds ON vae.department_id = vds.department_id
WHERE vae.salary > vds.avg_salary;

-- 4. Create view for project summary
CREATE VIEW view_project_summary AS
SELECT 
    p.project_id,
    p.project_name,
    d.department_name,
    p.start_date,
    p.end_date,
    p.budget,
    p.status,
    COUNT(ep.employee_id) as assigned_employees,
    SUM(ep.hours_worked) as total_hours
FROM projects p
JOIN departments d ON p.department_id = d.department_id
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name, d.department_name, p.start_date, p.end_date, p.budget, p.status;

-- 5. Create view for employee project assignments
CREATE VIEW view_employee_projects AS
SELECT 
    e.employee_id,
    e.name,
    e.department_id,
    p.project_id,
    p.project_name,
    ep.role,
    ep.hours_worked
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE e.status = 'Active';

-- 6. Create view for department statistics
CREATE VIEW view_department_stats AS
SELECT 
    d.department_id,
    d.department_name,
    d.location,
    COUNT(e.employee_id) as total_employees,
    COUNT(CASE WHEN e.status = 'Active' THEN 1 END) as active_employees,
    AVG(e.salary) as avg_salary,
    MIN(e.salary) as min_salary,
    MAX(e.salary) as max_salary,
    COUNT(p.project_id) as total_projects,
    COUNT(CASE WHEN p.status = 'In Progress' THEN 1 END) as active_projects
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_id, d.department_name, d.location; 