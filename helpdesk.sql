-- 1
-- There are three issues that include the words "index" and "Oracle".
-- Find the call_date for each of them
SELECT call_date, call_ref
FROM Issue
WHERE detail LIKE '%index%'
  AND detail LIKE '%Oracle%';

-- 2
-- Samantha Hall made three calls on 2017-08-14.
-- Show the date and time for each
SELECT i.call_date, c.first_name, c.last_name
FROM Issue AS i
JOIN Caller AS c ON c.caller_id = i.caller_id
WHERE c.first_name = 'Samantha'
  AND c.last_name = 'Hall'
  AND DATE(i.call_date) = '2017-08-14';

-- 3
-- There are 500 calls in the system (roughly).
-- Write a query that shows the number that have each status.
SELECT status, COUNT(*) AS volume
FROM Issue
WHERE status IS NOT NULL
GROUP BY status

-- 4
-- Calls are not normally assigned to a manager but it does happen.
-- How many calls have been assigned to staff who are at Manager Level?
SELECT COUNT(*) AS mlcc
FROM Issue AS i
JOIN Staff AS s ON s.staff_code = i.assigned_to
JOIN Level AS l ON l.level_code = s.level_code
WHERE l.manager = 'Y'

-- 5
-- Show the manager for each shift.
-- Your output should include the shift date and type; also the first and last name of the manager.
SELECT sh.shift_date, sh.shift_type, st.first_name, st.last_name
from Shift AS sh
JOIN Staff AS st ON sh.manager = st.staff_code
ORDER BY sh.shift_date;

-- 6
-- List the Company name and the number of calls for those companies with more than 18 calls.
SELECT cu.company_name, COUNT(*) AS cc
FROM Customer AS cu
JOIN Caller AS ca ON cu.company_ref = ca.company_ref
JOIN Issue AS i ON i.caller_id = ca.caller_id
GROUP BY cu.company_name
HAVING COUNT(*) > 18;

-- 7
-- Find the callers who have never made a call. Show first name and last name
SELECT c.first_name, c.last_name
FROM Caller AS c
LEFT JOIN Issue AS i ON i.caller_id = c.caller_id
WHERE i.call_date IS NULL;

-- 8
-- For each customer show: Company name, contact name, number of calls where the number of calls is fewer than 5
SELECT company_name, first_name, last_name, num_calls
FROM (SELECT company_name, contact_id, COUNT(*) AS num_calls
      FROM Customer
      NATURAL JOIN Caller
      NATURAL JOIN Issue
      GROUP BY company_name, contact_id
      HAVING count(*) < 5
      ORDER BY company_name) AS _
JOIN Caller on caller_id = contact_id;

-- 9
-- For each shift show the number of staff assigned.
-- Beware that some roles may be NULL and that the same person might have been assigned to multiple roles
-- (The roles are 'Manager', 'Operator', 'Engineer1', 'Engineer2').
SELECT shift_date, shift_type, COUNT(staff_code) AS staff_count
FROM (SELECT shift_date, shift_type, manager AS staff_code FROM Shift
      UNION SELECT shift_date, shift_type, operator AS staff_code  FROM Shift
      UNION SELECT shift_date, shift_type, engineer1 AS staff_code  FROM Shift
      UNION SELECT shift_date, shift_type, engineer2 AS staff_code  FROM Shift) AS _
GROUP BY shift_date, shift_type;

-- 10
-- Caller 'Harry' claims that the operator who took his most recent call was abusive and insulting.
-- Find out who took the call (full name) and when.