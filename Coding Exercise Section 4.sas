PROC IMPORT datafile = "/folders/myfolders/sale_by_state_miss" 
DBMS = xlsx OUT = sale_data REPLACE;
RUN;

/* 
Instruction:
1. obtain distinct year of the data
2. calculate sale mean from variables sale1 - 3 
maxium and minum of sale mean of each state
3. create sale group using
>= 900: Top
between 600 to 900: Meet
below 600 : need improve
4. only include the records with non-missing sale mean in the output table
5. sort the output table by state, then by sale group
 */

PROC SQL;
SELECT DISTINCT year
FROM sale_data;
QUIT;

PROC SQL;
CREATE TABLE solution AS
SELECT DISTINCT *,
                ROUND(MEAN(sale1, sale2, sale3),1) AS meanSales123,
                MAX(Calculated meanSales123) AS max_meanSales123, 
                MIN(Calculated meanSales123) AS min_meanSales123,
                CASE
                    WHEN Calculated meanSales123 >= 900 THEN "Top" 
                    WHEN 600 <= Calculated meanSales123 < 900 THEN "Meet" 
                    WHEN Calculated meanSales123 < 600 THEN "need improve"
                    ELSE 'no data'
                END AS sale_group
FROM work.sale_data
WHERE Calculated meanSales123 IS NOT missing
GROUP BY state
ORDER BY state, sale_group;
QUIT;

PROC PRINT data = solution;
TITLE 'solution for coding exercise from section 4 udemy course';
RUN;
