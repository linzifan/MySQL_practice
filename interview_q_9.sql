# table 1: user_id, age (int), city (var)
# table 2: user_id, yyyymmdd (date, number), GMV (order amount, number)

USE test;

CREATE TABLE t1 (
user_id INT,
Age INT,
City varchar(32),
PRIMARY KEY (user_id)
);

CREATE TABLE t2 (
user_id INT,
yyyymmdd INT,
GMV INT
);

INSERT INTO t1 VALUES (001, 30, 'Guangzhou');
INSERT INTO t1 VALUES (002, 15, 'Guangzhou');
INSERT INTO t1 VALUES (003, 20, 'Shenzhen');
INSERT INTO t1 VALUES (004, 15, 'Shenzhen');
INSERT INTO t1 VALUES (005, 16, 'Shenzhen');
INSERT INTO t1 VALUES (006, 25, 'shenzhen');
INSERT INTO t1 VALUES (007, 32, 'Hangzhou');
INSERT INTO t1 VALUES (008, 14, 'Hangzhou');
INSERT INTO t1 VALUES (009, 38, 'Hangzhou');
INSERT INTO t1 VALUES (010, 20, 'Guangzhou');

INSERT INTO t2 VALUES (001, 20131105, 200);
INSERT INTO t2 VALUES (001, 20131205, 100);
INSERT INTO t2 VALUES (001, 20131203, 400);
INSERT INTO t2 VALUES (002, 20131105, 200);
INSERT INTO t2 VALUES (002, 20131205, 100);
INSERT INTO t2 VALUES (003, 20131203, 400);
INSERT INTO t2 VALUES (003, 20131105, 200);
INSERT INTO t2 VALUES (004, 20131205, 100);
INSERT INTO t2 VALUES (005, 20131203, 400);
INSERT INTO t2 VALUES (005, 20131105, 200);
INSERT INTO t2 VALUES (005, 20131205, 100);
INSERT INTO t2 VALUES (006, 20131203, 400);
INSERT INTO t2 VALUES (006, 20131105, 200);
INSERT INTO t2 VALUES (007, 20131205, 100);
INSERT INTO t2 VALUES (008, 20131203, 400);
INSERT INTO t2 VALUES (009, 20131105, 200);
INSERT INTO t2 VALUES (009, 20131205, 100);
INSERT INTO t2 VALUES (009, 20141205, 100);
INSERT INTO t2 VALUES (009, 20141205, 100);
INSERT INTO t2 VALUES (010, 20131205, 100);

# create new table t3, connect t1, t2 using user_id
# table 3: user_id, age, city, gmv_1312
# city includes "guangzhou", "shenzhen"
# age >= 16
# sum(GMV) on 2013.12
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 AS
SELECT t1.user_id, Age, City, SUM(GMV) FROM t1, t2 WHERE t1.user_id = t2.user_id and
(City = 'Guangzhou' or City = 'Shenzhen') and Age >= 16 and FLOOR(yyyymmdd / 100) = 201312
GROUP BY t1.user_id;

SELECT * FROM t2
WHERE FLOOR(yyyymmdd / 100) = 201312;

# case insensitive

# Result:
SELECT * FROM t3;






















