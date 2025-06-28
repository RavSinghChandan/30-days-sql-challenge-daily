-- 1. Stored procedure to get employees by department
DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN dept_id INT)
BEGIN
    SELECT 
        e.employee_id,
        e.name,
        e.salary,
        e.hire_date,
        e.status,
        d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE e.department_id = dept_id
    ORDER BY e.name;
END //
DELIMITER ;

-- 2. Stored procedure to calculate department salary statistics
DELIMITER //
CREATE PROCEDURE GetDepartmentSalaryStats(IN dept_id INT)
BEGIN
    SELECT 
        d.department_name,
        COUNT(e.employee_id) as employee_count,
        AVG(e.salary) as avg_salary,
        MIN(e.salary) as min_salary,
        MAX(e.salary) as max_salary,
        SUM(e.salary) as total_salary
    FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
    WHERE d.department_id = dept_id
    GROUP BY d.department_id, d.department_name;
END //
DELIMITER ;

-- 3. Stored procedure to assign employee to project
DELIMITER //
CREATE PROCEDURE AssignEmployeeToProject(
    IN emp_id INT, 
    IN proj_id INT, 
    IN emp_role VARCHAR(50), 
    IN hours INT
)
BEGIN
    DECLARE emp_exists INT;
    DECLARE proj_exists INT;
    DECLARE already_assigned INT;
    
    -- Check if employee exists
    SELECT COUNT(*) INTO emp_exists FROM employees WHERE employee_id = emp_id AND status = 'Active';
    
    -- Check if project exists
    SELECT COUNT(*) INTO proj_exists FROM projects WHERE project_id = proj_id;
    
    -- Check if already assigned
    SELECT COUNT(*) INTO already_assigned FROM employee_projects WHERE employee_id = emp_id AND project_id = proj_id;
    
    IF emp_exists = 0 THEN
        SELECT 'Error: Employee not found or inactive' as message;
    ELSEIF proj_exists = 0 THEN
        SELECT 'Error: Project not found' as message;
    ELSEIF already_assigned > 0 THEN
        SELECT 'Error: Employee already assigned to this project' as message;
    ELSE
        INSERT INTO employee_projects (employee_id, project_id, role, hours_worked)
        VALUES (emp_id, proj_id, emp_role, hours);
        SELECT 'Success: Employee assigned to project' as message;
    END IF;
END //
DELIMITER ;

-- 4. Stored procedure to get project summary
DELIMITER //
CREATE PROCEDURE GetProjectSummary(IN proj_id INT)
BEGIN
    SELECT 
        p.project_id,
        p.project_name,
        d.department_name,
        p.start_date,
        p.end_date,
        p.budget,
        p.status,
        COUNT(ep.employee_id) as assigned_employees,
        SUM(ep.hours_worked) as total_hours,
        AVG(ep.hours_worked) as avg_hours_per_employee
    FROM projects p
    JOIN departments d ON p.department_id = d.department_id
    LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
    WHERE p.project_id = proj_id
    GROUP BY p.project_id, p.project_name, d.department_name, p.start_date, p.end_date, p.budget, p.status;
END //
DELIMITER ;

-- 5. Stored procedure to update employee salary
DELIMITER //
CREATE PROCEDURE UpdateEmployeeSalary(IN emp_id INT, IN new_salary DECIMAL(10,2))
BEGIN
    DECLARE emp_exists INT;
    DECLARE current_salary DECIMAL(10,2);
    
    -- Check if employee exists
    SELECT COUNT(*), salary INTO emp_exists, current_salary 
    FROM employees WHERE employee_id = emp_id;
    
    IF emp_exists = 0 THEN
        SELECT 'Error: Employee not found' as message;
    ELSEIF new_salary <= 0 THEN
        SELECT 'Error: Salary must be greater than 0' as message;
    ELSEIF new_salary < current_salary * 0.8 THEN
        SELECT 'Error: New salary cannot be less than 80% of current salary' as message;
    ELSE
        UPDATE employees SET salary = new_salary WHERE employee_id = emp_id;
        SELECT CONCAT('Success: Salary updated from ', current_salary, ' to ', new_salary) as message;
    END IF;
END //
DELIMITER ;

-- 6. Stored procedure to get active projects by department
DELIMITER //
CREATE PROCEDURE GetActiveProjectsByDepartment(IN dept_id INT)
BEGIN
    SELECT 
        p.project_id,
        p.project_name,
        p.start_date,
        p.end_date,
        p.budget,
        p.status,
        COUNT(ep.employee_id) as assigned_employees,
        SUM(ep.hours_worked) as total_hours,
        DATEDIFF(p.end_date, CURDATE()) as days_remaining
    FROM projects p
    LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
    WHERE p.department_id = dept_id AND p.status = 'In Progress'
    GROUP BY p.project_id, p.project_name, p.start_date, p.end_date, p.budget, p.status
    ORDER BY p.end_date;
END //
DELIMITER ; 