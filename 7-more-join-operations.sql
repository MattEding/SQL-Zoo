-- 1
-- List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2
-- Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3
-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title).
-- Order results by year.
SELECT id, title, yr
FROM movie
WHERE title like '%Star Trek%'
ORDER BY yr;

-- 4
-- What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5
-- What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6
-- Obtain the cast list for 'Casablanca'.
SELECT a.name
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE m.title = 'Casablanca';

-- 7
-- Obtain the cast list for the film 'Alien'
SELECT a.name
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE m.title = 'Alien';

-- 8
-- List the films in which 'Harrison Ford' has appeared
SELECT m.title
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'Harrison Ford';

-- 9
-- List the films where 'Harrison Ford' has appeared - but not in the starring role.
-- [Note: the ord field of casting gives the position of the actor.
-- If ord=1 then this actor is in the starring role]
SELECT m.title
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'Harrison Ford'
  AND c.ord != 1;

-- 10
-- List the films together with the leading star for all 1962 films.
SELECT m.title, a.name
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE m.yr = 1962
  AND c.ord = 1;

-- 11
-- Which were the busiest years for 'John Travolta', show the year and the number of movies
-- he made each year for any year in which he made more than 2 movies.
SELECT m.yr, count(*)
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'John Travolta'
GROUP BY m.yr
HAVING count(*) > 2;

-- 12
-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT m.title, a.name
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE c.ord = 1
GROUP BY m.title, a.name, c.movieid
HAVING 'Julie Andrews' IN (SELECT aa.name
                           FROM casting AS cc
                           JOIN actor AS aa ON aa.id = cc.actorid
                           WHERE c.movieid = cc.movieid);

-- 13
-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT a.name
FROM casting AS c
JOIN actor AS a ON a.id = c.actorid
GROUP BY a.name
HAVING sum(c.ord = 1) >= 30
ORDER BY a.name;

-- 14
--  List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT m.title, count(c.actorid)
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
WHERE m.yr = 1978
GROUP BY m.title
ORDER BY count(c.actorid) DESC, m.title;

-- 15
-- List all the people who have worked with 'Art Garfunkel'.
SELECT a.name
FROM casting AS c
JOIN actor AS a ON a.id = c.actorid
WHERE a.name != 'Art Garfunkel'
  AND c.movieid IN (SELECT cc.movieid
                    FROM casting AS cc
                    JOIN actor AS aa ON aa.id = cc.actorid
                    WHERE aa.name = 'Art Garfunkel');
