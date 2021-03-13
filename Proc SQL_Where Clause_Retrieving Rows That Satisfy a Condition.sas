/*Retrieving Rows That Satisfy a Condition: Where Clause

The WHERE clause enables you to retrieve only rows from a table that satisfy a condition. 
WHERE clauses can contain any of the columns in a table, including columns that are not selected.*/

proc import datafile = "/folders/myfolders/score_data_miss_one" 
DBMS = xlsx out = score_data ;
run;

/*(1)You can use comparison operators in a WHERE clause to select different subsets of data.

Symbol					Mnemonic Equivalent		Definition
=						EQ						equal to
^= or ~= or ¬= or <>	NE						not equal to
>						GT						greater than
<						LT						less than
>=						GE						greater than or equal to
<=						LE						less than or equal to
*/

proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      where calculated score_ave >= 0
      order by score_ave;
quit; 

/*(2) You can use logical operators to construct a WHERE clause that contains two or more expressions.
You can use parentheses to improve the readability of WHERE clauses that contain multiple expressions.

Symbol			Mnemonic Equivalent
&				AND
! or | or:		OR
^ or ~ or ¬		NOT

*/

proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      where calculated score_ave >= 0 and gender = 'f'
      order by score_ave;
quit; 

/*(3)Using Other Conditional Operators
 Note:  All of these operators can be prefixed with the NOT operator to form a negative condition.*/

/*Using the IN Operator
The IN operator enables you to include values within a list that you supply. */

proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      where  gender in ('f', 'm')
      order by score_ave;
quit; 

/*Using the IS MISSING (IS NULL) Operator
The IS MISSING operator enables you to identify rows that contain columns with missing values.*/
proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      where  calculated score_ave is missing
      order by score_ave;
quit; 

/*Using the BETWEEN-AND Operators
To select rows based on a range of values, you can use the BETWEEN-AND operators.
Because the BETWEEN-AND operators are inclusive, 
the values that you specify in the BETWEEN-AND expression are included in the results. */
proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      where  calculated score_ave between 70 and 100
      order by score_ave;
quit; 

/*Using the LIKE Operator
The LIKE operator enables you to select rows based on pattern matching.

the following query returns all names that begin with the letter T and are any number of 
characters long, 
or end with the letter a and are 4 characters long 

The percent sign (%) and underscore (_) are wildcard characters.
more info at
http://support.sas.com/documentation/cdl/en/proc/61895/HTML/default/viewer.htm#a002473693.htm */

proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      where Name like 'T%' or Name like '___a'
      order by score_ave;
quit; 

/*Using Truncated String Comparison Operators
Truncated string comparison operators are used to compare two strings. 
PROC SQL truncates the longer string to be the same length as the shorter string. 

Truncated String Comparison Operators:
Symbol	Definition
EQT		equal to truncated strings
GTT		greater than truncated strings
LTT		less than truncated strings
GET		greater than or equal to truncated strings
LET		less than or equal to truncated strings
NET		not equal to truncated strings
*/

proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      where Name eqt 'Ja'
      order by score_ave;
quit; 

/*Using a WHERE Clause with Missing Values
If a column that you specify in a WHERE clause contains missing values, 
then a query might provide unexpected results. */

proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      where calculated score_ave lt 60
      order by score_ave;
quit; /*I only want to include the students TRULY below 60*/

proc sql;
   select *, sum (score1, score2, score3 )/3 as score_ave
      from score_data
      where calculated score_ave lt 60 and calculated score_ave is not missing
      order by score_ave;
quit;
