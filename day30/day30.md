# Day 30: Capstone Project – Flight Booking System

## 🧱 Schema Creation

```sql
CREATE TABLE flights (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(10),
    departure_airport VARCHAR(10),
    arrival_airport VARCHAR(10),
    departure_time DATETIME,
    arrival_time DATETIME,
    aircraft_type VARCHAR(50),
    total_seats INT,
    base_price DECIMAL(10,2),
    airline_code VARCHAR(5)
);

CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    date_of_birth DATE,
    passport_number VARCHAR(20),
    registration_date DATE
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    booking_date DATETIME,
    seat_number VARCHAR(10),
    ticket_price DECIMAL(10,2),
    booking_status VARCHAR(20),
    payment_status VARCHAR(20),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    booking_id INT,
    ticket_number VARCHAR(20),
    issue_date DATETIME,
    ticket_status VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

CREATE TABLE airports (
    airport_code VARCHAR(10) PRIMARY KEY,
    airport_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    timezone VARCHAR(10)
);

CREATE TABLE routes (
    route_id INT PRIMARY KEY,
    departure_airport VARCHAR(10),
    arrival_airport VARCHAR(10),
    distance_miles INT,
    avg_flight_time_minutes INT,
    FOREIGN KEY (departure_airport) REFERENCES airports(airport_code),
    FOREIGN KEY (arrival_airport) REFERENCES airports(airport_code)
);
```

## 📥 Sample Data

```sql
INSERT INTO airports (airport_code, airport_name, city, country, timezone) VALUES
('JFK', 'John F. Kennedy International Airport', 'New York', 'USA', 'EST'),
('LAX', 'Los Angeles International Airport', 'Los Angeles', 'USA', 'PST'),
('LHR', 'London Heathrow Airport', 'London', 'UK', 'GMT'),
('CDG', 'Charles de Gaulle Airport', 'Paris', 'France', 'CET'),
('NRT', 'Narita International Airport', 'Tokyo', 'Japan', 'JST'),
('SYD', 'Sydney Airport', 'Sydney', 'Australia', 'AEST');

INSERT INTO flights (flight_id, flight_number, departure_airport, arrival_airport, departure_time, arrival_time, aircraft_type, total_seats, base_price, airline_code) VALUES
(1, 'AA101', 'JFK', 'LAX', '2024-01-15 08:00:00', '2024-01-15 11:30:00', 'Boeing 737', 180, 450.00, 'AA'),
(2, 'BA202', 'LHR', 'CDG', '2024-01-15 10:30:00', '2024-01-15 13:45:00', 'Airbus A320', 150, 320.00, 'BA'),
(3, 'JL303', 'NRT', 'SYD', '2024-01-15 14:00:00', '2024-01-15 23:30:00', 'Boeing 787', 250, 1200.00, 'JL'),
(4, 'AA104', 'LAX', 'JFK', '2024-01-16 09:00:00', '2024-01-16 17:30:00', 'Boeing 737', 180, 480.00, 'AA'),
(5, 'BA205', 'CDG', 'LHR', '2024-01-16 16:00:00', '2024-01-16 17:15:00', 'Airbus A320', 150, 280.00, 'BA'),
(6, 'JL306', 'SYD', 'NRT', '2024-01-16 08:30:00', '2024-01-16 18:00:00', 'Boeing 787', 250, 1100.00, 'JL'),
(7, 'AA107', 'JFK', 'LHR', '2024-01-17 19:00:00', '2024-01-18 07:30:00', 'Boeing 777', 300, 850.00, 'AA'),
(8, 'BA208', 'LHR', 'JFK', '2024-01-18 10:00:00', '2024-01-18 13:30:00', 'Boeing 777', 300, 900.00, 'BA');

INSERT INTO passengers (passenger_id, first_name, last_name, email, phone, date_of_birth, passport_number, registration_date) VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '555-0101', '1985-03-15', 'US123456789', '2023-01-10'),
(2, 'Maria', 'Garcia', 'maria.garcia@email.com', '555-0102', '1990-07-22', 'ES987654321', '2023-02-15'),
(3, 'David', 'Wilson', 'david.wilson@email.com', '555-0103', '1988-11-08', 'UK456789123', '2023-03-20'),
(4, 'Anna', 'Mueller', 'anna.mueller@email.com', '555-0104', '1992-05-12', 'DE789123456', '2023-04-05'),
(5, 'Carlos', 'Rodriguez', 'carlos.rodriguez@email.com', '555-0105', '1987-09-30', 'MX321654987', '2023-05-12'),
(6, 'Sarah', 'Johnson', 'sarah.johnson@email.com', '555-0106', '1995-12-03', 'CA147258369', '2023-06-18');

INSERT INTO bookings (booking_id, passenger_id, flight_id, booking_date, seat_number, ticket_price, booking_status, payment_status) VALUES
(1, 1, 1, '2024-01-10 14:30:00', '12A', 450.00, 'Confirmed', 'Paid'),
(2, 2, 2, '2024-01-11 09:15:00', '8B', 320.00, 'Confirmed', 'Paid'),
(3, 3, 3, '2024-01-12 16:45:00', '15C', 1200.00, 'Confirmed', 'Paid'),
(4, 4, 4, '2024-01-13 11:20:00', '22D', 480.00, 'Confirmed', 'Paid'),
(5, 5, 5, '2024-01-14 13:10:00', '5A', 280.00, 'Confirmed', 'Paid'),
(6, 6, 6, '2024-01-15 10:30:00', '18B', 1100.00, 'Confirmed', 'Paid'),
(7, 1, 7, '2024-01-16 08:45:00', '30C', 850.00, 'Confirmed', 'Paid'),
(8, 2, 8, '2024-01-17 12:20:00', '12D', 900.00, 'Confirmed', 'Paid'),
(9, 3, 1, '2024-01-18 15:30:00', '25A', 460.00, 'Confirmed', 'Paid'),
(10, 4, 2, '2024-01-19 14:15:00', '7B', 330.00, 'Confirmed', 'Paid');

INSERT INTO tickets (ticket_id, booking_id, ticket_number, issue_date, ticket_status) VALUES
(1, 1, 'TKT001234567', '2024-01-10 14:35:00', 'Issued'),
(2, 2, 'TKT002345678', '2024-01-11 09:20:00', 'Issued'),
(3, 3, 'TKT003456789', '2024-01-12 16:50:00', 'Issued'),
(4, 4, 'TKT004567890', '2024-01-13 11:25:00', 'Issued'),
(5, 5, 'TKT005678901', '2024-01-14 13:15:00', 'Issued'),
(6, 6, 'TKT006789012', '2024-01-15 10:35:00', 'Issued'),
(7, 7, 'TKT007890123', '2024-01-16 08:50:00', 'Issued'),
(8, 8, 'TKT008901234', '2024-01-17 12:25:00', 'Issued'),
(9, 9, 'TKT009012345', '2024-01-18 15:35:00', 'Issued'),
(10, 10, 'TKT010123456', '2024-01-19 14:20:00', 'Issued');

INSERT INTO routes (route_id, departure_airport, arrival_airport, distance_miles, avg_flight_time_minutes) VALUES
(1, 'JFK', 'LAX', 2789, 330),
(2, 'LHR', 'CDG', 214, 75),
(3, 'NRT', 'SYD', 4862, 570),
(4, 'LAX', 'JFK', 2789, 330),
(5, 'CDG', 'LHR', 214, 75),
(6, 'SYD', 'NRT', 4862, 570),
(7, 'JFK', 'LHR', 3451, 420),
(8, 'LHR', 'JFK', 3451, 420);
```

## 📌 Questions

1. Find available seats per flight
2. Frequent travelers in last 6 months
3. Top 3 routes by revenue
4. Monthly booking trends
5. Top 5 customers by ticket volume
6. Flight occupancy analysis 