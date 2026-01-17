-- Users table
CREATE INDEX IF NOT EXISTS idx_users_email
ON users(email);

-- Booking table
CREATE INDEX IF NOT EXISTS idx_booking_user_id
ON booking(user_id);

CREATE INDEX IF NOT EXISTS idx_booking_property_id
ON booking(property_id);

CREATE INDEX IF NOT EXISTS idx_booking_created_at
ON booking(created_at);

-- Property table
CREATE INDEX IF NOT EXISTS idx_property_host_id
ON property(host_id);

CREATE INDEX IF NOT EXISTS idx_property_location
ON property(location);
CREATE INDEX IF NOT EXISTS idx_property_pricepernight
ON property(pricepernight);