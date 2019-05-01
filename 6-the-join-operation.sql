-- 1
-- The first example shows the goal scored by a player with the last name 'Bender'.
-- Modify it to show the matchid and player name for all goals scored by Germany.
-- To identify German players, check for: teamid = 'GER'
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- 2
-- From the previous query you can see that Lars Bender's scored a goal in game 1012.
-- Now we want to know what teams were playing in that match.
-- Notice in the that the column matchid in the goal table corresponds to the id column in the game table.
-- We can look up information about game 1012 by finding that row in the game table.
-- Show id, stadium, team1, team2 for just game 1012
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- 3
-- You can combine the two steps into a single query with a JOIN.
-- The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
-- Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM game
JOIN goal ON game.id = goal.matchid
WHERE goal.teamid = 'GER';

-- 4
-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT game.team1, game.team2, goal.player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE goal.player LIKE 'Mario%';

-- 5
-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT g.player, g.teamid, e.coach, g.gtime
FROM goal AS g
JOIN eteam AS e ON g.teamid = e.id
WHERE g.gtime <= 10;

-- 6
-- List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT g.mdate, e.teamname
FROM game AS g
JOIN eteam AS e ON g.team1 = e.id
WHERE e.coach = 'Fernando Santos';

-- 7
-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT goal.player
FROM goal
JOIN game ON game.id = goal.matchid
WHERE game.stadium = 'National Stadium, Warsaw';

-- 8
-- The example query shows all goals scored in the Germany-Greece quarterfinal.
-- Instead show the name of all players who scored a goal against Germany.
SELECT distinct goal.player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE (game.team1 = 'GER' OR game.team2 = 'GER')
  AND goal.teamid != 'GER';

-- 9
-- Show teamname and the total number of goals scored.
SELECT e.teamname, COUNT(*)
FROM eteam AS e
JOIN goal AS g ON e.id = g.teamid
GROUP BY e.teamname;

-- 10
-- Show the stadium and the number of goals scored in each stadium.
SELECT game.stadium, COUNT(*)
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY game.stadium;

-- 11
-- For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT goal.matchid, game.mdate, COUNT(*)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE game.team1 = 'POL'
   OR game.team2 = 'POL'
GROUP BY goal.matchid, game.mdate;

-- 12
-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT goal.matchid, game.mdate, COUNT(*)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE goal.teamid = 'GER'
GROUP BY goal.matchid, game.mdate;

-- 13
-- List every match with the goals scored by each team as shown.
-- This will use "CASE WHEN" which has not been explained in any previous exercises.
-- Sort your result by mdate, matchid, team1 and team2.
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

-- 14
