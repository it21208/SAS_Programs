/*Using Subqueries to Select Data
A table join combines multiple tables into a new table. A subquery (enclosed in parentheses) 
selects rows from one table based on values in another table. A subquery, or inner query, 
is a query expression that is nested as part of another query expression. Depending on the 
clause that contains it, a subquery can return a single value or multiple values. Subqueries 
are most often used in the WHERE and the HAVING expressions. */

/*Single-Value Subqueries:
A single-value subquery returns a single row and column. It can be used in a WHERE 
or HAVING clause with a comparison operator. The subquery must return only one value, 
or else the query fails and an error message is printed to the log.*/

proc import datafile = "/folders/myfolders/score_data_id_class" 
DBMS = xlsx out = score_data_c replace;
run; 

proc import datafile = "/folders/myfolders/score average by class" 
DBMS = xlsx out = score_ave_class replace;
run; 

proc sql;
title " students' score means >= the average score of class a"; 
select * , mean (score1, score2, score3) as stu_smean
from score_data_c
where calculated stu_smean >= (select score_average from score_ave_class
					where class = 'a');
quit;

/*Multiple-Value Subqueries:
A multiple-value subquery can return more than one value from one column. It is used in 
a WHERE or HAVING expression that contains IN or a comparison operator that is modified 
by ANY or ALL. */

proc sql;
title " students in the classes with class level score averages"; 
select * , mean (score1, score2, score3) as stu_smean
from score_data_c
where class in  (select class from score_ave_class);
quit;

/*Testing for the Existence of a Group of Values: 
The EXISTS condition tests for the existence of a set of values. An EXISTS condition 
is true if any rows are produced by the subquery, and it is false if no rows are produced. 
Conversely, the NOT EXISTS condition is true when a subquery produces an empty table*/

proc sql;
*title " students in the classes with class level score averages"; 
select * , mean (score1, score2, score3) as stu_smean
from score_data_c
where exists /*class in*/  (select class from score_ave_class);
quit;

proc sql;
*title " students in the classes with class level score averages"; 
select * , mean (score1, score2, score3) as stu_smean
from score_data_c
where NOT exists /*class in*/  (select class from score_ave_class);
quit;

/*Correlated Subqueries:
The previous subqueries have been simple subqueries that are self-contained and that 
execute independently of the outer query. A correlated subquery requires a value or 
values to be passed to it by the outer query. After the subquery runs, it passes the 
results back to the outer query. Correlated subqueries can return single or multiple values.*/

proc sql;
title "students' score averages greater or equal than the avarage score of his/her class"; 
select * , mean (score1, score2, score3) as stu_smean
from score_data_c as stu
where calculated stu_smean >= (select score_average from score_ave_class as cla
					where stu.class = cla.class );
					/*the outer query passes stu.class to the subquery to obtain the correct score_average*/
quit;

/*want to include the class average in the result for easy comparison*/
proc sql;
title "students' score averages greater or equal than the avarage score of his/her class 
+ class level score average information";
select * , mean (score1, score2, score3) as stu_smean
from score_data_c as stu, score_ave_class as cla
where stu.class = cla.class and calculated stu_smean >= 
								(select score_average from score_ave_class as cla
									where stu.class = cla.class );
quit;/****this is also an example of Combining a Join with a Subquery:
You can combine joins and subqueries in a single query. ****/

/*Multiple Levels of Subquery Nesting
Subqueries can be nested so that the innermost subquery returns a value or values to be used by 
the next outer query. Then, that subquery's value or values are used by the next outer query, 
and so on. Evaluation always begins with the innermost subquery and works outward.*/

proc sql;
title "students' score averages greater or equal than the avarage score of his/her class 
+ class level score average information + only select classes with class-average > 70";
select * , mean (score1, score2, score3) as stu_smean
from score_data_c as stu, score_ave_class as cla
where stu.class = cla.class and calculated stu_smean >=    /*3*/ 
									(select score_average from score_ave_class as cla /*2*/
										where stu.class = cla.class  and cla.class in 
											(select cla.class from score_ave_class as cla /*1*/
												where score_average > 70));
quit;





