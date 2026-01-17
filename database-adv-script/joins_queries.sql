-- SELECT users.user_id, users.email
--    FROM users 
--    INNER JOIN Property
--    ON users.user_id = property.host_id;
-- --    WHERE LOWER(last_name) = LOWER('olakitan')
-- -- ORDER BY  email DESC;
-- INNER JOIN
SELECT
    users.first_name || ' ' || users.last_name AS "Guest Name",
    users.email AS "Guest Email",
    users.user_id AS "Guest Identifier",
    booking.booking_id AS "Booking Identifier",
    booking.property_id AS "Property Identifier",
    booking.start_date AS "Start Date",
    booking.end_date AS "End Date",
    booking.total_price AS "Total Price",
    booking.status AS "Status"
FROM
    users
    INNER JOIN booking ON booking.user_id = users.user_id;

-- LEFT JOIN
SELECT
    property.name AS "Property Name",
    property.location AS "Location",
    property.pricepernight AS "Price per Night",
    property.description AS "Description",
    review.rating AS "Property Rating",
    review.comment AS "Review Comment"
FROM
    property
    left JOIN review ON review.property_id = property.property_id;

-- OUTER JOIN
SELECT
    users.first_name || ' ' || users.last_name AS "Guest Name",
    users.email AS "Guest Email",
    booking.property_id,
    booking.start_date,
    booking.end_date
FROM
    users
    FULL OUTER JOIN booking ON users.user_id = booking.user_id;