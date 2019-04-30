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
  and question = 'Q15';

-- 3
SELECT institution, score
FROM nss
WHERE question = 'Q15'
  AND subject = '(8) Computer Science'
  and score < 50;

-- 4
select subject, sum(response)
from nss
where subject in ('(8) Computer Science', '(H) Creative Arts and Design')
  and question = 'Q22'
group by subject;

-- 5
select subject, sum(response * A_STRONGLY_AGREE / 100)
from nss
where question = 'Q22'
  and subject in ('(8) Computer Science', '(H) Creative Arts and Design')
group by subject;

-- 6
select subject, round(sum(response * A_STRONGLY_AGREE) / sum(response))
from nss
where question = 'Q22'
  and subject in ('(8) Computer Science', '(H) Creative Arts and Design')
group by subject;

-- 7
-- interestingly if using ROUND(AVG(score)),
-- then the second row is off by 1%
select institution, round(sum(score * response) / sum(response))
from nss
where question = 'Q22'
group by institution
having institution like '%Manchester%';


-- 8
select n.institution, sum(n.sample), c.comp_st
from nss as n
join (select institution, sum(sample) as comp_st
      from nss
      where question = 'Q01'
        and institution like '%Manchester%'
        and subject = '(8) Computer Science'
      group by institution) as c on n.institution = c.institution
where n.question = 'Q01'
  and n.institution like '%Manchester%'
group by n.institution, c.comp_st
