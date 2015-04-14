USE test;

DROP TABLE IF EXISTS runners;

CREATE TABLE runners(
  id int,
  name varchar(32)
);

INSERT INTO runners VALUES (1, "John Doe");
INSERT INTO runners VALUES (2, "John Doe");
INSERT INTO runners VALUES (3, "Alice Jones");
INSERT INTO runners VALUES (4, "Bobby Louis");
INSERT INTO runners VALUES (5, "Lisa Remero");

CREATE TABLE races(
  id int,
  event varchar(32),
  winner_id int
);

INSERT INTO races VALUES (1, "100 meter dash", 2);
INSERT INTO races VALUES (2, "500 meter dash", 3);
INSERT INTO races VALUES (3, "cross-country", 2);
INSERT INTO races VALUES (4, "triathalon", NULL);

SELECT Count(*) FROM races;

SELECT * FROM runners WHERE id NOT IN (SELECT winner_id FROM races);


# Surprisingly, given the sample data provided, the result of this query will be an empty set. 
# The reason for this is as follows: If the set being evaluated by the SQL NOT IN condition 
# contains any values that are null, then the outer query here will return an empty set, even 
# if there are many runner ids that match winner_ids in the races table.
SELECT * FROM runners WHERE id NOT IN (SELECT winner_id FROM races WHERE winner_id IS NOT NULL);

  
  
SELECT case when null = null then 'Yup' else 'Nope' end as Result;
SELECT case when null IS null then 'Yup' else 'Nope' end as Result;
# The proper way to compare a value to NULL in SQL is with the `is` operator
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
