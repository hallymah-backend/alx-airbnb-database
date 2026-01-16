SELECT
    u.user_id,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN booking b
    ON u.user_id = b.user_id
GROUP BY u.user_id
ORDER BY total_bookings DESC;


SELECT
    p.property_id,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM property p
LEFT JOIN booking b
    ON p.property_id = b.property_id
GROUP BY p.property_id;
