-- 1. Find available seats per flight
SELECT 
    f.flight_number,
    f.departure_airport,
    f.arrival_airport,
    f.departure_time,
    f.total_seats,
    COUNT(b.booking_id) as booked_seats,
    f.total_seats - COUNT(b.booking_id) as available_seats,
    ROUND((COUNT(b.booking_id) * 100.0 / f.total_seats), 2) as occupancy_percentage
FROM flights f
LEFT JOIN bookings b ON f.flight_id = b.flight_id AND b.booking_status = 'Confirmed'
GROUP BY f.flight_id, f.flight_number, f.departure_airport, f.arrival_airport, f.departure_time, f.total_seats
ORDER BY f.departure_time;

-- 2. Frequent travelers in last 6 months
SELECT 
    p.first_name,
    p.last_name,
    p.email,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.ticket_price) as total_spent,
    AVG(b.ticket_price) as avg_ticket_price,
    MAX(b.booking_date) as last_booking_date
FROM passengers p
JOIN bookings b ON p.passenger_id = b.passenger_id
WHERE b.booking_date >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
    AND b.booking_status = 'Confirmed'
GROUP BY p.passenger_id, p.first_name, p.last_name, p.email
ORDER BY total_bookings DESC, total_spent DESC;

-- 3. Top 3 routes by revenue
SELECT 
    CONCAT(f.departure_airport, ' → ', f.arrival_airport) as route,
    dep.city as departure_city,
    arr.city as arrival_city,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.ticket_price) as total_revenue,
    AVG(b.ticket_price) as avg_ticket_price,
    r.distance_miles,
    r.avg_flight_time_minutes
FROM flights f
JOIN bookings b ON f.flight_id = b.flight_id
JOIN airports dep ON f.departure_airport = dep.airport_code
JOIN airports arr ON f.arrival_airport = arr.airport_code
JOIN routes r ON f.departure_airport = r.departure_airport AND f.arrival_airport = r.arrival_airport
WHERE b.booking_status = 'Confirmed'
GROUP BY f.departure_airport, f.arrival_airport, dep.city, arr.city, r.distance_miles, r.avg_flight_time_minutes
ORDER BY total_revenue DESC
LIMIT 3;

-- 4. Monthly booking trends
SELECT 
    YEAR(b.booking_date) as booking_year,
    MONTH(b.booking_date) as booking_month,
    DATE_FORMAT(b.booking_date, '%Y-%m') as year_month,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.ticket_price) as total_revenue,
    AVG(b.ticket_price) as avg_ticket_price,
    COUNT(DISTINCT b.passenger_id) as unique_passengers
FROM bookings b
WHERE b.booking_status = 'Confirmed'
GROUP BY YEAR(b.booking_date), MONTH(b.booking_date), DATE_FORMAT(b.booking_date, '%Y-%m')
ORDER BY booking_year, booking_month;

-- 5. Top 5 customers by ticket volume
SELECT 
    p.first_name,
    p.last_name,
    p.email,
    COUNT(b.booking_id) as total_tickets,
    SUM(b.ticket_price) as total_spent,
    AVG(b.ticket_price) as avg_ticket_price,
    MIN(b.booking_date) as first_booking,
    MAX(b.booking_date) as last_booking,
    DATEDIFF(MAX(b.booking_date), MIN(b.booking_date)) as days_between_bookings
FROM passengers p
JOIN bookings b ON p.passenger_id = b.passenger_id
WHERE b.booking_status = 'Confirmed'
GROUP BY p.passenger_id, p.first_name, p.last_name, p.email
ORDER BY total_tickets DESC, total_spent DESC
LIMIT 5;

-- 6. Flight occupancy analysis
SELECT 
    f.airline_code,
    f.aircraft_type,
    COUNT(f.flight_id) as total_flights,
    SUM(f.total_seats) as total_capacity,
    SUM(COUNT(b.booking_id)) OVER (PARTITION BY f.airline_code) as total_bookings,
    ROUND(
        SUM(COUNT(b.booking_id)) OVER (PARTITION BY f.airline_code) * 100.0 / SUM(f.total_seats), 
        2
    ) as overall_occupancy_rate,
    AVG(f.base_price) as avg_base_price,
    AVG(b.ticket_price) as avg_actual_price
FROM flights f
LEFT JOIN bookings b ON f.flight_id = b.flight_id AND b.booking_status = 'Confirmed'
GROUP BY f.airline_code, f.aircraft_type
ORDER BY overall_occupancy_rate DESC; 