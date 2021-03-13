/*Creating Macro Variables during PROC SQL Step Execution:

You have seen how to create macro variables during DATA step execution. You can also
create or update macro variables during the execution of a PROC SQL step. The INTO
clause in a SELECT statement enables you to create or update macro variables.

When you create or update macro variables during execution of a PROC SQL step, you
might not want any output to be displayed. The PRINT | NOPPRINT option specifies
whether a SELECT statement's results are displayed in output. PRINT is the default
setting.

General form, PROC SQL with the NOPRINT option and the INTO clause:
PROC SQL NOPRINT;
SELECT column1<,column2,...>
INTO :macro-variable-1<,:macro-variable-2,...>
FROM table-1 | view-1
<WHERE expression>
<other clauses>;
QUIT;

Note: Macro variable names are preceded by a colon.
Also, the INTO clause cannot be used when you create a table or a view.
*/

option symbolgen;
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

proc sql /*NOPRINT*/;
   select max (round (mean (score1, score2, score3 ),.1)) , 
   		  min (round (mean (score1, score2, score3 ),.1))
   into :max_ave, :min_ave
   from score_data;
quit;

proc print data = score_data;
title " Score Average Information: Averages range from &min_ave to &max_ave";
run;





