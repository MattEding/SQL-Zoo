-- 1
SELECT name
FROM world
WHERE population > (SELECT population
                    FROM world
                    WHERE name = 'Russia');

-- 2
SELECT name
FROM world
WHERE continent = 'Europe'
  AND gdp / population > (SELECT gdp / population
                          FROM world
                          WHERE name = 'United Kingdom');

-- 3
SELECT name, continent
FROM world
WHERE continent IN (SELECT DISTINCT continent
                    FROM world
                    WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;

-- 4
SELECT name, population
FROM world
WHERE population > (SELECT population
                    FROM world
                    WHERE name = 'Canada')
  AND population < (SELECT population
                    FROM world
                    WHERE name = 'Poland');

-- 5
SELECT w.name, CONCAT(ROUND(100 * w.population / g.population), '%')
FROM world AS w, (SELECT population
                  FROM world
                  WHERE name = 'Germany') AS g
WHERE continent = 'Europe';

-- 6
SELECT name
FROM world
WHERE gdp > all(SELECT gdp
                FROM world
                WHERE gdp IS NOT NULL
                  AND continent = 'Europe');

-- 7
SELECT continent, name, area
FROM world AS w
WHERE w.area = (SELECT MAX(area)
                FROM world
                WHERE w.continent = continent);

-- 8
SELECT w.continent, w.name
FROM world AS w
WHERE w.name = (SELECT name
                FROM world
                WHERE w.continent = continent
                GROUP BY name
                ORDER BY name
                LIMIT 1);

-- 9
SELECT w.name, w.continent, w.population
FROM world AS w
WHERE 2.5e7 >= ALL(SELECT population
                   FROM world
                   WHERE w.continent = continent);

-- 10
SELECT w.name, w.continent
FROM world AS w
WHERE w.population > 3 * (SELECT MAX(population)
                          FROM world
                          WHERE w.continent = continent
                          AND w.name != name);
