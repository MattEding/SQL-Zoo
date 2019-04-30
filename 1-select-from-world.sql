-- 1
SELECT name, continent, population
FROM world;

-- 2
SELECT name
FROM world
WHERE population >= 2e8;

-- 3
SELECT name, gdp / population
FROM world
WHERE population >= 2e8;

-- 4
-- note that using exponential notation SQLZOO
-- registers "wrong" answer due to decimal rounding
SELECT name, population / 1e6
FROM world
WHERE continent = 'South America';

-- 5
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 6
SELECT name
FROM world
WHERE name LIKE '%United%';

-- 7
SELECT name, population, area
FROM world
WHERE area > 3e6
   OR population > 2.5e8;

-- 8
SELECT name, population, area
FROM world
WHERE area > 3e6
  XOR population > 2.5e8;

-- 9
-- again "wrong" answer due to ROUND with exponential notation
SELECT name, ROUND(population / 1e6, 2), ROUND(gdp / 1e9, 2)
FROM world
WHERE continent = 'South America';

-- 10
SELECT name, ROUND(gdp / population, -3)
FROM world
WHERE gdp >= 1e12

-- 11
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- 12
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name != capital

-- 13
SELECT name
FROM world
WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';
