/*sorting data --- Order By clause*/

/*Overview:
(1) When you use an ORDER BY clause, you change the order of the output but not the order of 
the rows that are stored in the table.

(2) The PROC SQL default sort order is ascending.
To order the results, specify ASC for ascending or DESC for descending. 

(3) You can specify a sort order for each column in the ORDER BY clause.
When you specify multiple columns in the ORDER BY clause, 
the first column determines the primary row order of the results. 
Subsequent columns determine the order of rows that have the same value for the primary sort.

(4) PROC SQL sorts nulls, or missing values, before character or numeric data. 
Therefore, when you specify ascending order, missing values appear first in the query results. 
*/


/*************SAS PROGRAMS starts here******************************************/

proc import datafile = "/folders/myfolders/score_data_miss" 
DBMS = xlsx out = score_data ;
run;

/*sort by one or multiple coulumns (the column names separated by commas)
Note: The results list stduent with missing Gender first 
because PROC SQL sorts missing values first in an ascending sort.*/
proc sql;
select *
from score_data
order by Gender, Name desc;
quit;

/*Sorting by Calculated Column
You can sort by a calculated column by specifying its alias in the ORDER BY clause. */
proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      order by score_ave;
quit;      

/*Sorting by Column Position
You can sort by any column within the SELECT clause by specifying its numerical position. 
By specifying a position instead of a name, 
you can sort by a calculated column that has no alias*/

proc sql;
   select name, score1, score2, score3,gender, sum (score1, score2, score3 )/3 /*as score_ave*/
      from score_data
      order by 6;
quit;

/*Sorting by Columns That Are Not Selected
You can sort query results by columns that are not included in the query. */
proc sql;
   select name, score1, score2, score3,/*gender*/ sum (score1, score2, score3 )/3 /*as score_ave*/
      from score_data
      order by gender desc, 5; /*need to change the position of the calculated column*/
quit;














