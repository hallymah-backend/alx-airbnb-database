-- perfomance.sql
WITH
    booking AS (
        SELECT
            booking.booking_id,
            booking.start_date,
            booking.end_date,
            users.user_id,
            users.first_name || ' ' || users.last_name AS user_name,
            users.email AS user_email,
            property.property_id,
            property.name AS property_name,
            property.location AS property_location
        FROM
            booking booking
            JOIN users users ON booking.user_id = users.user_id
            JOIN property property ON booking.property_id = property.property_id
    )
SELECT
    booking.*,
    payment.payment_id,
    payment.amount AS payment_amount,
    payment.payment_method AS payment_method
FROM
    booking
    LEFT JOIN payment payment ON booking.booking_id = payment.booking_id;