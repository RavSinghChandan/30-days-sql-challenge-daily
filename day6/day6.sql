SELECT e.*, d.department_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.department_id;

SELECT d.department_name, e.name, e.salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;

SELECT e.name, e.salary, d.department_name
FROM departments d
RIGHT JOIN employees e ON d.department_id = e.department_id;

SELECT e.employee_id, e.name, e.salary, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

SELECT d.department_name, COUNT(e.employee_id) as employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

SELECT e.name, e.salary, COALESCE(d.department_name, 'No Department') as department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;
