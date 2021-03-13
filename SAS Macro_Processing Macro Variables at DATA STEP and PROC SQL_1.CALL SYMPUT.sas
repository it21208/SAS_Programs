/*Processing Macro Variables at Execution Time: 
Because the macro facility performs its tasks before SAS programs execute, the
information that the macro facility supplies does not depend on values that are accessed
or computed during the execution of a SAS program. However, sometimes it is
necessary to access or create macro variables during the execution of a SAS program. 
In this chapter, you learn to use macro variables during execution of the following:
• a DATA step
• a PROC SQL step
 
The SYMPUT Routine:
The DATA step provides functions and a CALL routine that enable you to transfer
information between an executing DATA step and the macro processor. You can use the
SYMPUT routine to create a macro variable and to assign to that variable any value that
is available in the DATA step.

General form, SYMPUT routine:
CALL SYMPUT(macro-variable,text);

macro-variable is assigned the character value of text.*/

/* You can use the SYMPUT routine in different situations:
(1) Using SYMPUT with a Literal
To use a literal with the SYMPUT routine, you enclose the literal string in quotation
marks.

CALL SYMPUT('macro-variable', 'text');

(2) Using SYMPUT with a DATA Step Variable
You can assign the value of a DATA step variable as the value for a macro variable by
using the DATA step variable's name as the second argument to the SYMPUT routine.
You do not enclose the name of the DATA step variable in quotation marks.

CALL SYMPUT('macro-variable',DATA-step-variable);

(3) Using CALL SYMPUT with DATA Step Expressions
Often you want to combine several DATA step functions in order to create a DATA step
expression as the second argument of the SYMPUT routine.

CALL SYMPUT('macro-variable',expression);

Note: A DATA step expression can be any combination of DATA step functions, DATA
step variables, constants, and logical or arithmetic operators that resolves to a
character or numeric constant. Numeric expressions are automatically converted 
to character constants using the BEST12. format.
*/

option symbolgen;
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

proc sql;
create table ave_sdata as
   select *, 
   		round (mean (score1, score2, score3 ),.1) as score_mean,
   		max(calculated score_mean) as max_mean, 
   		min(calculated score_mean) as min_mean
   from score_data;
quit;

data ave_sdata1;
 set ave_sdata;
 call symput('foot','With Average Score Information '); /*(1)*/
 call symput ('max', max_mean); /*(2)*/
 call symput ('min', round (min_mean, 1));  /*(3)*/
 drop min_mean max_mean;
run;
proc print data=ave_sdata1;
 title "student score information";
 footnote1 "&foot: range from &min to &max";
run;









