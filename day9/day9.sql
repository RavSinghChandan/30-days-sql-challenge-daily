-- 1. Combine employee data from two tables (old and new branches) using UNION
SELECT employee_id, name, salary, department, hire_date, 'Old Branch' as source
FROM employees_old_branch
UNION
SELECT employee_id, name, salary, department, hire_date, 'New Branch' as source
FROM employees_new_branch;

-- 2. Combine employee data from two tables using UNION ALL
SELECT employee_id, name, salary, department, hire_date, 'Old Branch' as source
FROM employees_old_branch
UNION ALL
SELECT employee_id, name, salary, department, hire_date, 'New Branch' as source
FROM employees_new_branch;

-- 3. Fetch all distinct and non-distinct employee records
-- Distinct records (UNION)
SELECT employee_id, name, salary, department
FROM employees_old_branch
UNION
SELECT employee_id, name, salary, department
FROM employees_new_branch;

-- All records including duplicates (UNION ALL)
SELECT employee_id, name, salary, department
FROM employees_old_branch
UNION ALL
SELECT employee_id, name, salary, department
FROM employees_new_branch;

-- 4. Combine active and inactive employees using UNION
SELECT employee_id, name, status
FROM active_employees
UNION
SELECT employee_id, name, status
FROM inactive_employees;

-- 5. Combine active and inactive employees using UNION ALL
SELECT employee_id, name, status
FROM active_employees
UNION ALL
SELECT employee_id, name, status
FROM inactive_employees;

-- 6. Combine products from 2023 and 2024 using both UNION and UNION ALL
-- Using UNION (removes duplicates)
SELECT product_id, product_name, price, category, '2023' as year
FROM products_2023
UNION
SELECT product_id, product_name, price, category, '2024' as year
FROM products_2024;

-- Using UNION ALL (keeps duplicates)
SELECT product_id, product_name, price, category, '2023' as year
FROM products_2023
UNION ALL
SELECT product_id, product_name, price, category, '2024' as year
FROM products_2024; 