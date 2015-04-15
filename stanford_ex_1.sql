# Stanford Online Course SQL Excercise
# Rating Query
USE test;
# Input data:
/* Delete the tables if they already exist */
drop table if exists Movie;
drop table if exists Reviewer;
drop table if exists Rating;

/* Create the schema for our tables */
create table Movie(mID int, title text, year int, director text);
create table Reviewer(rID int, name text);
create table Rating(rID int, mID int, stars int, ratingDate date);

/* Populate the tables with our data */
insert into Movie values(101, 'Gone with the Wind', 1939, 'Victor Fleming');
insert into Movie values(102, 'Star Wars', 1977, 'George Lucas');
insert into Movie values(103, 'The Sound of Music', 1965, 'Robert Wise');
insert into Movie values(104, 'E.T.', 1982, 'Steven Spielberg');
insert into Movie values(105, 'Titanic', 1997, 'James Cameron');
insert into Movie values(106, 'Snow White', 1937, null);
insert into Movie values(107, 'Avatar', 2009, 'James Cameron');
insert into Movie values(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

insert into Reviewer values(201, 'Sarah Martinez');
insert into Reviewer values(202, 'Daniel Lewis');
insert into Reviewer values(203, 'Brittany Harris');
insert into Reviewer values(204, 'Mike Anderson');
insert into Reviewer values(205, 'Chris Jackson');
insert into Reviewer values(206, 'Elizabeth Thomas');
insert into Reviewer values(207, 'James Cameron');
insert into Reviewer values(208, 'Ashley White');

insert into Rating values(201, 101, 2, '2011-01-22');
insert into Rating values(201, 101, 4, '2011-01-27');
insert into Rating values(202, 106, 4, null);
insert into Rating values(203, 103, 2, '2011-01-20');
insert into Rating values(203, 108, 4, '2011-01-12');
insert into Rating values(203, 108, 2, '2011-01-30');
insert into Rating values(204, 101, 3, '2011-01-09');
insert into Rating values(205, 103, 3, '2011-01-27');
insert into Rating values(205, 104, 2, '2011-01-22');
insert into Rating values(205, 108, 4, null);
insert into Rating values(206, 107, 3, '2011-01-15');
insert into Rating values(206, 106, 5, '2011-01-19');
insert into Rating values(207, 107, 5, '2011-01-20');
insert into Rating values(208, 104, 3, '2011-01-02');

# Find the titles of all movies directed by Steven Spielberg. 
SELECT title FROM Movie WHERE director = 'Steven Spielberg';

# Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. 
SELECT DISTINCT year FROM Movie, Rating 
WHERE Movie.mID = Rating.mID AND (Rating.stars >= 4)
ORDER BY year;

# Find the titles of all movies that have no ratings. 
SELECT title FROM Movie LEFT JOIN Rating
ON Movie.mID = Rating.mID WHERE stars is NULL;

# Some reviewers didn't provide a date with their rating. 
# Find the names of all reviewers who have ratings with a NULL value for the date.
SELECT name FROM Rating LEFT JOIN Reviewer
ON Reviewer.rID = Rating.rID WHERE ratingDate is NULL;

# Write a query to return the ratings data in a more readable format: reviewer name, 
# movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, 
# then by movie title, and lastly by number of stars. 
SELECT name, title, stars, ratingDate FROM Rating LEFT JOIN Reviewer ON Rating.rID = Reviewer.rID
LEFT JOIN Movie ON Rating.mID = Movie.mID
ORDER BY name, title, stars;

# For all cases where the same reviewer rated the same movie twice and gave it a 
# higher rating the second time, return the reviewer's name and the title of the movie.
SELECT name, title FROM
(SELECT R1.rID, R1.mID FROM Rating R1, Rating R2 
WHERE R1.rID = R2.rID AND R1.mID = R2.mID AND R1.stars < R2.stars AND R1.ratingDate < R2.ratingDate) AS R
LEFT JOIN Movie ON R.mID = Movie.mID
LEFT JOIN Reviewer ON R.rID = Reviewer.rID; 

# For each movie that has at least one rating, find the highest number of stars that 
# movie received. Return the movie title and number of stars. Sort by movie title. 
SELECT title, stars FROM Movie, (SELECT mID, max(stars) AS stars FROM Rating GROUP BY mID) AS R
WHERE Movie.mID = R.mID
ORDER BY title;

# For each movie, return the title and the 'rating spread', that is, the difference 
# between highest and lowest ratings given to that movie. Sort by rating spread from 
# highest to lowest, then by movie title. 
SELECT title, R.`rating spread`
FROM Movie, (SELECT mID, max(stars)-min(stars) AS 'rating spread' FROM Rating GROUP BY mID) AS R
WHERE Movie.mID = R.mID
ORDER BY `rating spread` DESC, title;

# Find the difference between the average rating of movies released before 1980 and 
# the average rating of movies released after 1980. (Make sure to calculate the average 
# rating for each movie, then the average of those averages for movies before 1980 and 
# movies after. Don't just calculate the overall average rating before and after 1980.) 
SELECT avg(A.a1) - avg(B.a2) FROM
(SELECT Rating.mID, avg(stars) AS a1, year 
FROM Rating LEFT JOIN Movie ON Rating.mID = Movie.mID
WHERE year <= 1980
GROUP BY mID) AS A,
(SELECT Rating.mID, avg(stars) AS a2, year 
FROM Rating LEFT JOIN Movie ON Rating.mID = Movie.mID
WHERE year > 1980
GROUP BY mID) AS B;

# Find the names of all reviewers who rated Gone with the Wind.
SELECT distinct Reviewer.name FROM Rating INNER JOIN Reviewer 
ON Rating.rID = Reviewer.rID AND Rating.mID = (SELECT mID FROM Movie WHERE title = 'Gone with the Wind');

# For any rating where the reviewer is the same as the director of the movie, 
# return the reviewer name, movie title, and number of stars. 
SELECT name, title, stars FROM Rating LEFT JOIN Reviewer ON Rating.rID = Reviewer.rID
LEFT JOIN Movie ON Rating.mID = Movie.mID
WHERE name = director;

# Return all reviewer names and movie names together in a single list, alphabetized.
# (Sorting by the first name of the reviewer and first word in the title is fine; 
# no need for special processing on last names or removing "The".) 
SELECT name FROM Reviewer
UNION
SELECT title FROM Movie
ORDER BY name;

# Find the titles of all movies not reviewed by Chris Jackson.
SELECT title FROM Movie WHERE mID NOT IN
(SELECT mID FROM Rating WHERE rID = (SELECT rID FROM Reviewer WHERE name = 'Chris Jackson'));

# For all pairs of reviewers such that both reviewers gave a rating to the same movie, 
# return the names of both reviewers. Eliminate duplicates, don't pair reviewers with 
# themselves, and include each pair only once. For each pair, return the names in the 
# pair in alphabetical order. 
SELECT distinct R1.name, R2.name FROM
(SELECT Rating.*, name FROM Rating LEFT JOIN Reviewer ON Rating.rID = Reviewer.rID) AS R1, 
(SELECT Rating.*, name FROM Rating LEFT JOIN Reviewer ON Rating.rID = Reviewer.rID) AS R2
WHERE R1.mID = R2.mID AND R1.name < R2.name
ORDER BY R1.name, R2.name;

# For each rating that is the lowest (fewest stars) currently in the database, return 
# the reviewer name, movie title, and number of stars. 
SELECT name, title, R.minstars
FROM (SELECT *, min(stars) AS minstars FROM Rating 
      WHERE stars = (SELECT min(stars) FROM Rating)
      GROUP BY mID) AS R
LEFT JOIN Reviewer ON R.rID = Reviewer.rID
LEFT JOIN Movie ON R.mID = Movie.mID;

# List movie titles and average ratings, from highest-rated to lowest-rated. If two or 
# more movies have the same average rating, list them in alphabetical order.
SELECT title, R.astar
FROM (SELECT mID, avg(stars) AS astar
      FROM Rating   
	  GROUP BY mID) AS R
LEFT JOIN Movie ON R.mID = Movie.mID
ORDER BY astar DESC, title;

# Find the names of all reviewers who have contributed three or more ratings. 
# (As an extra challenge, try writing the query without HAVING or without COUNT.) 
SELECT name 
FROM (SELECT rID, count(rID) FROM Rating GROUP BY rID
      HAVING count(rID) >= 3) AS R
LEFT JOIN Reviewer ON R.rID = Reviewer.rID;

SELECT name
FROM Reviewer,
(SELECT distinct R1.rID FROM Rating R1, Rating AS R2, Rating AS R3
WHERE R1.rID = R2.rID AND(R1.mID <> R2.mID OR R1.ratingDate <> R2.ratingDate)
  AND R1.rID = R3.rID AND(R1.mID <> R3.mID OR R1.ratingDate <> R3.ratingDate)
  AND R2.rID = R3.rID AND(R2.mID <> R3.mID OR R2.ratingDate <> R3.ratingDate)) AS R
WHERE Reviewer.rID = R.rID;

# Some directors directed more than one movie. For all such directors, return 
# the titles of all movies directed by them, along with the director name. 
# Sort by director name, then movie title. (As an extra challenge, try writing 
# the query both with and without COUNT.) 
SELECT title, Movie.director 
FROM Movie, 
(SELECT director, count(director) 
FROM Movie
GROUP BY director
HAVING count(director) > 1) AS R
WHERE Movie.director = R.director
ORDER BY Movie.director, title;

SELECT title, Movie.director 
FROM Movie, 
(SELECT distinct M1.director
FROM Movie AS M1, Movie AS M2
WHERE M1.director = M2.director AND M1.title <> M2.title) AS R
WHERE Movie.director = R.director
ORDER BY Movie.director, title;

# Find the movie(s) with the highest average rating. Return the movie title(s) 
# and average rating. (Hint: This query is more difficult to write in SQLite 
# than other systems; you might think of it as finding the highest average rating 
# and then choosing the movie(s) with that average rating.) 
SELECT title, R.astar
FROM Movie,
(SELECT mID, avg(stars) AS astar FROM Rating 
GROUP BY mID 
ORDER BY astar DESC 
LIMIT 0, 1) AS R
WHERE Movie.mID = R.mID;

# Find the movie(s) with the lowest average rating. Return the movie title(s) 
# and average rating. (Hint: This query may be more difficult to write in SQLite 
# than other systems; you might think of it as finding the lowest average rating 
# and then choosing the movie(s) with that average rating.) 
# Consider the situation that there exists same average score!!
SELECT title, T.astar
FROM Movie,
(SELECT R.mID, R.astar FROM (SELECT mID, avg(stars) AS astar FROM Rating 
GROUP BY mID 
ORDER BY astar) AS R
WHERE R.astar = (SELECT min(astar) FROM 
(SELECT mID, avg(stars) AS astar FROM Rating 
GROUP BY mID 
ORDER BY astar) AS R)) AS T
WHERE Movie.mID = T.mID ; 

# For each director, return the director's name together with the title(s) of the 
# movie(s) they directed that received the highest rating among all of their movies, 
# and the value of that rating. Ignore movies whose director is NULL.
SELECT W.director, Movie.title, W.stars FROM Movie,
(SELECT distinct U.director, mID, stars FROM 
(SELECT max(stars) AS maxstars, director FROM(
SELECT Rating.*, director 
FROM Rating LEFT JOIN Movie ON Rating.mID = Movie.mID
WHERE director IS NOT NULL) AS T
GROUP BY director) AS U
LEFT JOIN
(SELECT Rating.*, director 
FROM Rating LEFT JOIN Movie ON Rating.mID = Movie.mID
WHERE director IS NOT NULL) AS V
ON U.director = V.director AND  U.maxstars = V.stars) AS W
WHERE Movie.mID = W.mID;




 