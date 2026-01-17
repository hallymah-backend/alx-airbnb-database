
### Performance Improvement Report

After implementing **range partitioning** on the `booking` table using the `start_date` column, query performance improved significantly for date-based queries. Performance testing with `EXPLAIN` showed that PostgreSQL applied **partition pruning**, scanning only the relevant partition (`booking_2024`) instead of the entire dataset.

Additionally, the query planner utilized a **bitmap index scan** on the partition’s primary key, avoiding a full sequential scan. This reduced the amount of data scanned and improved execution efficiency. Overall, partitioning minimized unnecessary I/O operations and optimized query execution for large booking datasets filtered by date range.
