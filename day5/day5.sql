select e.name,d.department_name, count(*) as employe_per_department from
employees e join departments d on e.department_id = d.department_id
group by d.department_name;

select department_name, avg(salary) as average_salary from employees e join
  departments d on d.department_id = e.department_id group by department_name;

  select department_name, count(e.employee_id) as employee_per_department
  from employees e join departments d on d.department_id = e.department_id
  group by department_name having
  count(e.employee_id) > 2;

  select department_name, avg(e.salary) as average_salary from employees e join
  departments d on e.department_id = d.department_id group by department_name
  having avg(e.salary)>60000;