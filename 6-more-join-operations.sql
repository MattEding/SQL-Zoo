-- 1
SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3
SELECT id, title, yr
FROM movie
WHERE title like '%Star Trek%'
ORDER BY yr;

-- 4
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6
SELECT a.name
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE m.title = 'Casablanca';

-- 7
SELECT a.name
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE m.title = 'Alien';

-- 8
SELECT m.title
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'Harrison Ford';

-- 9
SELECT m.title
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'Harrison Ford'
  AND c.ord != 1;

-- 10
SELECT m.title, a.name
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE m.yr = 1962
  AND c.ord = 1;

-- 11
SELECT m.yr, count(*)
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'John Travolta'
GROUP BY m.yr
HAVING count(*) > 2;

-- 12
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
SELECT a.name
FROM casting AS c
JOIN actor AS a ON a.id = c.actorid
GROUP BY a.name
HAVING sum(c.ord = 1) >= 30
ORDER BY a.name;

-- 14
SELECT m.title, count(c.actorid)
FROM casting AS c
JOIN movie AS m ON m.id = c.movieid
WHERE m.yr = 1978
GROUP BY m.title
ORDER BY count(c.actorid) DESC, m.title;

-- 15
SELECT a.name
FROM casting AS c
JOIN actor AS a ON a.id = c.actorid
WHERE a.name != 'Art Garfunkel'
  AND c.movieid IN (SELECT cc.movieid
                    FROM casting AS cc
                    JOIN actor AS aa ON aa.id = cc.actorid
                    WHERE aa.name = 'Art Garfunkel');
