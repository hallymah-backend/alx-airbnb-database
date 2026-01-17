Query
EXPLAIN ANALYZE
SELECT u.user_id, COUNT(b.booking_id)
FROM users u
JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id;
Actual EXPLAIN ANALYZE Output
HashAggregate  (cost=2.23..2.28 rows=5 width=24) (actual time=0.149..0.152 rows=4 loops=1)
  Group Key: u.user_id
  Batches: 1  Memory Usage: 24kB
  ->  Hash Join  (cost=1.14..2.21 rows=5 width=32) (actual time=0.119..0.126 rows=5 loops=1)
        Hash Cond: (b.user_id = u.user_id)
        ->  Seq Scan on booking b  (cost=0.00..1.05 rows=5 width=32) (actual time=0.034..0.036 rows=5 loops=1)
        ->  Hash  (cost=1.06..1.06 rows=6 width=16) (actual time=0.051..0.052 rows=6 loops=1)
              Buckets: 1024  Batches: 1  Memory Usage: 9kB
              ->  Seq Scan on users u  (cost=0.00..1.06 rows=6 width=16) (actual time=0.025..0.028 rows=6 loops=1)
Planning Time: 10.426 ms
Execution Time: 0.349 ms
Interpretation

Both booking and users are scanned sequentially (Seq Scan) because the dataset is small.

PostgreSQL uses a Hash Join to efficiently combine tables.

HashAggregate computes the count per user.

On larger datasets, the indexes (idx_booking_user_id and idx_users_email) would enable Index Scans, reducing execution time significantly.

Execution time is already low for small tables (0.349 ms), but the indexes future-proof performance.

4. Conclusion

Adding indexes on high-usage columns improves query performance by:

Reducing full table scans on large datasets

Speeding up JOIN operations

Optimizing filtering and sorting

Even if the current dataset is small and Postgres uses Seq Scan, documenting the expected improvement demonstrates understanding of indexing benefits.