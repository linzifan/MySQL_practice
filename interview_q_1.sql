# SQL interview question 1

USE test;

DROP TABLE IF EXISTS student_score;

CREATE TABLE student_score(
  id int NOT NULL,
  stu_name varchar(16),
  course varchar(16),
  score int,
  PRIMARY KEY (id)
);
  
INSERT INTO student_score VALUES (1, "AA", "English", 80);
INSERT INTO student_score VALUES (2, "BB", "Math", 90);
INSERT INTO student_score VALUES (3, "CC", "English", 78);
INSERT INTO student_score VALUES (4, "DD", "Math", 89);
INSERT INTO student_score VALUES (5, "EE", "Math", 89);
INSERT INTO student_score VALUES (6, "FF", "English", 88);
INSERT INTO student_score VALUES (7, "GG", "Math", 90);
INSERT INTO student_score VALUES (8, "HH", "Math", 85);
INSERT INTO student_score VALUES (9, "II", "English", 90);

# select * from student_score


# Question 1: Find the student(s) with highest math score?
SELECT * FROM student_score AS s
WHERE s.score = (SELECT MAX(score) FROM student_score AS s WHERE s.course = "Math")
AND s.course = "Math";

SELECT * FROM student_score AS s
WHERE s.score IN (SELECT MAX(score) FROM student_score AS s WHERE s.course = "Math")
AND s.course = "Math";

# The following is wrong: it will return only one row
SELECT * FROM student_score
WHERE course = "Math"
ORDER BY score DESC
LIMIT 1;



# Question 2: Find the student(s) with second highest math score?
SELECT * FROM student_score AS s
WHERE s.score = (SELECT DISTINCT score FROM student_score
WHERE course = "Math"
LIMIT 1,1)
AND s.course = "Math";


SELECT * FROM student_score AS s
WHERE s.score = (SELECT DISTINCT score FROM student_score
WHERE course = "Math"
LIMIT 2,1)  # third highest limit k-1, 1
AND s.course = "Math";

CREATE VIEW highest AS
SELECT * FROM student_score AS s
WHERE s.score = (SELECT DISTINCT score FROM student_score
WHERE course = "Math"
LIMIT 1,1)
AND s.course = "Math";

SELECT * FROM highest;


