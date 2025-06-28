# Day 24: Data Quality & Validation

## Schema Creation

```sql
-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    hire_date DATE,
    email VARCHAR(100),
    phone VARCHAR(20),
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

-- Insert employees (with some data quality issues)
INSERT INTO employees VALUES (1, 'John Smith', 75000, 1, '2020-01-15', 'john.smith@company.com', '555-0101', 'Active');
INSERT INTO employees VALUES (2, 'Sarah Johnson', 65000, 2, '2019-03-20', 'sarah.johnson@company.com', '555-0102', 'Active');
INSERT INTO employees VALUES (3, 'Mike Davis', 80000, 1, '2018-11-10', 'mike.davis@company.com', '555-0103', 'Active');
INSERT INTO employees VALUES (4, 'Lisa Brown', 70000, 3, '2021-06-05', 'lisa.brown@company.com', '555-0104', 'Active');
INSERT INTO employees VALUES (5, 'David Wilson', 90000, 1, '2017-09-12', 'david.wilson@company.com', '555-0105', 'Active');
INSERT INTO employees VALUES (6, 'Emily Taylor', 60000, 2, '2022-02-28', 'emily.taylor@company.com', '555-0106', 'Active');
INSERT INTO employees VALUES (7, 'Tom Anderson', 85000, 3, '2019-08-15', 'tom.anderson@company.com', '555-0107', 'Inactive');
INSERT INTO employees VALUES (8, 'Jessica Lee', 72000, 4, '2020-12-01', 'jessica.lee@company.com', '555-0108', 'Active');
-- Duplicate records
INSERT INTO employees VALUES (9, 'John Smith', 75000, 1, '2020-01-15', 'john.smith@company.com', '555-0101', 'Active');
INSERT INTO employees VALUES (10, 'Sarah Johnson', 65000, 2, '2019-03-20', 'sarah.johnson@company.com', '555-0102', 'Active');
-- Missing department assignment
INSERT INTO employees VALUES (11, 'Unknown Employee', 50000, NULL, '2023-01-01', 'unknown@company.com', '555-0109', 'Active');
-- Invalid salary
INSERT INTO employees VALUES (12, 'Invalid Salary', -5000, 1, '2023-02-01', 'invalid@company.com', '555-0110', 'Active');
-- Inconsistent date format
INSERT INTO employees VALUES (13, 'Date Issue', 60000, 2, '2023-13-45', 'date@company.com', '555-0111', 'Active');

-- Insert projects
INSERT INTO projects VALUES (1, 'Website Redesign', 1, '2023-01-01', '2023-06-30', 50000, 'In Progress');
INSERT INTO projects VALUES (2, 'Marketing Campaign', 2, '2023-02-15', '2023-05-15', 30000, 'Completed');
INSERT INTO projects VALUES (3, 'Financial Audit', 3, '2023-03-01', '2023-04-30', 25000, 'In Progress');
INSERT INTO projects VALUES (4, 'HR System Update', 4, '2023-01-15', '2023-08-15', 40000, 'In Progress');
-- Orphaned project (department doesn't exist)
INSERT INTO projects VALUES (5, 'Orphaned Project', 99, '2023-01-01', '2023-12-31', 10000, 'In Progress');

-- Insert employee_projects
INSERT INTO employee_projects VALUES (1, 1, 'Developer', 120);
INSERT INTO employee_projects VALUES (3, 1, 'Lead Developer', 150);
INSERT INTO employee_projects VALUES (5, 1, 'Architect', 80);
INSERT INTO employee_projects VALUES (2, 2, 'Marketing Manager', 100);
INSERT INTO employee_projects VALUES (6, 2, 'Designer', 90);
INSERT INTO employee_projects VALUES (4, 3, 'Analyst', 60);
INSERT INTO employee_projects VALUES (8, 4, 'Coordinator', 70);
-- Orphaned assignment (employee doesn't exist)
INSERT INTO employee_projects VALUES (999, 1, 'Developer', 100);
```

## Questions

1. **Find duplicate employee records**
   - Identify employees with same name, email, or phone
   - Show duplicate count and details

2. **Identify missing department assignments**
   - Find employees without department_id
   - Show employee details for correction

3. **Validate salary ranges by department**
   - Check for salaries outside reasonable ranges
   - Identify negative or zero salaries

4. **Find inconsistent date formats**
   - Identify invalid dates in hire_date
   - Show problematic records

5. **Check for orphaned records**
   - Find employee_projects with non-existent employees
   - Find projects with non-existent departments

6. **Validate foreign key relationships**
   - Check for broken referential integrity
   - Identify orphaned records in all tables 