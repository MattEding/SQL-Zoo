-- 1
-- How many stops are in the database.
SELECT COUNT(*)
FROM stops;

-- 2
-- Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 3
-- Give the id and the name for the stops on the '4' 'LRT' service.
SELECT s.id, s.name
FROM stops AS s
JOIN route AS r ON s.id = r.stop
WHERE r.num = '4'
  AND r.company = 'LRT';

-- 4
-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
-- Run the query and notice the two services that link these stops have a count of 2.
-- Add a HAVING clause to restrict the output to these two routes.
SELECT r.company, r.num, COUNT(*)
FROM route AS r
JOIN stops AS s ON s.id = r.stop
WHERE s.name IN ('London Road', 'Craiglockhart')
GROUP BY r.company, r.num
HAVING COUNT(*) = 2;

-- 5
-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes.
-- Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 53 AND b.stop = 149;

-- 6
-- The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number.
-- Change the query so that the services between 'Craiglockhart' and 'London Road' are shown.
-- If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT r.company, r.num, s.name, ss.name
FROM route AS r
JOIN route AS rr ON (r.company = rr.company AND r.num = rr.num)
JOIN stops AS s ON s.id = r.stop
JOIN stops AS ss ON ss.id = rr.stop
WHERE s.name = 'Craiglockhart'
  AND ss.name = 'London Road';

-- 7
-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT r.company, r.num
FROM route AS r
JOIN route AS rr ON (r.company = rr.company AND r.num = rr.num)
JOIN stops AS s ON s.id = r.stop
JOIN stops AS ss ON ss.id = rr.stop
WHERE s.name = 'Haymarket'
  AND ss.name = 'Leith';

-- 8
-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT r.company, r.num
FROM route AS r
JOIN route AS rr ON (r.company = rr.company AND r.num = rr.num)
JOIN stops AS s ON s.id = r.stop
JOIN stops AS ss ON ss.id = rr.stop
WHERE s.name = 'Craiglockhart'
  AND ss.name = 'Tollcross';

-- 9
-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by
-- taking one bus, including 'Craiglockhart' itself, offered by the LRT company. 
-- Include the company and bus no. of the relevant services.
SELECT DISTINCT s.name, r.company, r.num
FROM route AS r
JOIN route AS rr ON (r.company = rr.company AND r.num = rr.num)
JOIN stops AS s ON s.id = r.stop
JOIN stops AS ss ON ss.id = rr.stop
WHERE r.company = 'LRT'
  AND ss.name = 'Craiglockhart';

-- 10
-- Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.
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
