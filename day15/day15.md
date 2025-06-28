# Day 15: String Functions

## 🧱 Schema Creation

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    department VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    description TEXT
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    address TEXT
);
```

## 📥 Sample Data

```sql
INSERT INTO employees (employee_id, full_name, email, phone, department) VALUES
(101, 'Alice Johnson', 'alice.johnson@company.com', '555-0101', 'IT'),
(102, 'Bob Smith', 'bob.smith@company.com', '555-0102', 'HR'),
(103, 'Charlie Brown', 'charlie.brown@company.com', '555-0103', 'Sales'),
(104, 'David Wilson', 'david.wilson@company.com', '555-0104', 'IT'),
(105, 'Eva Davis', 'eva.davis@company.com', '555-0105', 'Marketing'),
(106, 'Frank Miller', 'frank.miller@company.com', '555-0106', 'HR');

INSERT INTO products (product_id, product_name, category, description) VALUES
(1, 'Laptop Pro', 'Electronics', 'High-performance laptop for professionals'),
(2, 'Office Chair', 'Furniture', 'Ergonomic office chair with lumbar support'),
(3, 'Coffee Maker', 'Appliances', 'Automatic coffee maker with timer'),
(4, 'Desk Lamp', 'Furniture', 'LED desk lamp with adjustable brightness'),
(5, 'Smartphone X', 'Electronics', 'Latest smartphone with advanced features'),
(6, 'Standing Desk', 'Furniture', 'Adjustable standing desk for better posture');

INSERT INTO customers (customer_id, customer_name, email, address) VALUES
(1, 'John Smith', 'john.smith@email.com', '123 Main St, New York, NY 10001'),
(2, 'Maria Garcia', 'maria.garcia@email.com', '456 Oak Ave, Los Angeles, CA 90210'),
(3, 'David Wilson', 'david.wilson@email.com', '789 Pine Rd, Chicago, IL 60601'),
(4, 'Anna Mueller', 'anna.mueller@email.com', '321 Elm St, Boston, MA 02101'),
(5, 'Carlos Rodriguez', 'carlos.rodriguez@email.com', '654 Maple Dr, Miami, FL 33101');
```

## 📌 Questions

1. Split full name to first & last name
2. Extract domain from email
3. Pad employee IDs with zeros
4. Find products with 'Pro' in the name
5. Extract first word from product descriptions
6. Format phone numbers consistently 