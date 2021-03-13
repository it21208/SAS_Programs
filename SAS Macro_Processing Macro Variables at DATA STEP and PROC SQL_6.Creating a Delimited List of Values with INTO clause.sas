/*Creating one macro variable holding a Delimited List of Values with INTO clause
Sometimes, during execution of a PROC SQL step, you might want to create one macro
variable that holds all values of a certain data set variable. You can use an alternate form
of the INTO clause in order to take all of the values of a column (variable) and
concatenate them into the value of one macro variable.

General form, SELECT statement with INTO clause for combining values into one macro
variable:
PROC SQL NOPRINT;
SELECT column1
INTO :macro-variable-1
SEPARATED BY 'delimiter1'
FROM table-1 | view-1
<WHERE expression>
<other clauses>;
QUIT;

delimiter1: is enclosed in quotation marks and specifies the character that is used 
as a delimiter in the value of the macro variable.

This form of the INTO clause removes leading and trailing blanks from each value
before performing the concatenation of values.*/

option symbolgen;
proc import datafile = "/folders/myfolders/score_data_id_class" 
DBMS = xlsx out = score_data replace ;
run;

/*use the SQL procedure to create one macro variable named class_info that contains
the values of data set var Class. The classes are separated by blanks.*/
proc sql; 
 select distinct class 
 into :class_info separated by ' '
 from score_data;
quit;

proc means data=score_data maxdec=0;
 var score1 score2 score3;
 title2 "Score Information from Classes: &class_info";
run;

