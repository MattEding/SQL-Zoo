-- 1
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- 2
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- 3
SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM game
JOIN goal ON game.id = goal.matchid
WHERE goal.teamid = 'GER';

-- 4
SELECT game.team1, game.team2, goal.player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE goal.player LIKE 'Mario%';

-- 5
SELECT g.player, g.teamid, e.coach, g.gtime
FROM goal AS g
JOIN eteam AS e ON g.teamid = e.id
WHERE g.gtime <= 10;

-- 6
SELECT g.mdate, e.teamname
FROM game AS g
JOIN eteam AS e ON g.team1 = e.id
WHERE e.coach = 'Fernando Santos';

-- 7
SELECT goal.player
FROM goal
JOIN game ON game.id = goal.matchid
WHERE game.stadium = 'National Stadium, Warsaw';

-- 8
SELECT distinct goal.player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE (game.team1 = 'GER' OR game.team2 = 'GER')
  AND goal.teamid != 'GER';

-- 9
SELECT e.teamname, COUNT(*)
FROM eteam AS e
JOIN goal AS g ON e.id = g.teamid
GROUP BY e.teamname;

-- 10
SELECT game.stadium, COUNT(*)
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY game.stadium;

-- 11
SELECT goal.matchid, game.mdate, COUNT(*)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE game.team1 = 'POL'
   OR game.team2 = 'POL'
GROUP BY goal.matchid, game.mdate;

-- 12
SELECT goal.matchid, game.mdate, COUNT(*)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE goal.teamid = 'GER'
GROUP BY goal.matchid, game.mdate;

-- 13
SELECT
  game.mdate,
  game.team1,
  SUM(CASE WHEN game.team1 = goal.teamid THEN 1 ELSE 0 END) AS score1,
  game.team2,
  SUM(CASE WHEN game.team2 = goal.teamid THEN 1 ELSE 0 END) AS score2
FROM game
LEFT JOIN goal ON game.id = goal.matchid
GROUP BY game.mdate, goal.matchid, game.team1, game.team2
ORDER BY game.mdate, goal.matchid, game.team1, game.team2;
