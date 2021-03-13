/*Using User-Defined Macro Variables::
The simplest way to define your own macro variables is to use a %LET statement. The
%LET statement enables you to define a macro variable and to assign a value to it.

General form, %LET statement:
%LET variable = value;

variable: is any name that follows the SAS naming convention.
value: can be any string from 0 to 65,534 characters.
variable or value: if either contains a reference to another macro variable (such as &macvar), 
the reference is evaluated before the assignment is made.
Note: If variable already exists, value replaces the current value

When you use the %LET statement to define macro variables, you should keep in mind
the following rules:
• All values are stored as character strings.
• Mathematical expressions are not evaluated.
e.g. %let sum=4+3; variable value 4+3 
• The case of the value is preserved.
• Quotation marks that enclose literals are stored as part of the value.
e.g. %let title="Joan's Report"; variable value "Joan's Report"
• Leading and trailing blanks are removed from the value before the assignment is
made.*/

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

%let title = "Average of Scores";
%let x = score1 score2 score3;
proc means data = score_data;
var &x;
title &title;
run;

title "Average of Scores";



