# Day 22: CTEs (Common Table Expressions)

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

-- Create employee_hierarchy table for recursive CTE
CREATE TABLE employee_hierarchy (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT,
    level INT DEFAULT 1
);

-- Add foreign key constraints
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE projects ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employee_projects ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE employee_projects ADD FOREIGN KEY (project_id) REFERENCES projects(project_id);
ALTER TABLE employee_hierarchy ADD FOREIGN KEY (manager_id) REFERENCES employee_hierarchy(employee_id);
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
INSERT INTO employees VALUES (7, 'Tom Anderson', 85000, 3, '2019-08-15', 'Active');
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
INSERT INTO employee_projects VALUES (1, 4, 'Developer', 50);

-- Insert employee hierarchy
INSERT INTO employee_hierarchy VALUES (1, 'CEO', NULL, 1);
INSERT INTO employee_hierarchy VALUES (2, 'CTO', 1, 2);
INSERT INTO employee_hierarchy VALUES (3, 'CFO', 1, 2);
INSERT INTO employee_hierarchy VALUES (4, 'Senior Developer', 2, 3);
INSERT INTO employee_hierarchy VALUES (5, 'Junior Developer', 4, 4);
INSERT INTO employee_hierarchy VALUES (6, 'Financial Analyst', 3, 3);
INSERT INTO employee_hierarchy VALUES (7, 'HR Manager', 1, 2);
INSERT INTO employee_hierarchy VALUES (8, 'HR Assistant', 7, 3);
```

## Questions

1. **Create a CTE to find employees with salary above department average**
   - Use CTE to calculate department averages
   - Compare individual salaries with department averages

2. **Use CTE to calculate department budget utilization**
   - Calculate total project budget by department
   - Show budget utilization percentage

3. **Create recursive CTE to find employee hierarchy**
   - Show employee reporting structure
   - Display hierarchy levels

4. **Use CTE to find employees working on multiple projects**
   - Count projects per employee
   - Show employees with more than one project

5. **Create CTE to calculate cumulative salary by department**
   - Show running total of salaries within each department
   - Order by employee hire date

6. **Use CTE to find departments with highest average salary**
   - Calculate average salary by department
   - Rank departments by average salary 