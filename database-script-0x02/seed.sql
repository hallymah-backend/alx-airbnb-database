BEGIN TRANSACTION;

-- Clear existing data (useful while re-seeding)
DELETE FROM Review;

DELETE FROM Payment;

DELETE FROM Booking;

DELETE FROM Property;

DELETE FROM users;

-- Insert users
INSERT INTO
  users (
    first_name,
    last_name,
    email,
    password_hash,
    phone_number,
    role
  )
VALUES
  (
    'Halimat',
    'Olakitan',
    'halimat@example.com',
    'hally',
    '+2347012345678',
    'guest'
  ),
  (
    'John',
    'Doe',
    'john.doe@example.com',
    'hello',
    '+12025550123',
    'host'
  ),
  (
    'Maria',
    'Garcia',
    'lymah@example.com',
    'mypass',
    '+1234567890',
    'guest'
  ),
  (
    'Aisha',
    'Bello',
    'aisha.bello@example.com',
    'mypass',
    '+2348098765432',
    'admin'
  ),
  (
    'Liam',
    'Smith',
    'liam.smith@example.com',
    'word',
    NULL,
    'guest'
  ),
  (
    'Chen',
    'Wang',
    'chen.wang@example.com',
    'ryyu',
    '+8613012345678',
    'host'
  );

-- Insert properties
INSERT INTO
  Property (
    host_id,
    name,
    description,
    location,
    pricepernight
  )
VALUES
  (
    (
      SELECT
        user_id
      FROM
        users
      WHERE
        first_name = 'Halimat'
    ),
    'Cozy Lagos Apartment',
    '1BR apartment near the beach',
    'Lagos',
    45.00
  ),
  (
    (
      SELECT
        user_id
      FROM
        users
      WHERE
        first_name = 'John'
    ),
    'Downtown Loft',
    'Spacious loft in downtown with fast Wi-Fi',
    'Abuja',
    80.00
  ),
  (
    (
      SELECT
        user_id
      FROM
        users
      WHERE
        first_name = 'Maria'
    ),
    'Family House with Garden',
    '3BR house perfect for families',
    'Lagos',
    120.00
  ),
  (
    (
      SELECT
        user_id
      FROM
        users
      WHERE
        first_name = 'Aisha'
    ),
    'Mountain Cabin',
    'Small wooden cabin with scenic views',
    'Jos',
    70.00
  );

-- -- Insert bookings
-- booking 1: John books the Cozy Lagos Appartment for 3 nights
INSERT INTO
  Booking (
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status
  )
VALUES
  (
    (
      SELECT
        property_id
      FROM
        Property
      WHERE
        name = 'Cozy Lagos Apartment'
    ),
    (
      SELECT
        user_id
      FROM
        users
      WHERE
        first_name = 'John'
    ),
    '2025-12-01',
    '2025-12-04',
    45.00 * 3,
    'confirmed'
  ),
  (
    (
      SELECT
        property_id
      FROM
        Property
      WHERE
        name = 'Family House with Garden'
    ),
    (
      SELECT
        user_id
      FROM
        users
      WHERE
        first_name = 'Maria'
    ),
    '2025-11-20',
    '2025-11-23',
    120.00 * 3,
    'pending'
  ),
  (
    (
      SELECT
        property_id
      FROM
        Property
      WHERE
        name = 'Downtown Loft'
    ),
    (
      SELECT
        user_id
      FROM
        users
      WHERE
        first_name = 'Liam'
    ),
    '2025-12-10',
    '2025-12-12',
    80.00 * 2,
    'confirmed'
  ),
  (
    (
      SELECT
        property_id
      FROM
        Property
      WHERE
        name = 'Mountain Cabin'
    ),
    (
      SELECT
        user_id
      FROM
        users
      WHERE
        first_name = 'John'
    ),
    '2025-12-20',
    '2025-12-22',
    70.00 * 2,
    'canceled'
  ),
  (
    (
      SELECT
        property_id
      FROM
        Property
      WHERE
        name = 'Cozy Lagos Apartment'
    ),
    (
      SELECT
        user_id
      FROM
        users
      WHERE
        first_name = 'Halimat'
    ),
    '2026-01-05',
    '2026-01-08',
    45.00 * 3,
    'pending'
  );

-- -- Insert payments for confirmed bookings
INSERT INTO
  Payment (booking_id, amount, payment_method)
VALUES
  (
    (
      SELECT
        booking_id
      FROM
        Booking
      WHERE
        status = 'confirmed'
      LIMIT
        1
    ),
    135.00,
    'credit_card'
  ),
  (
    (
      SELECT
        booking_id
      FROM
        Booking
      WHERE
        status = 'pending'
      LIMIT
        1
    ),
    160.00,
    'paypal'
  ),
  (
    (
      SELECT
        booking_id
      FROM
        Booking
      WHERE
        status = 'confirmed'
      LIMIT
        1
    ),
    180.00,
    'stripe'
  ),
  (
    (
      SELECT
        booking_id
      FROM
        Booking
      WHERE
        status = 'canceled'
      LIMIT
        1
    ),
    140.00,
    'credit_card'
  );

-- cancelled then refunded
-- Insert reviews
INSERT INTO Review (property_id, user_id, rating, comment)
VALUES
  (
    (SELECT property_id FROM Property WHERE name = 'Cozy Lagos Apartment'),
    (SELECT user_id FROM users WHERE first_name = 'John'),
    4,
    'Clean, great location and friendly host.'
  ),
  (
    (SELECT property_id FROM Property WHERE name = 'Family House with Garden'),
    (SELECT user_id FROM users WHERE first_name = 'Maria'),
    5,
    'Nice loft, a little noisy at night but overall good.'
  ),
  (
    (SELECT property_id FROM Property WHERE name = 'Downtown Loft'),
    (SELECT user_id FROM users WHERE first_name = 'Liam'),
    3,
    'Excellent house for our family - kids loved the garden.'
  ),
  (
    (SELECT property_id FROM Property WHERE name = 'Cozy Lagos Apartment'),
    (SELECT user_id FROM users WHERE first_name = 'Halimat'),
    1,
    'BAD EXPERIENCE, bad location.'
  );

COMMIT;