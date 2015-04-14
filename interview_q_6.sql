USE test;

DROP TABLE IF EXISTS envelope;
DROP TABLE IF EXISTS docs;

CREATE TABLE envelope(
  id INT,
  user_id INT
);
CREATE TABLE docs(
  idnum INT,
  pageseq INT,
  doctext VARCHAR(100)
);

INSERT INTO envelope VALUES (1,1), (2,2), (3,3);
INSERT INTO docs(idnum, pageseq) VALUES (1,5), (2,6), (NULL,0);

SELECT * FROM envelope;
# id user_id
# 1  1
# 2  2
# 3  3
SELECT * FROM docs;
# idnum pageseq doctext
# 1     5       NULL
# 2     6       NULL
# NULL  0       NULL

# What will the result be from the following query, explain
SET SQL_SAFE_UPDATES = 0;
UPDATE docs SET doctext = pageseq 
FROM docs INNER JOIN envelope ON envelope.id = docs.idnum
WHERE EXISTS (SELECT 1 FROM docs WHERE id = envelope.id);

# The EXISTS clause in the above query is a red herring. It will always be true since ID is not a member of dbo.docs. As such, it will refer to the envelope table comparing itself to itself!

# The idnum value of NULL will not be set since the join of NULL will not return a result when attempting a match with any value of envelope.

SELECT pageseq FROM docs INNER JOIN envelope ON envelope.id = docs.idnum
WHERE EXISTS (SELECT 1 FROM docs WHERE id = envelope.id);







