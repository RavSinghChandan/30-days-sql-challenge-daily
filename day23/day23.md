# Day 23: Pivot Tables

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

-- Create sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    product_category VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE,
    quarter VARCHAR(10)
);

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Add foreign key constraints
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE projects ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
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
INSERT INTO employees VALUES (7, 'Tom Anderson', 85000, 3, '2019-08-15', 'Inactive');
INSERT INTO employees VALUES (8, 'Jessica Lee', 72000, 4, '2020-12-01', 'Active');

-- Insert projects
INSERT INTO projects VALUES (1, 'Website Redesign', 1, '2023-01-01', '2023-06-30', 50000, 'In Progress');
INSERT INTO projects VALUES (2, 'Marketing Campaign', 2, '2023-02-15', '2023-05-15', 30000, 'Completed');
INSERT INTO projects VALUES (3, 'Financial Audit', 3, '2023-03-01', '2023-04-30', 25000, 'In Progress');
INSERT INTO projects VALUES (4, 'HR System Update', 4, '2023-01-15', '2023-08-15', 40000, 'In Progress');

-- Insert sales data
INSERT INTO sales VALUES (1, 2, 'Electronics', 5000, '2023-01-15', 'Q1 2023');
INSERT INTO sales VALUES (2, 2, 'Clothing', 3000, '2023-01-20', 'Q1 2023');
INSERT INTO sales VALUES (3, 6, 'Electronics', 4500, '2023-02-10', 'Q1 2023');
INSERT INTO sales VALUES (4, 2, 'Electronics', 6000, '2023-02-15', 'Q1 2023');
INSERT INTO sales VALUES (5, 6, 'Clothing', 2500, '2023-02-28', 'Q1 2023');
INSERT INTO sales VALUES (6, 2, 'Electronics', 4000, '2023-03-20', 'Q1 2023');
INSERT INTO sales VALUES (7, 6, 'Electronics', 3500, '2023-04-10', 'Q2 2023');
INSERT INTO sales VALUES (8, 2, 'Clothing', 5500, '2023-04-25', 'Q2 2023');
INSERT INTO sales VALUES (9, 6, 'Electronics', 7000, '2023-05-15', 'Q2 2023');
INSERT INTO sales VALUES (10, 2, 'Clothing', 4000, '2023-06-20', 'Q2 2023');

-- Insert products
INSERT INTO products VALUES (1, 'Laptop Pro', 'Electronics', 1200);
INSERT INTO products VALUES (2, 'Office Chair', 'Furniture', 300);
INSERT INTO products VALUES (3, 'Coffee Maker', 'Appliances', 150);
INSERT INTO products VALUES (4, 'Desk Lamp', 'Furniture', 80);
INSERT INTO products VALUES (5, 'Smartphone X', 'Electronics', 800);
INSERT INTO products VALUES (6, 'Standing Desk', 'Furniture', 400);
```

## Questions

1. **Pivot sales data by product category and month**
   - Show total sales amount for each category by month
   - Use conditional aggregation with CASE statements

2. **Create pivot table for employee count by department and status**
   - Show employee count for each department and status combination
   - Display as a matrix format

3. **Pivot project budget by department and status**
   - Show total budget for each department and project status
   - Calculate budget allocation percentages

4. **Create pivot table for salary ranges by department**
   - Group employees into salary ranges (Low, Medium, High)
   - Show count of employees in each range by department

5. **Pivot sales performance by employee and quarter**
   - Show total sales amount for each employee by quarter
   - Calculate quarter-over-quarter growth

6. **Create pivot table for project timeline by department**
   - Show project count by department and timeline status
   - Include overdue, on-time, and completed projects 