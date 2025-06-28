-- 1. Create data transformation procedures
DELIMITER //
CREATE PROCEDURE TransformEmployeeData()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        INSERT INTO migration_audit (table_name, operation_type, records_processed, success_count, error_count)
        VALUES ('employees', 'TRANSFORM', 0, 0, 1);
    END;
    
    START TRANSACTION;
    
    -- Transform and insert employee data
    INSERT INTO employees (employee_id, name, salary, department_id, hire_date, status)
    SELECT 
        oe.emp_id,
        CONCAT(oe.first_name, ' ', oe.last_name) as name,
        CASE 
            WHEN oe.emp_salary REGEXP '^[0-9]+\.?[0-9]*$' THEN CAST(oe.emp_salary AS DECIMAL(10,2))
            ELSE NULL
        END as salary,
        CASE 
            WHEN oe.dept_code = 'ENG' THEN 1
            WHEN oe.dept_code = 'MKT' THEN 2
            WHEN oe.dept_code = 'FIN' THEN 3
            WHEN oe.dept_code = 'HR' THEN 4
            ELSE NULL
        END as department_id,
        CASE 
            WHEN oe.start_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(oe.start_date, '%Y-%m-%d')
            ELSE NULL
        END as hire_date,
        CASE 
            WHEN oe.emp_status = 'ACTIVE' THEN 'Active'
            WHEN oe.emp_status = 'INACTIVE' THEN 'Inactive'
            ELSE 'Active'
        END as status
    FROM old_employees oe
    WHERE oe.emp_id NOT IN (SELECT employee_id FROM employees);
    
    COMMIT;
    
    INSERT INTO migration_audit (table_name, operation_type, records_processed, success_count, error_count)
    VALUES ('employees', 'TRANSFORM', (SELECT COUNT(*) FROM old_employees), 
            (SELECT COUNT(*) FROM employees), 0);
END //
DELIMITER ;

-- 2. Implement incremental data loading
DELIMITER //
CREATE PROCEDURE IncrementalLoadEmployees(IN last_migration_date TIMESTAMP)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        INSERT INTO migration_audit (table_name, operation_type, records_processed, success_count, error_count)
        VALUES ('employees', 'INCREMENTAL_LOAD', 0, 0, 1);
    END;
    
    START TRANSACTION;
    
    -- Load only new or modified records since last migration
    INSERT INTO employees (employee_id, name, salary, department_id, hire_date, status)
    SELECT 
        oe.emp_id,
        CONCAT(oe.first_name, ' ', oe.last_name) as name,
        CASE 
            WHEN oe.emp_salary REGEXP '^[0-9]+\.?[0-9]*$' THEN CAST(oe.emp_salary AS DECIMAL(10,2))
            ELSE NULL
        END as salary,
        CASE 
            WHEN oe.dept_code = 'ENG' THEN 1
            WHEN oe.dept_code = 'MKT' THEN 2
            WHEN oe.dept_code = 'FIN' THEN 3
            WHEN oe.dept_code = 'HR' THEN 4
            ELSE NULL
        END as department_id,
        CASE 
            WHEN oe.start_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(oe.start_date, '%Y-%m-%d')
            ELSE NULL
        END as hire_date,
        CASE 
            WHEN oe.emp_status = 'ACTIVE' THEN 'Active'
            WHEN oe.emp_status = 'INACTIVE' THEN 'Inactive'
            ELSE 'Active'
        END as status
    FROM old_employees oe
    WHERE oe.emp_id NOT IN (SELECT employee_id FROM employees)
    ON DUPLICATE KEY UPDATE
        name = VALUES(name),
        salary = VALUES(salary),
        department_id = VALUES(department_id),
        hire_date = VALUES(hire_date),
        status = VALUES(status);
    
    COMMIT;
    
    INSERT INTO migration_audit (table_name, operation_type, records_processed, success_count, error_count)
    VALUES ('employees', 'INCREMENTAL_LOAD', 
            (SELECT COUNT(*) FROM old_employees WHERE emp_id NOT IN (SELECT employee_id FROM employees)), 
            (SELECT COUNT(*) FROM employees), 0);
END //
DELIMITER ;

-- 3. Handle data type conversions
-- Validate and convert salary data
SELECT 
    emp_id,
    first_name,
    last_name,
    emp_salary,
    CASE 
        WHEN emp_salary REGEXP '^[0-9]+\.?[0-9]*$' THEN 'Valid'
        ELSE 'Invalid'
    END as salary_validation,
    CASE 
        WHEN emp_salary REGEXP '^[0-9]+\.?[0-9]*$' THEN CAST(emp_salary AS DECIMAL(10,2))
        ELSE NULL
    END as converted_salary
FROM old_employees;

-- Validate and convert date data
SELECT 
    emp_id,
    first_name,
    last_name,
    start_date,
    CASE 
        WHEN start_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN 'Valid'
        ELSE 'Invalid'
    END as date_validation,
    CASE 
        WHEN start_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(start_date, '%Y-%m-%d')
        ELSE NULL
    END as converted_date
FROM old_employees;

-- Map department codes to IDs
SELECT 
    oe.emp_id,
    oe.dept_code,
    od.dept_desc,
    CASE 
        WHEN oe.dept_code = 'ENG' THEN 1
        WHEN oe.dept_code = 'MKT' THEN 2
        WHEN oe.dept_code = 'FIN' THEN 3
        WHEN oe.dept_code = 'HR' THEN 4
        ELSE NULL
    END as mapped_department_id
FROM old_employees oe
LEFT JOIN old_departments od ON oe.dept_code = od.dept_code;

-- 4. Create data validation checks
-- Validate salary ranges and formats
INSERT INTO data_validation_log (table_name, validation_type, error_message, record_count)
SELECT 
    'old_employees' as table_name,
    'SALARY_VALIDATION' as validation_type,
    CONCAT('Invalid salary format: ', emp_salary) as error_message,
    COUNT(*) as record_count
FROM old_employees
WHERE emp_salary NOT REGEXP '^[0-9]+\.?[0-9]*$'
GROUP BY emp_salary;

-- Check for required fields
INSERT INTO data_validation_log (table_name, validation_type, error_message, record_count)
SELECT 
    'old_employees' as table_name,
    'REQUIRED_FIELDS' as validation_type,
    'Missing required field' as error_message,
    COUNT(*) as record_count
FROM old_employees
WHERE first_name IS NULL OR last_name IS NULL OR emp_salary IS NULL;

-- Verify foreign key relationships
INSERT INTO data_validation_log (table_name, validation_type, error_message, record_count)
SELECT 
    'old_employees' as table_name,
    'FOREIGN_KEY_VALIDATION' as validation_type,
    CONCAT('Invalid department code: ', oe.dept_code) as error_message,
    COUNT(*) as record_count
FROM old_employees oe
LEFT JOIN old_departments od ON oe.dept_code = od.dept_code
WHERE od.dept_code IS NULL
GROUP BY oe.dept_code;

-- 5. Implement error handling for data loads
-- Load data into staging table with validation
INSERT INTO staging_employees (emp_id, first_name, last_name, emp_salary, dept_code, start_date, emp_status, validation_status, error_message)
SELECT 
    emp_id,
    first_name,
    last_name,
    emp_salary,
    dept_code,
    start_date,
    emp_status,
    CASE 
        WHEN emp_salary NOT REGEXP '^[0-9]+\.?[0-9]*$' THEN 'Error'
        WHEN start_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN 'Error'
        WHEN dept_code NOT IN (SELECT dept_code FROM old_departments) THEN 'Error'
        ELSE 'Valid'
    END as validation_status,
    CASE 
        WHEN emp_salary NOT REGEXP '^[0-9]+\.?[0-9]*$' THEN 'Invalid salary format'
        WHEN start_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN 'Invalid date format'
        WHEN dept_code NOT IN (SELECT dept_code FROM old_departments) THEN 'Invalid department code'
        ELSE NULL
    END as error_message
FROM old_employees;

-- Handle duplicate records
SELECT 
    emp_id,
    COUNT(*) as duplicate_count,
    'Duplicate record found' as issue
FROM old_employees
GROUP BY emp_id
HAVING COUNT(*) > 1;

-- 6. Create audit trails for data changes
-- Track migration progress
SELECT 
    table_name,
    operation_type,
    records_processed,
    success_count,
    error_count,
    migration_date,
    ROUND((success_count / records_processed) * 100, 2) as success_rate
FROM migration_audit
ORDER BY migration_date DESC;

-- Log successful and failed operations
SELECT 
    'SUCCESS' as operation_status,
    COUNT(*) as record_count
FROM staging_employees
WHERE validation_status = 'Valid'

UNION ALL

SELECT 
    'FAILED' as operation_status,
    COUNT(*) as record_count
FROM staging_employees
WHERE validation_status = 'Error';

-- Monitor data quality metrics
SELECT 
    'Total Records' as metric,
    COUNT(*) as value
FROM old_employees

UNION ALL

SELECT 
    'Valid Records' as metric,
    COUNT(*) as value
FROM staging_employees
WHERE validation_status = 'Valid'

UNION ALL

SELECT 
    'Invalid Records' as metric,
    COUNT(*) as value
FROM staging_employees
WHERE validation_status = 'Error'

UNION ALL

SELECT 
    'Data Quality Score' as metric,
    ROUND((COUNT(CASE WHEN validation_status = 'Valid' THEN 1 END) / COUNT(*)) * 100, 2) as value
FROM staging_employees; 