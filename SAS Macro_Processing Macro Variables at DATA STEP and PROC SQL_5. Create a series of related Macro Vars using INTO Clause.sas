/*Creating a series of related Macro Variables with the INTO Clause:
Earlier you learned how to create a series of related macro variables during execution of
the DATA step by using the SYMPUT routine. Sometimes you might want to create a
series of related macro variables during execution of a PROC SQL step. You can use the
INTO clause to create one new macro variable for each row/observation in the result of the SELECT
statement.

General form, SELECT statement with the INTO clause for a range of macro variables:
PROC SQL NOPRINT;
SELECT column1
INTO :macro-variable-1 - :macro-variable-n
 FROM table-1 | view-1
<WHERE expression>
<other clauses>;
QUIT;

*/

option symbolgen;
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

/* the macro variables sid1-sid3 are assigned values of the data set variable
Stu_id from each of the first three rows of the PROC SQL result*/
proc sql;
 select stu_id, name
 into :sid1-:sid3,
 :stu_name1-:stu_name3
 from score_data;
 %put _user_;
quit;

proc print data=score_data;
 where stu_id = &sid1;
 var name gender score1 score2 score3;
 title1 "Individual Student Score Information for Student &sid1";
 footnote1 "Score Information for &stu_name1";
run;