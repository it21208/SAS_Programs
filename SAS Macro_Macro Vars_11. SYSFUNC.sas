/*We have learned that by using the automatic macro variables SYSDATE9 (the date of the SAS invocation) and
SYSDAY (the day of the week of the SAS invocation), you can include the date information in a title or footnote;

Suppose you would rather see the date in some other format, or suppose you would rather see the current date or time. You
can use the %SYSFUNC function to execute other SAS functions as part of the macro
facility.

General form, %SYSFUNC function:
%SYSFUNC (function (argument(s)) <,format>)

*function:is the name of the SAS function to execute.
*argument(s): is one or more arguments that are used by function. Use commas to separate all arguments.
*format: is an optional format to apply to the result of function. By default, numeric results are
converted to a character string using the BEST12. format, and character results are used as
they are, without formatting or translation.*/

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

/*Previous program use the automatic macro variables: sysday, sysdate9*/
footnote1 "Created &sysday, &sysdate9";
proc means data = score_data;
title1 "Variable Mean Statistis on score_data";
run;

/*Using %SYSFUNC*/
footnote1 "Created %sysfunc(today(),weekdate.)";
proc means data = score_data;
title1 "Variable Mean Statistis on score_data";
run;
