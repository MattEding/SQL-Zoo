-- 1
SELECT A_STRONGLY_AGREE
FROM nss
WHERE question = 'Q01'
  AND institution = 'Edinburgh Napier University'
  AND subject = '(8) Computer Science';

-- 2
SELECT institution, subject
FROM nss
WHERE score >= 100
  AND question = 'Q15';

-- 3
SELECT institution, score
FROM nss
WHERE question = 'Q15'
  AND subject = '(8) Computer Science'
  AND score < 50;

-- 4
SELECT subject, SUM(response)
FROM nss
WHERE subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
  AND question = 'Q22'
GROUP BY subject;

-- 5
SELECT subject, SUM(response * A_STRONGLY_AGREE / 100)
FROM nss
WHERE question = 'Q22'
  AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

-- 6
SELECT subject, ROUND(SUM(response * A_STRONGLY_AGREE) / SUM(response))
FROM nss
WHERE question = 'Q22'
  AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

-- 7
-- interestingly if using ROUND(AVG(score)),
-- then the second row is off by 1%
SELECT institution, ROUND(SUM(score * response) / SUM(response))
FROM nss
WHERE question = 'Q22'
GROUP BY institution
HAVING institution LIKE '%Manchester%';


-- 8
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
