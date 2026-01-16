SELECT
    u.user_id,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN booking b
    ON u.user_id = b.user_id
GROUP BY u.user_id
ORDER BY total_bookings DESC;
