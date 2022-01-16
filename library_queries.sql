Time Consumed: 2 hours.
Please Import:- 
----------------------------------------------
psql -Upostgres -c 'create database library;'
psql -Upostgres library < ./library.sql
----------------------------------------------



Produce queries to answer the following questions:-
- Find author by name "Leo"
select * from authors where name LIKE '%Leo';

QUERY PLAN                                              
-----------------------------------------------------------------------------------------------------
 Seq Scan on authors  (cost=0.00..10.88 rows=1 width=1036) (actual time=0.029..0.030 rows=0 loops=1)
   Filter: ((name)::text ~~ '%Leo'::text)
   Rows Removed by Filter: 7
 Planning Time: 0.150 ms
 Execution Time: 0.064 ms
(5 rows)
 
- Find books of author "Fitzgerald"
select b.name from books b inner join authors a on b.author_id = a.id and a.name like '%Fitzgerald';
 
QUERY PLAN                                                   
----------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=10.89..27.36 rows=7 width=118) (actual time=0.186..0.192 rows=2 loops=1)
   Hash Cond: (b.author_id = a.id)
   ->  Seq Scan on books b  (cost=0.00..15.10 rows=510 width=122) (actual time=0.018..0.021 rows=9 loops=1)
   ->  Hash  (cost=10.88..10.88 rows=1 width=4) (actual time=0.065..0.066 rows=1 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
         ->  Seq Scan on authors a  (cost=0.00..10.88 rows=1 width=4) (actual time=0.024..0.028 rows=1 loops=1)
               Filter: ((name)::text ~~ '%Fitzgerald'::text)
               Rows Removed by Filter: 6
 Planning Time: 0.980 ms
 Execution Time: 0.276 ms
(10 rows)


- Find authors without books:
select * from authors a left join books b on  b.author_id = a.id where b.author_id is null;

QUERY PLAN                                                    
------------------------------------------------------------------------------------------------------------------
 Hash Anti Join  (cost=21.48..33.45 rows=35 width=1166) (actual time=0.080..0.087 rows=2 loops=1)
   Hash Cond: (a.id = b.author_id)
   ->  Seq Scan on authors a  (cost=0.00..10.70 rows=70 width=1036) (actual time=0.017..0.021 rows=7 loops=1)
   ->  Hash  (cost=15.10..15.10 rows=510 width=130) (actual time=0.036..0.037 rows=9 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
         ->  Seq Scan on books b  (cost=0.00..15.10 rows=510 width=130) (actual time=0.008..0.012 rows=9 loops=1)
 Planning Time: 0.270 ms
 Execution Time: 0.150 ms
(8 rows)


- Count books per country:
select count(b.id),a.country from books b inner join authors a on b.author_id = a.id  group by (country);

QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
HashAggregate  (cost=30.60..31.30 rows=70 width=1040) (actual time=0.132..0.136 rows=4 loops=1)
   Group Key: a.country
   ->  Hash Join  (cost=11.57..28.05 rows=510 width=520) (actual time=0.096..0.109 rows=9 loops=1)
         Hash Cond: (b.author_id = a.id)
         ->  Seq Scan on books b  (cost=0.00..15.10 rows=510 width=8) (actual time=0.018..0.021 rows=9 loops=1)
         ->  Hash  (cost=10.70..10.70 rows=70 width=520) (actual time=0.037..0.038 rows=7 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Seq Scan on authors a  (cost=0.00..10.70 rows=70 width=520) (actual time=0.011..0.016 rows=7 loops=1)
 Planning Time: 0.310 ms
 Execution Time: 0.233 ms
(10 rows)


5 - Count average book length (in pages) per author:
select avg(b.pages) ,a.name from books b inner join authors a on b.author_id = a.id  group by (a.id);

QUERY PLAN before index                                                         
-------------------------------------------------------------------------------------------------------------------------
HashAggregate  (cost=30.60..31.47 rows=70 width=552) (actual time=0.177..0.194 rows=5 loops=1)
   Group Key: a.id
   ->  Hash Join  (cost=11.57..28.05 rows=510 width=524) (actual time=0.104..0.135 rows=9 loops=1)
         Hash Cond: (b.author_id = a.id)
         ->  Seq Scan on books b  (cost=0.00..15.10 rows=510 width=8) (actual time=0.015..0.022 rows=9 loops=1)
         ->  Hash  (cost=10.70..10.70 rows=70 width=520) (actual time=0.053..0.054 rows=7 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Seq Scan on authors a  (cost=0.00..10.70 rows=70 width=520) (actual time=0.011..0.034 rows=7 loops=1)
 Planning Time: 0.296 ms
 Execution Time: 0.301 ms
(10 rows)

QUERY PLAN after index                                                         
-------------------------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=2.33..2.41 rows=7 width=552) (actual time=0.059..0.065 rows=5 loops=1)
   Group Key: a.id
   ->  Hash Join  (cost=1.16..2.28 rows=9 width=524) (actual time=0.034..0.042 rows=9 loops=1)
         Hash Cond: (b.author_id = a.id)
         ->  Seq Scan on books b  (cost=0.00..1.09 rows=9 width=8) (actual time=0.009..0.011 rows=9 loops=1)
         ->  Hash  (cost=1.07..1.07 rows=7 width=520) (actual time=0.016..0.016 rows=7 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Seq Scan on authors a  (cost=0.00..1.07 rows=7 width=520) (actual time=0.006..0.009 rows=7 loops=1)
 Planning Time: 0.238 ms
 Execution Time: 0.126 ms
(10 rows)


Analyze and explain the time complexity of the queries:-
- I added index to author(id,name), books(id, name,author_id) it makes noticable deffiernace on quer plans i added for query 5 the differance.
- I searched string using only % in start and this minimized the scanned rows.
