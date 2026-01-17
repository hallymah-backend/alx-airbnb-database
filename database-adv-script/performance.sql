-- performance.sql

-- Step 1: Analyze the query before optimization
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    u.user_id,
    u.first_name || ' ' || u.last_name AS user_name,
    u.email AS user_email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method
FROM
    booking b
    JOIN users u ON b.user_id = u.user_id
    JOIN property p ON b.property_id = p.property_id
    LEFT JOIN payment pay ON b.booking_id = pay.booking_id;
