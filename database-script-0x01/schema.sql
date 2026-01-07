-- USER TABLE
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(25) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) CHECK (role IN ('guest', 'host', 'admin')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

- -- PROPERTY TABLE
CREATE TABLE Property (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES users(user_id)
);

CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);

-- -- BOOKING TABLE
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pending', 'confirmed', 'canceled')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
--     FOREIGN KEY (property_id) REFERENCES Property(property_id),
--     FOREIGN KEY (user_id) REFERENCES users(user_id)
-- );

-- CREATE INDEX idx_booking_property_id ON Booking(property_id);
-- CREATE INDEX idx_booking_user_id ON Booking(user_id);
-- CREATE INDEX idx_booking_status ON Booking(status);

-- -- PAYMENT TABLE
-- CREATE TABLE Payment (
--     payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--     booking_id UUID NOT NULL,
--     amount DECIMAL(10, 2) NOT NULL,
--     payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     payment_method VARCHAR(50) CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')) NOT NULL,
--     FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
-- );

-- CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

-- -- REVIEW TABLE
-- CREATE TABLE Review (
--     review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--     property_id UUID NOT NULL,
--     user_id UUID NOT NULL,
--     rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
--     comment TEXT NOT NULL,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (property_id) REFERENCES Property(property_id),
--     FOREIGN KEY (user_id) REFERENCES users(user_id)
-- );

-- CREATE INDEX idx_review_property_id ON Review(property_id);
-- CREATE INDEX idx_review_user_id ON Review(user_id);

-- -- MESSAGE TABLE
-- CREATE TABLE Message (
--     message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--     sender_id UUID NOT NULL,
--     recipient_id UUID NOT NULL,
--     message_body TEXT NOT NULL,
--     sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (sender_id) REFERENCES users(user_id),
--     FOREIGN KEY (recipient_id) REFERENCES users(user_id)
-- );

-- CREATE INDEX idx_message_sender_id ON Message(sender_id);
-- CREATE INDEX idx_message_recipient_id ON Message(recipient_id);
