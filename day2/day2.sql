SELECT * FROM employees;

SELECT * FROM departments;

SELECT * FROM employees
ORDER BY salary DESC
LIMIT 5;

SELECT * FROM departments
ORDER BY department_id ASC
LIMIT 5;

SELECT * FROM employees
ORDER BY employee_id
LIMIT 10 OFFSET 10;

SELECT * FROM employees
ORDER BY employee_id
LIMIT 10 OFFSET 20;
