/*Filtering Grouped Data

Overview of Filtering Grouped Data:
You can use a HAVING clause with a GROUP BY clause to filter grouped data. 
The HAVING clause affects groups in a way that is similar to how a WHERE clause 
affects individual rows. When you use a HAVING clause, 
PROC SQL displays only the groups that satisfy the HAVING expression.*/

/*Using a Simple HAVING Clause*/
proc import datafile = "/folders/myfolders/score_data_miss_with class info_MJ" 
DBMS = xlsx out = score_data_class_MJ ;
run;

proc sql;
   select *, mean (score1, score2, score3 ) as score_mean,
   max (calculated score_mean) as max_mean, min(calculated score_mean)as min_mean
      from score_data_class_MJ
      group by gender
      having gender is not missing;
quit;

/*Choosing between HAVING and WHERE 
A HAVING clause is like a WHERE clause for groups.

Note:  If you use a HAVING clause without a GROUP BY clause and if the query references 
at least one aggregate function, PROC SQL treats the input data as if it all comes from 
a single group of data.

HAVING clause attributes
(1) is typically used to specify conditions for including or excluding groups of rows 
from a table.
(2) must follow the GROUP BY clause in a query, if used with a GROUP BY clause.
(3) is affected by a GROUP BY clause, when there is no GROUP BY clause, 
the HAVING clause is treated like a WHERE clause.
(4) is processed after the GROUP BY clause and any aggregate functions.

WHERE clause attributes
(1) is used to specify conditions for including or excluding individual rows from a table.
(2) must precede the GROUP BY clause in a query, if used with a GROUP BY clause.
(3) is not affected by a GROUP BY clause.
(4) is processed before a GROUP BY clause, if there is one, and before any aggregate functions.
*/

/*Using HAVING with Aggregate Functions*/
proc sql;
   select *, mean (score1, score2, score3 ) as score_mean,
   max (calculated score_mean) as max_mean, min(calculated score_mean)as min_mean
      from score_data_class_MJ
      group by gender, class
      having gender is not missing and min(calculated score_mean) >= 60;
quit;

