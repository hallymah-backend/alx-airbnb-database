-- Step 1: Create partitioned booking table (NO rename, safe)
CREATE TABLE booking_partitioned (
    booking_id UUID NOT NULL,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price NUMERIC(10, 2),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Step 2: Create yearly partitions

CREATE TABLE booking_2023 PARTITION OF booking_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_2024 PARTITION OF booking_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF booking_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Optional default partition
CREATE TABLE booking_default PARTITION OF booking_partitioned
DEFAULT;
