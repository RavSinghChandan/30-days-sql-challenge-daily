-- 1. Find duplicate employee records
WITH duplicate_check AS (
    SELECT 
        name,
        email,
        phone,
        COUNT(*) as duplicate_count
    FROM employees
    GROUP BY name, email, phone
    HAVING COUNT(*) > 1
)
SELECT 
    e.employee_id,
    e.name,
    e.email,
    e.phone,
    e.hire_date,
    dc.duplicate_count
FROM employees e
JOIN duplicate_check dc ON e.name = dc.name AND e.email = dc.email AND e.phone = dc.phone
ORDER BY e.name, e.employee_id;

-- Alternative: Find duplicates by individual fields
SELECT 
    'Name Duplicates' as duplicate_type,
    name as duplicate_value,
    COUNT(*) as count
FROM employees
GROUP BY name
HAVING COUNT(*) > 1

UNION ALL

SELECT 
    'Email Duplicates' as duplicate_type,
    email as duplicate_value,
    COUNT(*) as count
FROM employees
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1

UNION ALL

SELECT 
    'Phone Duplicates' as duplicate_type,
    phone as duplicate_value,
    COUNT(*) as count
FROM employees
WHERE phone IS NOT NULL
GROUP BY phone
HAVING COUNT(*) > 1;

-- 2. Identify missing department assignments
SELECT 
    employee_id,
    name,
    email,
    phone,
    hire_date,
    status,
    'Missing Department Assignment' as issue
FROM employees
WHERE department_id IS NULL;

-- 3. Validate salary ranges by department
WITH dept_salary_stats AS (
    SELECT 
        department_id,
        AVG(salary) as avg_salary,
        STDDEV(salary) as salary_stddev
    FROM employees
    WHERE department_id IS NOT NULL AND salary > 0
    GROUP BY department_id
)
SELECT 
    e.employee_id,
    e.name,
    e.salary,
    d.department_name,
    CASE 
        WHEN e.salary <= 0 THEN 'Invalid: Zero or Negative Salary'
        WHEN e.salary < (dss.avg_salary - 2 * dss.salary_stddev) THEN 'Suspicious: Very Low Salary'
        WHEN e.salary > (dss.avg_salary + 2 * dss.salary_stddev) THEN 'Suspicious: Very High Salary'
        ELSE 'Valid Salary'
    END as salary_validation
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN dept_salary_stats dss ON e.department_id = dss.department_id
WHERE e.salary <= 0 
   OR e.salary < (dss.avg_salary - 2 * dss.salary_stddev)
   OR e.salary > (dss.avg_salary + 2 * dss.salary_stddev)
ORDER BY e.salary;

-- 4. Find inconsistent date formats
SELECT 
    employee_id,
    name,
    hire_date,
    CASE 
        WHEN hire_date IS NULL THEN 'Missing Date'
        WHEN hire_date > CURDATE() THEN 'Future Date'
        WHEN YEAR(hire_date) < 1900 OR YEAR(hire_date) > YEAR(CURDATE()) THEN 'Invalid Year'
        ELSE 'Valid Date'
    END as date_validation
FROM employees
WHERE hire_date IS NULL 
   OR hire_date > CURDATE()
   OR YEAR(hire_date) < 1900 
   OR YEAR(hire_date) > YEAR(CURDATE());

-- 5. Check for orphaned records
-- Orphaned employee_projects (employee doesn't exist)
SELECT 
    'Orphaned Employee Project' as issue_type,
    ep.employee_id,
    ep.project_id,
    ep.role,
    'Employee ID ' || ep.employee_id || ' does not exist in employees table' as description
FROM employee_projects ep
LEFT JOIN employees e ON ep.employee_id = e.employee_id
WHERE e.employee_id IS NULL

UNION ALL

-- Orphaned projects (department doesn't exist)
SELECT 
    'Orphaned Project' as issue_type,
    NULL as employee_id,
    p.project_id,
    p.project_name as role,
    'Department ID ' || p.department_id || ' does not exist in departments table' as description
FROM projects p
LEFT JOIN departments d ON p.department_id = d.department_id
WHERE d.department_id IS NULL;

-- 6. Validate foreign key relationships
-- Comprehensive foreign key validation
SELECT 
    'Broken Foreign Key' as validation_type,
    'employees.department_id' as constraint_name,
    e.employee_id,
    e.department_id,
    'Department ID ' || e.department_id || ' does not exist' as issue_description
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IS NOT NULL AND d.department_id IS NULL

UNION ALL

SELECT 
    'Broken Foreign Key' as validation_type,
    'projects.department_id' as constraint_name,
    NULL as employee_id,
    p.department_id,
    'Department ID ' || p.department_id || ' does not exist' as issue_description
FROM projects p
LEFT JOIN departments d ON p.department_id = d.department_id
WHERE p.department_id IS NOT NULL AND d.department_id IS NULL

UNION ALL

SELECT 
    'Broken Foreign Key' as validation_type,
    'employee_projects.employee_id' as constraint_name,
    ep.employee_id,
    NULL as department_id,
    'Employee ID ' || ep.employee_id || ' does not exist' as issue_description
FROM employee_projects ep
LEFT JOIN employees e ON ep.employee_id = e.employee_id
WHERE e.employee_id IS NULL

UNION ALL

SELECT 
    'Broken Foreign Key' as validation_type,
    'employee_projects.project_id' as constraint_name,
    NULL as employee_id,
    ep.project_id,
    'Project ID ' || ep.project_id || ' does not exist' as issue_description
FROM employee_projects ep
LEFT JOIN projects p ON ep.project_id = p.project_id
WHERE p.project_id IS NULL; 