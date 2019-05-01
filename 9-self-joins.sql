-- 1
SELECT COUNT(*)
FROM stops;

-- 2
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 3
SELECT s.id, s.name
FROM stops AS s
JOIN route AS r ON s.id = r.stop
WHERE r.num = '4'
  AND r.company = 'LRT';

-- 4
SELECT r.company, r.num, COUNT(*)
FROM route AS r
JOIN stops AS s ON s.id = r.stop
WHERE s.name IN ('London Road', 'Craiglockhart')
GROUP BY r.company, r.num
HAVING COUNT(*) = 2;

-- 5
SELECT a.company, a.num, a.stop, b.stop
FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 53 AND b.stop = 149;

-- 6
SELECT r.company, r.num, s.name, ss.name
FROM route AS r
JOIN route AS rr ON (r.company = rr.company AND r.num = rr.num)
JOIN stops AS s ON s.id = r.stop
JOIN stops AS ss ON ss.id = rr.stop
WHERE s.name = 'Craiglockhart'
  AND ss.name = 'London Road';

-- 7
SELECT DISTINCT r.company, r.num
FROM route AS r
JOIN route AS rr ON (r.company = rr.company AND r.num = rr.num)
JOIN stops AS s ON s.id = r.stop
JOIN stops AS ss ON ss.id = rr.stop
WHERE s.name = 'Haymarket'
  AND ss.name = 'Leith';

-- 8
SELECT DISTINCT r.company, r.num
FROM route AS r
JOIN route AS rr ON (r.company = rr.company AND r.num = rr.num)
JOIN stops AS s ON s.id = r.stop
JOIN stops AS ss ON ss.id = rr.stop
WHERE s.name = 'Craiglockhart'
  AND ss.name = 'Tollcross';

-- 9
SELECT DISTINCT s.name, r.company, r.num
FROM route AS r
JOIN route AS rr ON (r.company = rr.company AND r.num = rr.num)
JOIN stops AS s ON s.id = r.stop
JOIN stops AS ss ON ss.id = rr.stop
WHERE r.company = 'LRT'
  AND ss.name = 'Craiglockhart';

-- 10
SELECT
  c.num AS num1,
  c.company AS company1,
  c.name,
  l.num AS num2,
  l.company AS company2
FROM (SELECT r.num, r.company, s.name
      FROM route AS r
      JOIN route AS rr ON (r.num = rr.num AND r.company = rr.company)
      JOIN stops AS s ON s.id = r.stop
      JOIN stops AS ss ON ss.id = rr.stop
      WHERE ss.name = 'Craiglockhart') AS c
JOIN (SELECT s.name, rr.num, rr.company
      FROM route AS r
      JOIN route AS rr ON (r.num = rr.num AND r.company = rr.company)
      JOIN stops AS s ON s.id = r.stop
      JOIN stops AS ss ON ss.id = rr.stop
      WHERE ss.name = 'Lochend') AS l
ON c.name = l.name;
