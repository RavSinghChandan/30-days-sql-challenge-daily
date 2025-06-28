-- 1. Use CROSS JOIN to generate combinations
-- Generate all possible employee-skill combinations
SELECT 
    e.employee_id,
    e.name,
    s.skill_id,
    s.skill_name,
    CASE 
        WHEN es.proficiency_level IS NOT NULL THEN 'Assigned'
        ELSE 'Not Assigned'
    END as assignment_status
FROM employees e
CROSS JOIN skills s
LEFT JOIN employee_skills es ON e.employee_id = es.employee_id AND s.skill_id = es.skill_id
WHERE e.status = 'Active'
ORDER BY e.name, s.skill_name;

-- Show missing skill assignments
SELECT 
    e.name,
    s.skill_name,
    'Missing Skill Assignment' as issue
FROM employees e
CROSS JOIN skills s
LEFT JOIN employee_skills es ON e.employee_id = es.employee_id AND s.skill_id = es.skill_id
WHERE e.status = 'Active' AND es.employee_id IS NULL
ORDER BY e.name, s.skill_name;

-- 2. Implement self-joins for hierarchical data
-- Show employee-manager relationships
SELECT 
    e.employee_id,
    e.name as employee_name,
    e.department_id,
    m.name as manager_name,
    m.employee_id as manager_id
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
WHERE e.status = 'Active'
ORDER BY e.manager_id, e.name;

-- Display organizational hierarchy levels
WITH RECURSIVE hierarchy AS (
    -- Base case: top-level employees (no manager)
    SELECT 
        employee_id,
        name,
        manager_id,
        1 as level,
        CAST(name AS CHAR(1000)) as hierarchy_path
    FROM employees
    WHERE manager_id IS NULL AND status = 'Active'
    
    UNION ALL
    
    -- Recursive case: employees with managers
    SELECT 
        e.employee_id,
        e.name,
        e.manager_id,
        h.level + 1,
        CONCAT(h.hierarchy_path, ' -> ', e.name)
    FROM employees e
    JOIN hierarchy h ON e.manager_id = h.employee_id
    WHERE e.status = 'Active'
)
SELECT 
    employee_id,
    name,
    level,
    hierarchy_path
FROM hierarchy
ORDER BY level, name;

-- 3. Use multiple joins with complex conditions
-- Join employees, departments, projects, and skills
SELECT 
    e.name as employee_name,
    d.department_name,
    p.project_name,
    s.skill_name,
    es.proficiency_level,
    ep.role,
    ep.hours_worked
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
LEFT JOIN projects p ON ep.project_id = p.project_id
LEFT JOIN employee_skills es ON e.employee_id = es.employee_id
LEFT JOIN skills s ON es.skill_id = s.skill_id
WHERE e.status = 'Active'
  AND (p.status = 'In Progress' OR p.status IS NULL)
  AND (es.proficiency_level >= 4 OR es.proficiency_level IS NULL)
ORDER BY e.name, p.project_name, s.skill_name;

-- 4. Implement anti-joins to find missing data
-- Find employees without project assignments
SELECT 
    e.employee_id,
    e.name,
    d.department_name,
    'No Project Assignment' as issue
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.status = 'Active'
  AND NOT EXISTS (
      SELECT 1 FROM employee_projects ep 
      WHERE ep.employee_id = e.employee_id
  );

-- Identify departments without employees
SELECT 
    d.department_id,
    d.department_name,
    d.location,
    'No Employees' as issue
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e 
    WHERE e.department_id = d.department_id AND e.status = 'Active'
);

-- 5. Use lateral joins for correlated subqueries
-- Find top skills for each employee (using subquery as lateral join approximation)
SELECT 
    e.name,
    e.department_id,
    (
        SELECT s.skill_name
        FROM employee_skills es
        JOIN skills s ON es.skill_id = s.skill_id
        WHERE es.employee_id = e.employee_id
        ORDER BY es.proficiency_level DESC
        LIMIT 1
    ) as top_skill,
    (
        SELECT es.proficiency_level
        FROM employee_skills es
        WHERE es.employee_id = e.employee_id
        ORDER BY es.proficiency_level DESC
        LIMIT 1
    ) as top_skill_level
FROM employees e
WHERE e.status = 'Active'
ORDER BY e.name;

-- Get department statistics with employee details
SELECT 
    d.department_name,
    d.location,
    COUNT(e.employee_id) as employee_count,
    AVG(e.salary) as avg_salary,
    (
        SELECT e2.name
        FROM employees e2
        WHERE e2.department_id = d.department_id
        ORDER BY e2.salary DESC
        LIMIT 1
    ) as highest_paid_employee
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
GROUP BY d.department_id, d.department_name, d.location
ORDER BY avg_salary DESC;

-- 6. Implement full outer joins for data comparison
-- Compare employee skills across departments (using UNION to simulate FULL OUTER JOIN)
SELECT 
    e.name as employee_name,
    d.department_name,
    s.skill_name,
    es.proficiency_level
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employee_skills es ON e.employee_id = es.employee_id
LEFT JOIN skills s ON es.skill_id = s.skill_id
WHERE e.status = 'Active'

UNION

SELECT 
    e.name as employee_name,
    d.department_name,
    s.skill_name,
    NULL as proficiency_level
FROM employees e
JOIN departments d ON e.department_id = d.department_id
CROSS JOIN skills s
WHERE e.status = 'Active'
  AND NOT EXISTS (
      SELECT 1 FROM employee_skills es 
      WHERE es.employee_id = e.employee_id AND es.skill_id = s.skill_id
  )
ORDER BY employee_name, skill_name;

-- Show all combinations of employees and projects
SELECT 
    e.name as employee_name,
    d.department_name,
    p.project_name,
    p.status as project_status,
    ep.role,
    ep.hours_worked
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
LEFT JOIN projects p ON ep.project_id = p.project_id
WHERE e.status = 'Active'
ORDER BY e.name, p.project_name; 