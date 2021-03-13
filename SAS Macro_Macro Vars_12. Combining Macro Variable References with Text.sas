/*Combining Macro Variable References with Text:

You can reference macro variables anywhere in your program. Some applications might
require placing a macro variable reference adjacent to leading text (text&variable) or
trailing text (&variabletext) or referencing adjacent macro variables
(&variable&variable) in order to build a new token. 
When you combine macro variable references and text, it is 
important to keep in mind how SAS interprets tokens.
*/

option symbolgen;
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

/*1. a macro variable reference adjacent to leading text (text&variable) */

%let n = 1;
proc means data = score_data;
var score&n;
title "mean statistics for score&n";
run;

/*2. referencing adjacent macro variables (&variable&variable)*/
%let n = 1;
%let v = score;
proc means data = score_data;
var &v&n;
title "mean statistics for &v&n";
run;

/*3. a macro variable reference adjacent to trailing text (&variabletext)*/
%let n = 1;
proc plot data = score_data;
plot score&n * gender;
run; 
/*You can place text immediately after a macro variable reference as long as the macro
variable name can still be tokenized correctly. --- In this case, 
a macro variable name was placed immediately before a special character asterisk *.

This is example a special case, Sometimes you might want to place a macro variable name immediately before text
other than a special character, I will show you examples and how to handle it in next tutorial*/
