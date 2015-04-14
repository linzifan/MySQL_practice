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
(4, 'David', 1, 99), (5, 'Eric', 3, 87), (6, 'Frank', 1, 92), (7, 'Gary', 3, 87), (8, 'Harry', 1, 76);

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
#|          8 | Harry        |             1 |    76 |
#+------------+--------------+---------------+-------+

# INNER JOIN Returns all rows for which there is at least one match in BOTH tables. 
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
#|             1 | Statistics      |          8 | Harry        |             1 |    76 |
#+---------------+-----------------+------------+--------------+---------------+-------+
#8 rows in set

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
#|             1 | Statistics      |          8 | Harry        |             1 |    76 |
#|             4 | Physics         |       NULL | NULL         |          NULL |  NULL |
#+---------------+-----------------+------------+--------------+---------------+-------+
#9 rows in set

SELECT * FROM department RIGHT JOIN student ON department.department_id = student.department_id;
#+---------------+-----------------+------------+--------------+---------------+-------+
#| department_id | department_name | student_id | studnet_name | department_id | score |
#+---------------+-----------------+------------+--------------+---------------+-------+
#|             1 | Statistics      |          4 | David        |             1 |    99 |
#|             1 | Statistics      |          6 | Frank        |             1 |    92 |
#|             1 | Statistics      |          8 | Harry        |             1 |    76 |
#|             2 | Math            |          1 | Allen        |             2 |    97 |
#|             2 | Math            |          2 | Bob          |             2 |    78 |
#|             3 | Economics       |          3 | Chris        |             3 |    87 |
#|             3 | Economics       |          5 | Eric         |             3 |    87 |
#|             3 | Economics       |          7 | Gary         |             3 |    87 |
#+---------------+-----------------+------------+--------------+---------------+-------+
#8 rows in set

SELECT * FROM department FULL JOIN student;
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
#|             1 | Statistics      |          8 | Harry        |             1 |    76 |
#|             2 | Math            |          8 | Harry        |             1 |    76 |
#|             3 | Economics       |          8 | Harry        |             1 |    76 |
#|             4 | Physics         |          8 | Harry        |             1 |    76 |
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
#|             1 | Statistics      |          8 | Harry        |             1 |    76 |
#+---------------+-----------------+------------+--------------+---------------+-------+
#8 rows in set


# What does UNION do? What is the difference between UNION and UNION ALL?
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
  