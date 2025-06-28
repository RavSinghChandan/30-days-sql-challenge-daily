# Day 28: Advanced Analytics

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
    product_category VARCHAR(50),
    customer_id INT
);

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    registration_date DATE,
    segment VARCHAR(50)
);

-- Create employee_retention table
CREATE TABLE employee_retention (
    employee_id INT,
    hire_date DATE,
    termination_date DATE,
    retention_days INT,
    termination_reason VARCHAR(100)
);

-- Create a_b_testing table
CREATE TABLE a_b_testing (
    test_id INT PRIMARY KEY,
    customer_id INT,
    variant VARCHAR(10),
    conversion_rate DECIMAL(5,4),
    revenue DECIMAL(10,2),
    test_date DATE
);

-- Add foreign key constraints
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE sales ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE sales ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE employee_retention ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE a_b_testing ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
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

-- Insert customers
INSERT INTO customers VALUES (1, 'Acme Corp', 'acme@email.com', '2022-01-15', 'Enterprise');
INSERT INTO customers VALUES (2, 'TechStart Inc', 'tech@email.com', '2022-03-20', 'Startup');
INSERT INTO customers VALUES (3, 'Global Solutions', 'global@email.com', '2022-02-10', 'Enterprise');
INSERT INTO customers VALUES (4, 'Local Business', 'local@email.com', '2022-04-05', 'SMB');
INSERT INTO customers VALUES (5, 'Innovation Labs', 'innovate@email.com', '2022-05-12', 'Startup');

-- Insert sales data (monthly for 2023)
INSERT INTO sales VALUES (1, 2, 5000, '2023-01-15', 'Electronics', 1);
INSERT INTO sales VALUES (2, 2, 3000, '2023-01-20', 'Clothing', 2);
INSERT INTO sales VALUES (3, 6, 4500, '2023-02-10', 'Electronics', 3);
INSERT INTO sales VALUES (4, 2, 6000, '2023-02-15', 'Electronics', 1);
INSERT INTO sales VALUES (5, 6, 2500, '2023-02-28', 'Clothing', 4);
INSERT INTO sales VALUES (6, 2, 4000, '2023-03-20', 'Electronics', 2);
INSERT INTO sales VALUES (7, 6, 3500, '2023-04-10', 'Electronics', 3);
INSERT INTO sales VALUES (8, 2, 5500, '2023-04-25', 'Clothing', 1);
INSERT INTO sales VALUES (9, 6, 7000, '2023-05-15', 'Electronics', 5);
INSERT INTO sales VALUES (10, 2, 4000, '2023-06-20', 'Clothing', 2);
INSERT INTO sales VALUES (11, 6, 6500, '2023-07-10', 'Electronics', 3);
INSERT INTO sales VALUES (12, 2, 4800, '2023-08-15', 'Clothing', 1);

-- Insert employee retention data
INSERT INTO employee_retention VALUES (1, '2020-01-15', NULL, NULL, NULL);
INSERT INTO employee_retention VALUES (2, '2019-03-20', NULL, NULL, NULL);
INSERT INTO employee_retention VALUES (3, '2018-11-10', NULL, NULL, NULL);
INSERT INTO employee_retention VALUES (4, '2021-06-05', NULL, NULL, NULL);
INSERT INTO employee_retention VALUES (5, '2017-09-12', NULL, NULL, NULL);
INSERT INTO employee_retention VALUES (6, '2022-02-28', NULL, NULL, NULL);
INSERT INTO employee_retention VALUES (7, '2019-08-15', NULL, NULL, NULL);
INSERT INTO employee_retention VALUES (8, '2020-12-01', NULL, NULL, NULL);
-- Historical terminated employees
INSERT INTO employee_retention VALUES (9, '2020-03-01', '2022-06-15', 836, 'Career Change');
INSERT INTO employee_retention VALUES (10, '2021-01-10', '2023-02-28', 779, 'Better Opportunity');
INSERT INTO employee_retention VALUES (11, '2019-07-20', '2022-12-10', 1239, 'Relocation');

-- Insert A/B testing data
INSERT INTO a_b_testing VALUES (1, 1, 'A', 0.0450, 250.00, '2023-01-15');
INSERT INTO a_b_testing VALUES (2, 2, 'B', 0.0520, 300.00, '2023-01-16');
INSERT INTO a_b_testing VALUES (3, 3, 'A', 0.0380, 180.00, '2023-01-17');
INSERT INTO a_b_testing VALUES (4, 4, 'B', 0.0610, 350.00, '2023-01-18');
INSERT INTO a_b_testing VALUES (5, 5, 'A', 0.0420, 220.00, '2023-01-19');
INSERT INTO a_b_testing VALUES (6, 1, 'B', 0.0580, 320.00, '2023-01-20');
INSERT INTO a_b_testing VALUES (7, 2, 'A', 0.0410, 200.00, '2023-01-21');
INSERT INTO a_b_testing VALUES (8, 3, 'B', 0.0550, 280.00, '2023-01-22');
```

## Questions

1. **Calculate moving averages for sales data**
   - 3-month moving average for sales by employee
   - Rolling average with different window sizes

2. **Implement cohort analysis for employee retention**
   - Analyze retention by hire month cohorts
   - Calculate retention rates over time

3. **Create customer segmentation queries**
   - Segment customers by purchase behavior
   - RFM (Recency, Frequency, Monetary) analysis

4. **Calculate year-over-year growth rates**
   - Compare sales performance year-over-year
   - Calculate growth percentages by department

5. **Implement A/B testing analysis**
   - Compare conversion rates between variants
   - Statistical significance testing

6. **Create predictive analytics queries**
   - Predict employee retention likelihood
   - Forecast sales trends using historical data 