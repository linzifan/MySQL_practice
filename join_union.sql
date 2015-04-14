# A JOIN clause is used to combine rows from two or more tables, based on a common field between them.

USE test;

DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS student;

CREATE TABLE department(
  department_id INT,
  department_name VARCHAR(32)
);

CREATE TABLE student(
  student_id INT,
  studnet_name VARCHAR(32),
  department_id INT,
  score INT
);

INSERT INTO department VALUES (1, 'Statistics'), (2, 'Math'), (3, 'Economics'), (4, 'Physics');
INSERT INTO student VALUES (1, 'Allen', 2, 97), (2, 'Bob', 2, 78), (3, 'Chris', 3, 87),
(4, 'David', 1, 99), (5, 'Eric', 3, 87), (6, 'Frank', 1, 92), (7, 'Gary', 3, 87), (8, 'Harry', 5, 76);

SELECT * FROM department;
#+---------------+-----------------+
#| department_id | department_name |
#+---------------+-----------------+
#|             1 | Statistics      |
#|             2 | Math            |
#|             3 | Economics       |
#|             4 | Physics         |
#+---------------+-----------------+
SELECT * FROM student;
#+------------+--------------+---------------+-------+
#| student_id | studnet_name | department_id | score |
#+------------+--------------+---------------+-------+
#|          1 | Allen        |             2 |    97 |
#|          2 | Bob          |             2 |    78 |
#|          3 | Chris        |             3 |    87 |
#|          4 | David        |             1 |    99 |
#|          5 | Eric         |             3 |    87 |
#|          6 | Frank        |             1 |    92 |
#|          7 | Gary         |             3 |    87 |
#|          8 | Harry        |             5 |    76 |
#+------------+--------------+---------------+-------+

# INNER JOIN Returns all rows from multiple tables where the join condition is met. 
# This is the default type of join if no specific JOIN type is specified.
SELECT * FROM department INNER JOIN student ON department.department_id = student.department_id;
#+---------------+-----------------+------------+--------------+---------------+-------+
#| department_id | department_name | student_id | studnet_name | department_id | score |
#+---------------+-----------------+------------+--------------+---------------+-------+
#|             2 | Math            |          1 | Allen        |             2 |    97 |
#|             2 | Math            |          2 | Bob          |             2 |    78 |
#|             3 | Economics       |          3 | Chris        |             3 |    87 |
#|             1 | Statistics      |          4 | David        |             1 |    99 |
#|             3 | Economics       |          5 | Eric         |             3 |    87 |
#|             1 | Statistics      |          6 | Frank        |             1 |    92 |
#|             3 | Economics       |          7 | Gary         |             3 |    87 |
#+---------------+-----------------+------------+--------------+---------------+-------+
#7 rows in set
# No department_id = 4 (in department). No department_id = 5 (in student).


# LEFT JOIN Returns all rows from the left table, with the matching rows in the right table.
# The result is NULL in the right side when there is no match.
SELECT * FROM department LEFT JOIN student ON department.department_id = student.department_id;
#+---------------+-----------------+------------+--------------+---------------+-------+
#| department_id | department_name | student_id | studnet_name | department_id | score |
#+---------------+-----------------+------------+--------------+---------------+-------+
#|             2 | Math            |          1 | Allen        |             2 |    97 |
#|             2 | Math            |          2 | Bob          |             2 |    78 |
#|             3 | Economics       |          3 | Chris        |             3 |    87 |
#|             1 | Statistics      |          4 | David        |             1 |    99 |
#|             3 | Economics       |          5 | Eric         |             3 |    87 |
#|             1 | Statistics      |          6 | Frank        |             1 |    92 |
#|             3 | Economics       |          7 | Gary         |             3 |    87 |
#|             4 | Physics         |       NULL | NULL         |          NULL |  NULL |
#+---------------+-----------------+------------+--------------+---------------+-------+
#8 rows in set
# No department_id = 5 (in student).


# RIGHT JOIN Returns all rows from the right table, with the matching rows in the left table.
# The result is NULL in the left side when there is no match.
SELECT * FROM department RIGHT JOIN student ON department.department_id = student.department_id;
#+---------------+-----------------+------------+--------------+---------------+-------+
#| department_id | department_name | student_id | studnet_name | department_id | score |
#+---------------+-----------------+------------+--------------+---------------+-------+
#|             1 | Statistics      |          4 | David        |             1 |    99 |
#|             1 | Statistics      |          6 | Frank        |             1 |    92 |
#|             2 | Math            |          1 | Allen        |             2 |    97 |
#|             2 | Math            |          2 | Bob          |             2 |    78 |
#|             3 | Economics       |          3 | Chris        |             3 |    87 |
#|             3 | Economics       |          5 | Eric         |             3 |    87 |
#|             3 | Economics       |          7 | Gary         |             3 |    87 |
#|          NULL | NULL            |          8 | Harry        |             5 |    76 |
#+---------------+-----------------+------------+--------------+---------------+-------+
#8 rows in set
# No department_id = 4 (in department).


# CROSS JOIN Returns the Cartesian product of rows from tables
# It will produce rows which combine each row from the first table with each row from the second table
# The following three have the same result (MySQL does not support FULL JOIN)
SELECT * FROM department CROSS JOIN student;
SELECT * FROM department, student;
SELECT department_name, student_id FROM department FULL JOIN student;
#+---------------+-----------------+------------+--------------+---------------+-------+
#| department_id | department_name | student_id | studnet_name | department_id | score |
#+---------------+-----------------+------------+--------------+---------------+-------+
#|             1 | Statistics      |          1 | Allen        |             2 |    97 |
#|             2 | Math            |          1 | Allen        |             2 |    97 |
#|             3 | Economics       |          1 | Allen        |             2 |    97 |
#|             4 | Physics         |          1 | Allen        |             2 |    97 |
#|             1 | Statistics      |          2 | Bob          |             2 |    78 |
#|             2 | Math            |          2 | Bob          |             2 |    78 |
#|             3 | Economics       |          2 | Bob          |             2 |    78 |
#|             4 | Physics         |          2 | Bob          |             2 |    78 |
#|             1 | Statistics      |          3 | Chris        |             3 |    87 |
#|             2 | Math            |          3 | Chris        |             3 |    87 |
#|             3 | Economics       |          3 | Chris        |             3 |    87 |
#|             4 | Physics         |          3 | Chris        |             3 |    87 |
#|             1 | Statistics      |          4 | David        |             1 |    99 |
#|             2 | Math            |          4 | David        |             1 |    99 |
#|             3 | Economics       |          4 | David        |             1 |    99 |
#|             4 | Physics         |          4 | David        |             1 |    99 |
#|             1 | Statistics      |          5 | Eric         |             3 |    87 |
#|             2 | Math            |          5 | Eric         |             3 |    87 |
#|             3 | Economics       |          5 | Eric         |             3 |    87 |
#|             4 | Physics         |          5 | Eric         |             3 |    87 |
#|             1 | Statistics      |          6 | Frank        |             1 |    92 |
#|             2 | Math            |          6 | Frank        |             1 |    92 |
#|             3 | Economics       |          6 | Frank        |             1 |    92 |
#|             4 | Physics         |          6 | Frank        |             1 |    92 |
#|             1 | Statistics      |          7 | Gary         |             3 |    87 |
#|             2 | Math            |          7 | Gary         |             3 |    87 |
#|             3 | Economics       |          7 | Gary         |             3 |    87 |
#|             4 | Physics         |          7 | Gary         |             3 |    87 |
#|             1 | Statistics      |          8 | Harry        |             5 |    76 |
#|             2 | Math            |          8 | Harry        |             5 |    76 |
#|             3 | Economics       |          8 | Harry        |             5 |    76 |
#|             4 | Physics         |          8 | Harry        |             5 |    76 |
#+---------------+-----------------+------------+--------------+---------------+-------+
#32 rows in set

SELECT * FROM department CROSS JOIN student ON department.department_id = student.department_id;
#+---------------+-----------------+------------+--------------+---------------+-------+
#| department_id | department_name | student_id | studnet_name | department_id | score |
#+---------------+-----------------+------------+--------------+---------------+-------+
#|             2 | Math            |          1 | Allen        |             2 |    97 |
#|             2 | Math            |          2 | Bob          |             2 |    78 |
#|             3 | Economics       |          3 | Chris        |             3 |    87 |
#|             1 | Statistics      |          4 | David        |             1 |    99 |
#|             3 | Economics       |          5 | Eric         |             3 |    87 |
#|             1 | Statistics      |          6 | Frank        |             1 |    92 |
#|             3 | Economics       |          7 | Gary         |             3 |    87 |
#+---------------+-----------------+------------+--------------+---------------+-------+
#7 rows in set


# FULL OUTER JOIN combines the result of both LEFT and RIGHT joins.
# MySQL does not support FULL OUTER JOIN. 
# A solution is to use UNION ALL to connect a LEFT JOIN and a RIGHT JOIN.
SELECT * FROM department LEFT JOIN student ON department.department_id = student.department_id
UNION
SELECT * FROM department RIGHT JOIN student ON department.department_id = student.department_id;
#+---------------+-----------------+------------+--------------+---------------+-------+
#| department_id | department_name | student_id | studnet_name | department_id | score |
#+---------------+-----------------+------------+--------------+---------------+-------+
#|             2 | Math            |          1 | Allen        |             2 |    97 |
#|             2 | Math            |          2 | Bob          |             2 |    78 |
#|             3 | Economics       |          3 | Chris        |             3 |    87 |
#|             1 | Statistics      |          4 | David        |             1 |    99 |
#|             3 | Economics       |          5 | Eric         |             3 |    87 |
#|             1 | Statistics      |          6 | Frank        |             1 |    92 |
#|             3 | Economics       |          7 | Gary         |             3 |    87 |
#|             4 | Physics         |       NULL | NULL         |          NULL |  NULL |
#|          NULL | NULL            |          8 | Harry        |             5 |    76 |
#+---------------+-----------------+------------+--------------+---------------+-------+
#9 rows in set


# What does UNION do? What is the difference between UNION and UNION ALL?
# UNION will remove duplicate rows.
SELECT department_id FROM department UNION SELECT department_id FROM student;
#+---------------+
#| department_id |
#+---------------+
#|             1 |
#|             2 |
#|             3 |
#|             4 |
#+---------------+

SELECT department_id FROM department UNION ALL SELECT department_id FROM student;
#+---------------+
#| department_id |
#+---------------+
#|             1 |
#|             2 |
#|             3 |
#|             4 |
#|             2 |
#|             2 |
#|             3 |
#|             1 |
#|             3 |
#|             1 |
#|             3 |
#|             1 |
#+---------------+
#12 rows in set
  