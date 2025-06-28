# Day 18: Stored Procedures

## Schema Creation

```sql
-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    hire_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);

-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

-- Create projects table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12,2),
    status VARCHAR(20)
);

-- Create employee_projects table
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50),
    hours_worked INT,
    PRIMARY KEY (employee_id, project_id)
);

-- Add foreign key constraints
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE projects ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employee_projects ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE employee_projects ADD FOREIGN KEY (project_id) REFERENCES projects(project_id);
```

## Sample Data

```sql
-- Insert departments
INSERT INTO departments VALUES (1, 'Engineering', 'New York');
INSERT INTO departments VALUES (2, 'Marketing', 'Los Angeles');
INSERT INTO departments VALUES (3, 'Finance', 'Chicago');
INSERT INTO departments VALUES (4, 'HR', 'Boston');

-- Insert employees
INSERT INTO employees VALUES (1, 'John Smith', 75000, 1, '2020-01-15', 'Active');
INSERT INTO employees VALUES (2, 'Sarah Johnson', 65000, 2, '2019-03-20', 'Active');
INSERT INTO employees VALUES (3, 'Mike Davis', 80000, 1, '2018-11-10', 'Active');
INSERT INTO employees VALUES (4, 'Lisa Brown', 70000, 3, '2021-06-05', 'Active');
INSERT INTO employees VALUES (5, 'David Wilson', 90000, 1, '2017-09-12', 'Active');
INSERT INTO employees VALUES (6, 'Emily Taylor', 60000, 2, '2022-02-28', 'Active');
INSERT INTO employees VALUES (7, 'Tom Anderson', 85000, 3, '2019-08-15', 'Inactive');
INSERT INTO employees VALUES (8, 'Jessica Lee', 72000, 4, '2020-12-01', 'Active');

-- Insert projects
INSERT INTO projects VALUES (1, 'Website Redesign', 1, '2023-01-01', '2023-06-30', 50000, 'In Progress');
INSERT INTO projects VALUES (2, 'Marketing Campaign', 2, '2023-02-15', '2023-05-15', 30000, 'Completed');
INSERT INTO projects VALUES (3, 'Financial Audit', 3, '2023-03-01', '2023-04-30', 25000, 'In Progress');
INSERT INTO projects VALUES (4, 'HR System Update', 4, '2023-01-15', '2023-08-15', 40000, 'In Progress');

-- Insert employee_projects
INSERT INTO employee_projects VALUES (1, 1, 'Developer', 120);
INSERT INTO employee_projects VALUES (3, 1, 'Lead Developer', 150);
INSERT INTO employee_projects VALUES (5, 1, 'Architect', 80);
INSERT INTO employee_projects VALUES (2, 2, 'Marketing Manager', 100);
INSERT INTO employee_projects VALUES (6, 2, 'Designer', 90);
INSERT INTO employee_projects VALUES (4, 3, 'Analyst', 60);
INSERT INTO employee_projects VALUES (8, 4, 'Coordinator', 70);
```

## Questions

1. **Create a stored procedure to get employees by department**
   - Input: department_id
   - Output: employee details for that department

2. **Create a stored procedure to calculate department salary statistics**
   - Input: department_id
   - Output: count, average, min, max salary for the department

3. **Create a stored procedure to assign employee to project**
   - Input: employee_id, project_id, role, hours_worked
   - Output: success/failure message

4. **Create a stored procedure to get project summary**
   - Input: project_id
   - Output: project details with assigned employees count and total hours

5. **Create a stored procedure to update employee salary**
   - Input: employee_id, new_salary
   - Output: success/failure message with validation

6. **Create a stored procedure to get active projects by department**
   - Input: department_id
   - Output: all active projects for the department with budget and timeline 