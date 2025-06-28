-- 1. Split full name to first & last name
SELECT 
    full_name,
    SUBSTRING_INDEX(full_name, ' ', 1) as first_name,
    SUBSTRING_INDEX(full_name, ' ', -1) as last_name
FROM employees;

-- 2. Extract domain from email
SELECT 
    email,
    SUBSTRING_INDEX(email, '@', -1) as domain
FROM employees;

-- 3. Pad employee IDs with zeros
SELECT 
    LPAD(employee_id, 5, '0') as padded_id,
    full_name
FROM employees;

-- 4. Find products with 'Pro' in the name
SELECT 
    product_id,
    product_name,
    category
FROM products
WHERE product_name LIKE '%Pro%';

-- 5. Extract first word from product descriptions
SELECT 
    product_name,
    description,
    SUBSTRING_INDEX(description, ' ', 1) as first_word
FROM products;

-- 6. Format phone numbers consistently
SELECT 
    full_name,
    phone,
    CONCAT('(', SUBSTRING(phone, 1, 3), ') ', SUBSTRING(phone, 5, 3), '-', SUBSTRING(phone, 9, 4)) as formatted_phone
FROM employees; 