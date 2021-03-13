/*Displaying Macro Variable Values in the SAS Log:
When debugging your programs, sometimes it is useful for you to
see the value that replaces your macro variable reference. 
You can use the SYMBOLGEN system option to monitor the value that is substituted for a macro
variable reference.

General form, OPTIONS statement with SYMBOLGEN option:
OPTIONS NOSYMBOLGEN | SYMBOLGEN;

Here is an explanation of the syntax:
NOSYMBOLGEN
specifies that log messages about macro variable references are not displayed. This is the
default.
SYMBOLGEN
specifies that log messages about macro variable references are displayed.

when the SYMBOLGEN option is turned on, SAS writes a message to the
log for each macro variable that is referenced in your program. The message states the
macro variable name and the resolved value.*/

OPTIONS SYMBOLGEN;

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

%let title = "Average of Scores";
%let x= score1 score2 score3;
proc means data = score_data;
var &x;
title &title;
run;

OPTIONS NOSYMBOLGEN;