# Day 26: Advanced Joins

## Schema Creation

```sql
-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    hire_date DATE,
    manager_id INT,
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

-- Create skills table
CREATE TABLE skills (
    skill_id INT PRIMARY KEY,
    skill_name VARCHAR(100),
    category VARCHAR(50)
);

-- Create employee_skills table
CREATE TABLE employee_skills (
    employee_id INT,
    skill_id INT,
    proficiency_level INT,
    PRIMARY KEY (employee_id, skill_id)
);

-- Add foreign key constraints
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employees ADD FOREIGN KEY (manager_id) REFERENCES employees(employee_id);
ALTER TABLE projects ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employee_projects ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE employee_projects ADD FOREIGN KEY (project_id) REFERENCES projects(project_id);
ALTER TABLE employee_skills ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE employee_skills ADD FOREIGN KEY (skill_id) REFERENCES skills(skill_id);
```

## Sample Data

```sql
-- Insert departments
INSERT INTO departments VALUES (1, 'Engineering', 'New York');
INSERT INTO departments VALUES (2, 'Marketing', 'Los Angeles');
INSERT INTO departments VALUES (3, 'Finance', 'Chicago');
INSERT INTO departments VALUES (4, 'HR', 'Boston');

-- Insert employees
INSERT INTO employees VALUES (1, 'John Smith', 75000, 1, '2020-01-15', NULL, 'Active');
INSERT INTO employees VALUES (2, 'Sarah Johnson', 65000, 2, '2019-03-20', 1, 'Active');
INSERT INTO employees VALUES (3, 'Mike Davis', 80000, 1, '2018-11-10', 1, 'Active');
INSERT INTO employees VALUES (4, 'Lisa Brown', 70000, 3, '2021-06-05', 1, 'Active');
INSERT INTO employees VALUES (5, 'David Wilson', 90000, 1, '2017-09-12', 3, 'Active');
INSERT INTO employees VALUES (6, 'Emily Taylor', 60000, 2, '2022-02-28', 2, 'Active');
INSERT INTO employees VALUES (7, 'Tom Anderson', 85000, 3, '2019-08-15', 4, 'Active');
INSERT INTO employees VALUES (8, 'Jessica Lee', 72000, 4, '2020-12-01', 1, 'Active');

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

-- Insert skills
INSERT INTO skills VALUES (1, 'SQL', 'Database');
INSERT INTO skills VALUES (2, 'Python', 'Programming');
INSERT INTO skills VALUES (3, 'JavaScript', 'Programming');
INSERT INTO skills VALUES (4, 'Project Management', 'Management');
INSERT INTO skills VALUES (5, 'Data Analysis', 'Analytics');
INSERT INTO skills VALUES (6, 'Marketing', 'Business');

-- Insert employee_skills
INSERT INTO employee_skills VALUES (1, 1, 5);
INSERT INTO employee_skills VALUES (1, 2, 4);
INSERT INTO employee_skills VALUES (2, 6, 5);
INSERT INTO employee_skills VALUES (2, 4, 3);
INSERT INTO employee_skills VALUES (3, 1, 4);
INSERT INTO employee_skills VALUES (3, 3, 5);
INSERT INTO employee_skills VALUES (4, 5, 4);
INSERT INTO employee_skills VALUES (5, 1, 5);
INSERT INTO employee_skills VALUES (5, 2, 5);
INSERT INTO employee_skills VALUES (6, 6, 4);
INSERT INTO employee_skills VALUES (7, 5, 5);
INSERT INTO employee_skills VALUES (8, 4, 4);
```

## Questions

1. **Use CROSS JOIN to generate combinations**
   - Generate all possible employee-skill combinations
   - Show missing skill assignments

2. **Implement self-joins for hierarchical data**
   - Show employee-manager relationships
   - Display organizational hierarchy levels

3. **Use multiple joins with complex conditions**
   - Join employees, departments, projects, and skills
   - Apply multiple filtering conditions

4. **Implement anti-joins to find missing data**
   - Find employees without project assignments
   - Identify departments without employees

5. **Use lateral joins for correlated subqueries**
   - Find top skills for each employee
   - Get department statistics with employee details

6. **Implement full outer joins for data comparison**
   - Compare employee skills across departments
   - Show all combinations of employees and projects 