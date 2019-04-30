-- 1
SELECT name
FROM teacher
where dept is null;

-- 2
SELECT t.name, d.name
FROM teacher AS t
JOIN dept AS d ON t.dept = d.id;

-- 3
SELECT t.name, d.name
FROM teacher AS t
LEFT JOIN dept AS d ON t.dept = d.id;

-- 4
SELECT t.name, d.name
FROM teacher AS t
RIGHT JOIN dept AS d ON t.dept = d.id;

-- 5
SELECT name, COALESCE(mobile, '07986 444 2266')
FROM teacher;

-- 6
SELECT t.name, COALESCE(d.name, 'None')
FROM teacher AS t
LEFT JOIN dept AS d ON t.dept = d.id;

-- 7
SELECT COUNT(name), COUNT(mobile)
FROM teacher;

-- 8
SELECT d.name, COUNT(t.id)
FROM dept AS d
LEFT JOIN teacher AS t ON t.dept = d.id
GROUP BY d.name;

-- 9
SELECT name,
  CASE WHEN dept IN (1, 2)
       THEN 'Sci'
       ELSE 'Art'
  END
FROM teacher;

--= 10
SELECT name,
  CASE WHEN dept IN (1, 2)
       THEN 'Sci'
       WHEN dept = 3
       THEN 'Art'
       ELSE 'None'
  END
FROM teacher;
