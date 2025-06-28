# Day 21: Window Functions

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

-- Create sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    sale_amount DECIMAL(10,2),
    sale_date DATE,
    product_category VARCHAR(50)
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

-- Add foreign key constraints
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE sales ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE projects ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
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

-- Insert sales data
INSERT INTO sales VALUES (1, 2, 5000, '2023-01-15', 'Electronics');
INSERT INTO sales VALUES (2, 2, 3000, '2023-01-20', 'Clothing');
INSERT INTO sales VALUES (3, 6, 4500, '2023-02-10', 'Electronics');
INSERT INTO sales VALUES (4, 2, 6000, '2023-02-15', 'Electronics');
INSERT INTO sales VALUES (5, 6, 2500, '2023-02-28', 'Clothing');
INSERT INTO sales VALUES (6, 2, 4000, '2023-03-20', 'Electronics');
INSERT INTO sales VALUES (7, 6, 3500, '2023-04-10', 'Electronics');
INSERT INTO sales VALUES (8, 2, 5500, '2023-04-25', 'Clothing');

-- Insert projects
INSERT INTO projects VALUES (1, 'Website Redesign', 1, '2023-01-01', '2023-06-30', 50000, 'In Progress');
INSERT INTO projects VALUES (2, 'Marketing Campaign', 2, '2023-02-15', '2023-05-15', 30000, 'Completed');
INSERT INTO projects VALUES (3, 'Financial Audit', 3, '2023-03-01', '2023-04-30', 25000, 'In Progress');
INSERT INTO projects VALUES (4, 'HR System Update', 4, '2023-01-15', '2023-08-15', 40000, 'In Progress');
INSERT INTO projects VALUES (5, 'Mobile App Development', 1, '2023-02-01', '2023-09-30', 75000, 'In Progress');
INSERT INTO projects VALUES (6, 'Brand Redesign', 2, '2023-03-15', '2023-07-15', 35000, 'In Progress');
```

## Questions

1. **Rank employees by salary within each department**
   - Use ROW_NUMBER(), RANK(), and DENSE_RANK()
   - Show employee name, salary, department, and rank

2. **Calculate running total of sales by employee**
   - Show cumulative sales amount for each employee
   - Order by sale date

3. **Find top 3 highest paid employees in each department**
   - Use DENSE_RANK() to handle ties
   - Show department name, employee name, salary, and rank

4. **Calculate salary percentile within each department**
   - Use NTILE() to divide employees into 4 quartiles
   - Show employee name, salary, department, and quartile

5. **Find employees with salary above department average**
   - Use window function to calculate department average
   - Compare individual salary with department average

6. **Calculate month-over-month sales growth**
   - Use LAG() to compare current month with previous month
   - Show percentage growth for each employee 