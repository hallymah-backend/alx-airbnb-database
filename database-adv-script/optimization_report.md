# Query Optimization Report

## Overview
This report analyzes the performance of a query that retrieves booking records along with
associated user, property, and payment details. The PostgreSQL `EXPLAIN` command was used
to inspect the execution plan and identify potential inefficiencies.

---

## Initial Query Plan Analysis

### Query Plan Summary

---

## Identified Inefficiencies

1. **Sequential Scans on Multiple Tables**
   - `payment`, `booking`, `users`, and `property` are all accessed using
     **Seq Scan**.
   - Sequential scans are inefficient as table sizes grow and indicate
     missing or unused indexes.

2. **Large Row Width**
   - The final join produces rows with a width of **1390 bytes**, meaning
     more data is being retrieved than necessary.
   - This increases memory usage and slows down execution.

3. **High Estimated Rows on Payment Table**
   - The `payment` table processes **400 rows**, significantly more than
     other tables.
   - Joining it early increases the cost of the overall query.

---

## Optimization Strategy

### 1. Indexing Foreign Keys
Indexes were added to frequently joined columns to replace sequential scans
with index scans:

```sql
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_payment_booking_id ON payment(booking_id);
