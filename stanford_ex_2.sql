# Stanford Online Course SQL Excercise
# Social Network Query
USE test;
# Input data:
/* Delete the tables if they already exist */
drop table if exists Highschooler;
drop table if exists Friend;
drop table if exists Likes;

/* Create the schema for our tables */
create table Highschooler(ID int, name text, grade int);
create table Friend(ID1 int, ID2 int);
create table Likes(ID1 int, ID2 int);

/* Populate the tables with our data */
insert into Highschooler values (1510, 'Jordan', 9);
insert into Highschooler values (1689, 'Gabriel', 9);
insert into Highschooler values (1381, 'Tiffany', 9);
insert into Highschooler values (1709, 'Cassandra', 9);
insert into Highschooler values (1101, 'Haley', 10);
insert into Highschooler values (1782, 'Andrew', 10);
insert into Highschooler values (1468, 'Kris', 10);
insert into Highschooler values (1641, 'Brittany', 10);
insert into Highschooler values (1247, 'Alexis', 11);
insert into Highschooler values (1316, 'Austin', 11);
insert into Highschooler values (1911, 'Gabriel', 11);
insert into Highschooler values (1501, 'Jessica', 11);
insert into Highschooler values (1304, 'Jordan', 12);
insert into Highschooler values (1025, 'John', 12);
insert into Highschooler values (1934, 'Kyle', 12);
insert into Highschooler values (1661, 'Logan', 12);

insert into Friend values (1510, 1381);
insert into Friend values (1510, 1689);
insert into Friend values (1689, 1709);
insert into Friend values (1381, 1247);
insert into Friend values (1709, 1247);
insert into Friend values (1689, 1782);
insert into Friend values (1782, 1468);
insert into Friend values (1782, 1316);
insert into Friend values (1782, 1304);
insert into Friend values (1468, 1101);
insert into Friend values (1468, 1641);
insert into Friend values (1101, 1641);
insert into Friend values (1247, 1911);
insert into Friend values (1247, 1501);
insert into Friend values (1911, 1501);
insert into Friend values (1501, 1934);
insert into Friend values (1316, 1934);
insert into Friend values (1934, 1304);
insert into Friend values (1304, 1661);
insert into Friend values (1661, 1025);
insert into Friend select ID2, ID1 from Friend;

insert into Likes values(1689, 1709);
insert into Likes values(1709, 1689);
insert into Likes values(1782, 1709);
insert into Likes values(1911, 1247);
insert into Likes values(1247, 1468);
insert into Likes values(1641, 1468);
insert into Likes values(1316, 1304);
insert into Likes values(1501, 1934);
insert into Likes values(1934, 1501);
insert into Likes values(1025, 1101);


# Find the names of all students who are friends with someone named Gabriel.
SELECT Name FROM Highschooler 
WHERE ID IN
(SELECT ID1 FROM Friend
WHERE ID2 IN (SELECT ID FROM Highschooler WHERE name = 'Gabriel'))
UNION
SELECT Name FROM Highschooler 
WHERE ID IN
(SELECT ID2 FROM Friend
WHERE ID1 IN (SELECT ID FROM Highschooler WHERE name = 'Gabriel'));

# For every student who likes someone 2 or more grades younger than themselves, 
# return that student's name and grade, and the name and grade of the student they like. 
SELECT A.name AS name1, A.grade AS grade1, Highschooler.name AS name2, Highschooler.grade AS grade2
FROM (SELECT ID1, ID2, name, grade FROM Likes LEFT JOIN Highschooler ON Likes.ID1 = Highschooler.ID) AS A
LEFT JOIN Highschooler ON A.ID2 = Highschooler.ID
WHERE A.grade - Highschooler.grade >= 2 OR A.grade - Highschooler.grade <= -2;

# For every pair of students who both like each other, return the name and grade of both 
# students. Include each pair only once, with the two names in alphabetical order. 
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Likes AS L1, Likes AS L2, Highschooler AS H1, Highschooler AS H2 
WHERE L1.ID1 = L2.ID2 AND L1.ID2 = L2.ID1 AND L1.ID1 = H1.ID AND L1.ID2 = H2.ID AND H1.name < H2.name;

# Find all students who do not appear in the Likes table (as a student who likes or is liked) 
# and return their names and grades. Sort by grade, then by name within each grade. 
SELECT name, grade
FROM Highschooler 
LEFT JOIN Likes L1 ON ID = L1.ID1
LEFT JOIN Likes L2 ON ID = L2.ID2
WHERE L1.ID1 IS NULL AND L2.ID2 IS NULL
ORDER BY grade, name;

# For every situation where student A likes student B, but we have no information about 
# whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and 
# B's names and grades. 
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Likes AS L1, Highschooler AS H1, Highschooler AS H2 
WHERE L1.ID2 NOT IN (SELECT ID1 FROM Likes)
AND L1.ID1 = H1.ID
AND L1.ID2 = H2.ID;

# Find names and grades of students who only have friends in the same grade. Return 
# the result sorted by grade, then by name within each grade. 
SELECT name, grade FROM Highschooler
WHERE ID NOT IN
(SELECT F.ID1 FROM Friend AS F, Highschooler AS H1, Highschooler AS H2
WHERE F.ID1 = H1.ID AND F.ID2 = H2.ID AND H1.grade <> H2.grade)
ORDER BY grade, name;

# For each student A who likes a student B where the two are not friends, find if 
# they have a friend C in common (who can introduce them!). For all such trios, 
# return the name and grade of A, B, and C.
SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade 
FROM Likes AS L, Friend AS F1, Friend AS F2,
     Highschooler AS H1, Highschooler AS H2, Highschooler AS H3
WHERE L.ID2 NOT IN (SELECT ID2 FROM Friend WHERE Friend.ID1 = L.ID1)
AND L.ID1 = F1.ID1 AND F1.ID2 = F2.ID1 AND F2.ID2 = L.ID2
AND L.ID1 = H1.ID AND L.ID2 = H2.ID AND F1.ID2 = H3.ID;



# Find the difference between the number of students in the school and the 
# number of different first names.
SELECT count(name) - count(distinct name) FROM Highschooler;

# Find the name and grade of all students who are liked by more than one other student.
SELECT name, grade FROM Highschooler
WHERE ID IN
(SELECT ID2 FROM Likes GROUP BY ID2
HAVING count(ID2) > 1);

# For every situation where student A likes student B, but student B likes a different 
# student C, return the names and grades of A, B, and C. 
SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade  
FROM Likes AS L1, Likes AS L2,
     Highschooler AS H1, Highschooler AS H2, Highschooler AS H3
WHERE L1.ID2 = L2.ID1 AND L2.ID2 <> L1.ID1
AND L1.ID1 = H1.ID AND L1.ID2 = H2.ID AND L2.ID2 = H3.ID;

# Find those students for whom all of their friends are in different grades from themselves. 
# Return the students' names and grades. 
SELECT name, grade FROM Highschooler AS H
WHERE H.ID NOT IN
(SELECT ID1 FROM friend AS F, Highschooler AS H1, Highschooler AS H2
WHERE F.ID1 = H1.ID AND F.ID2 = H2.ID AND H1.grade = H2.grade);

# What is the average number of friends per student? (Your result should be just one number.) 
SELECT avg(c) FROM
(SELECT count(ID1) AS c FROM Friend GROUP BY ID1) AS A;

# Find the number of students who are either friends with Cassandra or are friends of friends
# of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend. 
SELECT count(*) FROM 
(SELECT H2.name FROM Friend AS F, Highschooler AS H1, Highschooler AS H2
WHERE F.ID1 = H1.ID AND H1.name = 'Cassandra' AND H2.ID = F.ID2
UNION
SELECT distinct H3.name FROM Friend, Highschooler AS H3
WHERE ID1 IN
(SELECT F.ID2 FROM Friend AS F, Highschooler AS H1
WHERE F.ID1 = H1.ID AND H1.name = 'Cassandra')
AND ID2 = H3.ID) AS W;

# Find the name and grade of the student(s) with the greatest number of friends. 
SELECT H.name, H.grade FROM
(SELECT A.ID1, A.c FROM 
(SELECT ID1, count(ID1) AS c FROM Friend GROUP BY ID1) AS A INNER JOIN
(SELECT max(c) AS m FROM (SELECT ID1, count(ID1) AS c FROM Friend GROUP BY ID1) AS D) AS B
ON A.c = B.m) AS E, Highschooler AS H
WHERE E.ID1 = H.ID;

# It's time for the seniors to graduate. Remove all 12th graders from Highschooler. 
DELETE FROM Highschooler
WHERE grade = 12;

# If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. 
DELETE FROM Likes
WHERE ID2 IN (SELECT ID2 FROM Friend WHERE Likes.ID1 = ID1)
AND ID2 NOT IN (SELECT L.ID1 FROM Likes AS L WHERE Likes.ID1 = L.ID2);

# For all cases where A is friends with B, and B is friends with C, add a new friendship 
# for the pair A and C. Do not add duplicate friendships, friendships that already exist, 
# or friendships with oneself. (This one is a bit challenging; congratulations if you get it right.) 
#INSERT INTO Friend
#SELECT F1.ID1, F2.ID2 FROM Friend AS F1, Friend AS F2
#WHERE F1.ID2 = F2.ID1 AND F1.ID1 <> F2.ID2
#EXCEPT
#SELECT * FROM Friend;
