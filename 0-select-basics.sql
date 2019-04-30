-- 1
SELECT population
FROM world
WHERE name = 'Germany';

-- 2
SELECT name, population
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- 3
SELECT name, area
FROM world
WHERE area BETWEEN 2e5 AND 2.5e5;
