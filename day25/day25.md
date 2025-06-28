# Day 25: Performance Optimization

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

-- Create sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    sale_amount DECIMAL(10,2),
    sale_date DATE,
    product_category VARCHAR(50)
);

-- Add foreign key constraints
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE projects ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employee_projects ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE employee_projects ADD FOREIGN KEY (project_id) REFERENCES projects(project_id);
ALTER TABLE sales ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
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

-- Insert sales data
INSERT INTO sales VALUES (1, 2, 5000, '2023-01-15', 'Electronics');
INSERT INTO sales VALUES (2, 2, 3000, '2023-01-20', 'Clothing');
INSERT INTO sales VALUES (3, 6, 4500, '2023-02-10', 'Electronics');
INSERT INTO sales VALUES (4, 2, 6000, '2023-02-15', 'Electronics');
INSERT INTO sales VALUES (5, 6, 2500, '2023-02-28', 'Clothing');
INSERT INTO sales VALUES (6, 2, 4000, '2023-03-20', 'Electronics');
INSERT INTO sales VALUES (7, 6, 3500, '2023-04-10', 'Electronics');
INSERT INTO sales VALUES (8, 2, 5500, '2023-04-25', 'Clothing');
```

## Questions

1. **Analyze query execution plans**
   - Use EXPLAIN to analyze slow queries
   - Identify bottlenecks and optimization opportunities

2. **Optimize slow-running queries**
   - Rewrite inefficient queries
   - Use appropriate JOIN strategies

3. **Create appropriate indexes**
   - Add indexes for frequently queried columns
   - Create composite indexes for complex queries

4. **Use query hints for optimization**
   - Apply FORCE INDEX hints
   - Use STRAIGHT_JOIN for specific join order

5. **Optimize joins and subqueries**
   - Convert subqueries to JOINs where possible
   - Use EXISTS instead of IN for large datasets

6. **Implement query result caching**
   - Create materialized views
   - Use application-level caching strategies 