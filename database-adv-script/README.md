# Joins Queries - ALX Airbnb Database Project

This file contains SQL queries that demonstrate the use of different types of **joins** in PostgreSQL for the Airbnb database project.

## Queries Included

1. **INNER JOIN**
   - Retrieves all bookings along with the users who made them.
   - Only includes bookings that have a valid user.

2. **LEFT JOIN**
   - Retrieves all properties along with their reviews.
   - Includes properties that do **not** have any reviews (reviews show as NULL).

3. **FULL OUTER JOIN**
   - Retrieves all users and all bookings.
   - Includes users with no bookings and bookings without users.

## Usage

Run the queries in your PostgreSQL terminal:

```bash
psql -U postgres -d airbnb_db -f joins_queries.sql
