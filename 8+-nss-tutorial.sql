-- 1
-- The example shows the number who responded for:
--    question 1
--    at 'Edinburgh Napier University'
--    studying '(8) Computer Science'
--Show the the percentage who STRONGLY AGREE
SELECT A_STRONGLY_AGREE
FROM nss
WHERE question = 'Q01'
  AND institution = 'Edinburgh Napier University'
  AND subject = '(8) Computer Science';

-- 2
-- Show the institution and subject where the score is at least 100 for question 15.
SELECT institution, subject
FROM nss
WHERE score >= 100
  AND question = 'Q15';

-- 3
-- Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15'
SELECT institution, score
FROM nss
WHERE question = 'Q15'
  AND subject = '(8) Computer Science'
  AND score < 50;

-- 4
-- Show the subject and total number of students who responded to question 22 for
-- each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.
SELECT subject, SUM(response)
FROM nss
WHERE subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
  AND question = 'Q22'
GROUP BY subject;

-- 5
-- Show the subject and total number of students who A_STRONGLY_AGREE to question 22
-- for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.
SELECT subject, SUM(response * A_STRONGLY_AGREE / 100)
FROM nss
WHERE question = 'Q22'
  AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

-- 6
-- Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject
-- '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'.
-- Use the ROUND function to show the percentage without decimal places.
SELECT subject, ROUND(SUM(response * A_STRONGLY_AGREE) / SUM(response))
FROM nss
WHERE question = 'Q22'
  AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

-- 7
-- Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name.
-- Give your answer rounded to the nearest whole number.
---- Note: interestingly if using ROUND(AVG(score)),
---- then the second row is off by 1%
SELECT institution, ROUND(SUM(score * response) / SUM(response))
FROM nss
WHERE question = 'Q22'
GROUP BY institution
HAVING institution LIKE '%Manchester%';


-- 8
-- Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'. 
SELECT n.institution, SUM(n.sample), c.comp_st
FROM nss AS n
join (SELECT institution, SUM(sample) AS comp_st
      FROM nss
      WHERE question = 'Q01'
        AND institution LIKE '%Manchester%'
        AND subject = '(8) Computer Science'
      GROUP BY institution) AS c ON n.institution = c.institution
WHERE n.question = 'Q01'
  AND n.institution LIKE '%Manchester%'
GROUP BY n.institution, c.comp_st;
