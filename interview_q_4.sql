USE test;

DROP TABLE IF EXISTS game;

CREATE TABLE game(
  team1 VARCHAR(32),
  team2 VARCHAR(32),
  start TIMESTAMP,
  end TIMESTAMP
);

INSERT INTO game VALUES ("argentina", "brazil", now(), now());
SELECT * FROM game;

# 'argentina','brazil','2015-04-13 21:40:48','2015-04-13 21:40:48'



SET SQL_SAFE_UPDATES = 0;
UPDATE game SET team1 = "uruguay" WHERE team1 = "argentina";
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM game;
# 'uruguay','brazil','2015-04-13 21:44:46','2015-04-13 21:40:48'

# not only team1 has been changed, start automatically update, end remain the same.
# the reason is that its type is `TIMESTAMP`. Fields of this type have the behavior 
# that when a record in the table is updated, the field gets updated to reflect the then-current time.

# but surprisingly, if we have multiple columns of type TIMESTAMP, only the first has 
# this behavior but the others do not.