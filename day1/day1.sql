select * from employees;
select  distinct(department_name) from departments;
select * from employees where salary > 5000;
select e.* from employees e join departments d on d.department_id=e.department_id where department_name in('IT', 'HR');