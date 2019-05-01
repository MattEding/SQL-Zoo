-- 1
-- List each country name where the population is larger than that of 'Russia'.
SELECT name
FROM world
WHERE population > (SELECT population
                    FROM world
                    WHERE name = 'Russia');

-- 2
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name
FROM world
WHERE continent = 'Europe'
  AND gdp / population > (SELECT gdp / population
                          FROM world
                          WHERE name = 'United Kingdom');

-- 3
-- List the name and continent of countries in the continents containing either Argentina or Australia.
-- Order by name of the country.
SELECT name, continent
FROM world
WHERE continent IN (SELECT DISTINCT continent
                    FROM world
                    WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;

-- 4
-- Which country has a population that is more than Canada but less than Poland?
-- Show the name and the population.
SELECT name, population
FROM world
WHERE population > (SELECT population
                    FROM world
                    WHERE name = 'Canada')
  AND population < (SELECT population
                    FROM world
                    WHERE name = 'Poland');

-- 5
-- Germany (population 80 million) has the largest population of the countries in Europe.
-- Austria (population 8.5 million) has 11% of the population of Germany.
-- Show the name and the population of each country in Europe.
-- Show the population as a percentage of the population of Germany.
SELECT w.name, CONCAT(ROUND(100 * w.population / g.population), '%')
FROM world AS w, (SELECT population
                  FROM world
                  WHERE name = 'Germany') AS g
WHERE continent = 'Europe';

-- 6
-- Which countries have a GDP greater than every country in Europe? [Give the name only.]
-- (Some countries may have NULL gdp values)
SELECT name
FROM world
WHERE gdp > all(SELECT gdp
                FROM world
                WHERE gdp IS NOT NULL
                  AND continent = 'Europe');

-- 7
-- Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area
FROM world AS w
WHERE w.area = (SELECT MAX(area)
                FROM world
                WHERE w.continent = continent);

-- 8
-- List each continent and the name of the country that comes first alphabetically.
SELECT w.continent, w.name
FROM world AS w
WHERE w.name = (SELECT name
                FROM world
                WHERE w.continent = continent
                GROUP BY name
                ORDER BY name
                LIMIT 1);

-- 9
-- Find the continents where all countries have a population <= 25000000.
-- Then find the names of the countries associated with these continents.
-- Show name, continent and population.
SELECT w.name, w.continent, w.population
FROM world AS w
WHERE 2.5e7 >= ALL(SELECT population
                   FROM world
                   WHERE w.continent = continent);

-- 10
-- Some countries have populations more than three times that of any of their neighbours (in the same continent).
-- Give the countries and continents.
SELECT w.name, w.continent
FROM world AS w
WHERE w.population > 3 * (SELECT MAX(population)
                          FROM world
                          WHERE w.continent = continent
                          AND w.name != name);
