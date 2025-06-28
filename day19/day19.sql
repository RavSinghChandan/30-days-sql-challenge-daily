-- 1. Trigger to audit salary changes
DELIMITER //
CREATE TRIGGER audit_salary_changes
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary != NEW.salary THEN
        INSERT INTO employee_audit (employee_id, action_type, old_salary, new_salary, changed_by)
        VALUES (NEW.employee_id, 'SALARY_UPDATE', OLD.salary, NEW.salary, USER());
    END IF;
END //
DELIMITER ;

-- 2. Trigger to maintain salary history
DELIMITER //
CREATE TRIGGER maintain_salary_history
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary != NEW.salary THEN
        INSERT INTO salary_history (employee_id, old_salary, new_salary, change_reason)
        VALUES (NEW.employee_id, OLD.salary, NEW.salary, 'Salary update');
    END IF;
END //
DELIMITER ;

-- 3. Trigger to update department statistics after employee changes
DELIMITER //
CREATE TRIGGER update_dept_stats_after_employee_change
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE department_stats 
    SET 
        employee_count = (SELECT COUNT(*) FROM employees WHERE department_id = NEW.department_id AND status = 'Active'),
        total_salary = (SELECT SUM(salary) FROM employees WHERE department_id = NEW.department_id AND status = 'Active'),
        avg_salary = (SELECT AVG(salary) FROM employees WHERE department_id = NEW.department_id AND status = 'Active')
    WHERE department_id = NEW.department_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_dept_stats_after_employee_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Update old department stats
    IF OLD.department_id IS NOT NULL THEN
        UPDATE department_stats 
        SET 
            employee_count = (SELECT COUNT(*) FROM employees WHERE department_id = OLD.department_id AND status = 'Active'),
            total_salary = (SELECT SUM(salary) FROM employees WHERE department_id = OLD.department_id AND status = 'Active'),
            avg_salary = (SELECT AVG(salary) FROM employees WHERE department_id = OLD.department_id AND status = 'Active')
        WHERE department_id = OLD.department_id;
    END IF;
    
    -- Update new department stats
    IF NEW.department_id IS NOT NULL THEN
        UPDATE department_stats 
        SET 
            employee_count = (SELECT COUNT(*) FROM employees WHERE department_id = NEW.department_id AND status = 'Active'),
            total_salary = (SELECT SUM(salary) FROM employees WHERE department_id = NEW.department_id AND status = 'Active'),
            avg_salary = (SELECT AVG(salary) FROM employees WHERE department_id = NEW.department_id AND status = 'Active')
        WHERE department_id = NEW.department_id;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_dept_stats_after_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    UPDATE department_stats 
    SET 
        employee_count = (SELECT COUNT(*) FROM employees WHERE department_id = OLD.department_id AND status = 'Active'),
        total_salary = (SELECT SUM(salary) FROM employees WHERE department_id = OLD.department_id AND status = 'Active'),
        avg_salary = (SELECT AVG(salary) FROM employees WHERE department_id = OLD.department_id AND status = 'Active')
    WHERE department_id = OLD.department_id;
END //
DELIMITER ;

-- 4. Trigger to prevent salary reduction by more than 10%
DELIMITER //
CREATE TRIGGER prevent_salary_reduction
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < OLD.salary * 0.9 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be reduced by more than 10%';
    END IF;
END //
DELIMITER ;

-- 5. Trigger to validate department assignment
DELIMITER //
CREATE TRIGGER validate_department_assignment
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE dept_exists INT;
    
    SELECT COUNT(*) INTO dept_exists 
    FROM departments 
    WHERE department_id = NEW.department_id;
    
    IF dept_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid department_id: Department does not exist';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER validate_department_assignment_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE dept_exists INT;
    
    IF NEW.department_id IS NOT NULL THEN
        SELECT COUNT(*) INTO dept_exists 
        FROM departments 
        WHERE department_id = NEW.department_id;
        
        IF dept_exists = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid department_id: Department does not exist';
        END IF;
    END IF;
END //
DELIMITER ;

-- 6. Trigger to log employee status changes
DELIMITER //
CREATE TRIGGER log_status_changes
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO employee_audit (employee_id, action_type, old_salary, new_salary, changed_by)
        VALUES (NEW.employee_id, 'STATUS_CHANGE', OLD.salary, NEW.salary, USER());
    END IF;
END //
DELIMITER ; 