SELECT
    users.user_id,
    COUNT(b.booking_id) AS total_bookings
FROM users users
LEFT JOIN booking b
    ON users.user_id = b.user_id
GROUP BY users.user_id
ORDER BY total_bookings DESC;

SELECT
    property_id,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_number_rank
FROM (
    SELECT
        property_id,
        COUNT(booking_id) AS total_bookings
    FROM booking
    GROUP BY property_id
) AS property_counts;


SELECT
    property_id,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS property_rank
FROM (
    SELECT
        property_id,
        COUNT(booking_id) AS total_bookings
    FROM booking
    GROUP BY property_id
) AS property_counts;

