/*Selecting Data from More Than One Table By Using Joins:

Overview of Selecting Data from More Than One Table By Using Joins:
The data that you need for a report could be located in more than one table. 
Joining tables enables you to select data from multiple tables as if the data 
were contained in one table. Joins do not alter the original tables.*/

/*There are two types of joins:
	Inner Joins return a result table for all the rows in a table that have one or more 
matching rows in the other table/tables that are listed in the FROM clause.
	Outer Joins are inner joins that are augmented with rows that did not match with any 
row from the other table in the join. There are three types of outer joins: left, right, and full.
*/


/*********************************Inner Join*****************************************/

/*An inner join returns only the subset of rows from the first table that matches rows from 
the second table. You can specify the columns that you want to be compared for matching values 
in a WHERE clause.*/

proc import datafile = "/folders/myfolders/score_data_id_no_gender_1l" 
DBMS = xlsx out = score_data_ng ;
run; /*stu_id = 5 in not included*/

proc import datafile = "/folders/myfolders/score_data_id_gender_only_1l" 
DBMS = xlsx out = score_data_g ;
run; /*stu_id = 11 in not included*/

/*Note that the column names in the SELECT and the WHERE clause are prefixed by their table names 
or table aliases. This is known as qualifying the column names, and it is necessary when you specify 
columns that have the same name from more than one table. Qualifying the column name avoids creating 
an ambiguous column reference.*/
/*You can order the output of joined tables by one or more columns from either table. */
proc sql;
   SELECT g.stu_id, g.Name ,
          score1, 
          score2, 
          score3,
          gender   
   FROM score_data_g AS g,  score_data_ng AS ng
   where g.stu_id =  ng.stu_id
   order by stu_id;
quit; /*both stu_id = 5 and 11 are not in the result table*/

/*Creating Inner Joins Using INNER JOIN Keywords
The INNER JOIN keywords can be used to join tables. The ON clause replaces the WHERE clause 
for specifying columns to join. PROC SQL provides these keywords primarily for 
compatibility with the other joins (OUTER, RIGHT, and LEFT JOIN). 
Using INNER JOIN with an ON clause provides the same functionality as listing tables 
in the FROM clause and specifying join columns with a WHERE clause.*/

proc sql;
   SELECT g.stu_id, g.Name ,
          score1, 
          score2, 
          score3,
          gender 
   FROM score_data_g AS g INNER JOIN  score_data_ng AS ng
   ON g.stu_id =  ng.stu_id
   order by stu_id;
quit;

/*Joining Tables Using Comparison Operators
Tables can be joined by using comparison operators other than the equal sign (=) 
in the WHERE clause. 

In log, 
NOTE: The execution of this query involves performing one or more Cartesian product joins 
that can not be optimized.

you see this message when you run a query that joins tables without specifying matching columns 
in a WHERE clause. PROC SQL also displays this message whenever tables are joined by using an 
inequality operator.*/
proc sql;
   SELECT g.stu_id, g.Name ,
          score1, 
          score2, 
          score3,
          gender   
   FROM score_data_g AS g,  score_data_ng AS ng
   where g.stu_id <  ng.stu_id and ng.stu_id =7 
   order by stu_id;
quit;

/*The Effects of Null Values on Joins
Most database products treat nulls as distinct entities and do not match them in joins. 
PROC SQL treats nulls as missing values and as matches for joins. 
Any null will match with any other null of the same type (character or numeric) in a join.
therefore, the result is probably not the intended result for the join.

The tables contain stu_id = . */
proc import datafile = "/folders/myfolders/score_data_id_no_gender_1l_missingID" 
DBMS = xlsx out = score_data_ng_m ;
run; 

proc import datafile = "/folders/myfolders/score_data_id_gender_only_1l_missingID" 
DBMS = xlsx out = score_data_g_m;
run; 
proc sql;
   SELECT g.stu_id, g.Name ,
          score1, 
          score2, 
          score3,
          gender   
   FROM score_data_g_m AS g,  score_data_ng_m AS ng
   where g.stu_id =  ng.stu_id
   order by stu_id;
quit; 

proc print data = score_data_ng_m ;run;
proc print data = score_data_g_m;run;


/*In order to specify only the nonmissing values for the join, use the IS NOT MISSING operator:*/
proc sql;
   SELECT g.stu_id, g.Name ,
          score1, 
          score2, 
          score3,
          gender   
   FROM score_data_g_m AS g,  score_data_ng_m AS ng
   where g.stu_id =  ng.stu_id and g.stu_id is not missing and ng.stu_id is not missing
   order by stu_id;
quit; 
proc print data = score_data_ng_m ;run;
proc print data = score_data_g_m;run;

/*Creating Multicolumn Joins/Using Multiple Matching Columns to join
When a row is distinguished by a combination of values in more than one column, 
use all the necessary columns in the join. */

/*
proc import datafile = "/folders/myfolders/score_data_id_no_gender_1l" 
DBMS = xlsx out = score_data_ng ;
run; /*stu_id = 5 in not included*/

proc import datafile = "/folders/myfolders/score_data_id_gender_only_1l_dup id" 
DBMS = xlsx out = score_data_g_dupID ;
run; /*stu_id = 11 in not included, with dup id*/

/*unexpected results --- error/incorrect matching when dup id exist*/
proc sql;
   SELECT g.stu_id, g.Name ,
          score1, 
          score2, 
          score3,
          gender   
   FROM score_data_g_dupID AS g,  score_data_ng AS ng
   where g.stu_id =  ng.stu_id
   order by stu_id;
quit;
proc print data = score_data_ng;run;
proc print data = score_data_g_dupID;run;

/*to correct this: by also joining the Name columns together */ 
proc sql;
   SELECT g.stu_id, g.Name ,
          score1, 
          score2, 
          score3,
          gender   
   FROM score_data_g_dupID AS g,  score_data_ng AS ng
   where g.stu_id =  ng.stu_id and g.name = ng.name
   order by stu_id;
quit;
proc print data = score_data_ng;run;
proc print data = score_data_g_dupID;run;

/*Selecting Data from More Than Two Tables
The data that you need could be located in more than two tables. */

/*
proc import datafile = "/folders/myfolders/score_data_id_no_gender_1l" 
DBMS = xlsx out = score_data_ng ;
run; /*stu_id = 5 in not included*/

/*
proc import datafile = "/folders/myfolders/score_data_id_gender_only_1l" 
DBMS = xlsx out = score_data_g ;
run; /*stu_id = 11 in not included*/

proc import datafile = "/folders/myfolders/score_data_name_class" 
DBMS = xlsx out = score_data_name_class replace ;
run;

proc sql;
   SELECT g.stu_id, g.Name ,
          score1, 
          score2, 
          score3,
          gender   , class
   FROM score_data_g AS g,  score_data_ng AS ng, score_data_name_class as c
   where g.stu_id =  ng.stu_id and c.name = g.name and c.name = ng.name
   order by stu_id;
quit; 

proc print data = score_data_ng ;run;
proc print data = score_data_g;run;
proc print data = score_data_name_class;run;

/*Showing Relationships within a Single Table Using Self-Joins
When you need to show comparative relationships between values in a table, it is sometimes necessary 
to join columns within the same table. Joining a table to itself is called a self-join, or reflexive join. 
You can think of a self-join as PROC SQL making an internal copy of a table and joining the table to its copy.*/

/*
proc import datafile = "/folders/myfolders/score_data_id_no_gender_1l" 
DBMS = xlsx out = score_data_ng ;
run; /*stu_id = 5 in not included*/

proc sql;
   SELECT ng1.stu_id, ng1.Name ,ng1.score2, ng1.score3,
   		  ng2.stu_id, ng2.Name ,ng2.score2, ng2.score3
   FROM score_data_ng AS ng1,  score_data_ng AS ng2
   where ng1.score2 = ng2.score3 and ng1.score2 is not missing and ng2.score3 is not missing;
quit; 





