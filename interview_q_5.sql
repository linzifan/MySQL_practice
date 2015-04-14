USE test;

DROP TABLE IF EXISTS gender;

CREATE TABLE gender(
  Id INT,
  Name VARCHAR(8),
  Sex VARCHAR(8),
  Salary INT
);

INSERT INTO gender VALUES (1, 'A', 'm', 2500);
INSERT INTO gender VALUES (2, 'B', 'f', 1500);
INSERT INTO gender VALUES (3, 'C', 'm', 5500);
INSERT INTO gender VALUES (4, 'D', 'f', 500);

SELECT * FROM gender;

# Question: Swap all f and m values with a single update query and no intermediate temp table
SET SQL_SAFE_UPDATES = 0;
UPDATE gender SET Sex = CASE Sex WHEN 'm' THEN 'f' ELSE 'm' END ;
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM gender;
