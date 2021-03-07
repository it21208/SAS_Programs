PROC IMPORT datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data2 REPLACE;
RUN;

PROC SQL;
CREATE TABLE scoredata0 AS
SELECT *,
       mean(score3) as score3_avg
FROM score_data2
GROUP BY gender
HAVING gender = 'f'
ORDER BY gender;
QUIT;

PROC PRINT data = scoredata0;
TITLE ' avg score3 data from PROC SQL';
RUN;
