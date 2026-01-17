Performance Monitoring Report
Tools Used

PostgreSQL query performance was monitored using EXPLAIN ANALYZE.

EXPLAIN ANALYZE
SELECT *
FROM booking_partitioned
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30';

                       QUERY PLAN   

 Bitmap Heap Scan on booking_2024 booking_partitioned  (cost=7.75..13.09 rows=2 width=198) (actual time=0.034..0.034 rows=0 loops=1)
   Recheck Cond: ((start_date >= '2024-06-01'::date) AND (start_date <= '2024-06-30'::date))
   ->  Bitmap Index Scan on booking_2024_pkey  (cost=0.00..7.75 rows=2 width=0) (actual time=0.008..0.008 rows=0 loops=1)
         Index Cond: ((start_date >= '2024-06-01'::date) AND (start_date <= '2024-06-30'::date))
 Planning Time: 0.341 ms
 Execution Time: 0.083 ms
(6 rows)



EXPLAIN ANALYZE
SELECT b.booking_id, u.first_name, p.name 
FROM booking_partitioned b
JOIN users u ON b.user_id = u.user_id
JOIN property p ON b.property_id = p.property_id 
WHERE b.start_date >= '2024-01-01';
                                                QUERY PLAN
-----------------------------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=2.23..48.51 rows=1 width=452) (actual time=0.129..0.135 rows=0 loops=1)
   Hash Cond: (b.user_id = u.user_id)
   ->  Hash Join  (cost=1.09..47.36 rows=7 width=350) (actual time=0.050..0.055 rows=0 loops=1)
         Hash Cond: (b.property_id = p.property_id)
         ->  Append  (cost=0.00..45.30 rows=360 width=48) (actual time=0.049..0.050 rows=0 loops=1)
               ->  Seq Scan on booking_2024 b_1  (cost=0.00..14.50 rows=120 width=48) (actual time=0.015..0.016 rows=0 loops=1)
                     Filter: (start_date >= '2024-01-01'::date)
               ->  Seq Scan on booking_2025 b_2  (cost=0.00..14.50 rows=120 width=48) (actual time=0.011..0.011 rows=0 loops=1)
                     Filter: (start_date >= '2024-01-01'::date)
ime=0.021..0.021 rows=0 loops=1)
                     Filter: (start_date >= '2024-01-01'::date)
         ->  Hash  (cost=1.04..1.04 rows=4 width=334) (never executed)
               ->  Seq Scan on property p  (cost=0.00..1.04 rows=4 width=334) (never executed)
   ->  Hash  (cost=1.06..1.06 rows=6 width=134) (actual time=0.048..0.048 rows=6 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
 Planning Time: 3.607 ms
 Execution Time: 0.769 ms



Conclusion

Continuous monitoring with EXPLAIN ANALYZE helped identify performance bottlenecks. Partitioning improved date-based queries, while additional indexes optimized join performance. Regular execution plan analysis ensures sustained database efficiency as data grows.