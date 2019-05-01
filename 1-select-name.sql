-- 1
-- You can use WHERE name LIKE 'B%' to find the countries that start with "B".
-- The % is a wild-card it can match any characters
-- Find the country that start with Y
SELECT name
FROM world
WHERE name LIKE 'Y%';

-- 2
-- Find the countries that end with y
SELECT name
FROM world
WHERE name LIKE '%y';

-- 3
-- Find the countries that contain the letter x
SELECT name
FROM world
WHERE name LIKE '%x%';

-- 4
-- Find the countries that end with land
SELECT name
FROM world
WHERE name LIKE '%land';

-- 5
-- Find the countries that start with C and end with ia
SELECT name
FROM world
WHERE name LIKE 'C%'
  AND name LIKE '%ia';

-- 6
-- Find the country that has oo in the name
SELECT name
FROM world
WHERE name LIKE '%oo%';

-- 7
-- Find the countries that have three or more a in the name
SELECT name
FROM world
WHERE name LIKE '%a%a%a%';

-- 8
-- Find the countries that have "t" as the second character.
SELECT name FROM world
WHERE name LIKE '_t%';
