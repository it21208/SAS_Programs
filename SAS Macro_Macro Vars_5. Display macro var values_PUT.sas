/*Displaying Macro Variable Values in the SAS Log:
The %PUT Statement
Another way of verifying the values of macro variables is to write your own messages to
the SAS log. The %PUT statement writes text to the SAS log.

General form, basic %PUT statement:
%PUT text;

text is any text string.
*/

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

%let title = "Average of Scores";
%let x= score1 score2 score3;
proc means data = score_data;
var &x;
title &title;
run;

%put &sysdate9;
%put &x;

/* without any additional text, this statement writes the resolved value of the macro variable to the SAS log.
You may add explanatory text to your %PUT statements in order to maintain clarity in the SAS log. */
%put the value of macro var x: &x;



