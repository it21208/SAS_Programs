/*Delimiting in Macro Variable Names

Sometimes you might want to place a macro variable name immediately before text
other than a special character, what we can do is to add delimiters:

The word scanner recognizes the end of a macro variable name when it encounters a
special character that cannot be part of the name token. In other words, the special
character acts as a delimiter. For example, a period (.) is a special character that is treated
as part of the macro variable reference and that does not appear when the macro variable
is resolved.*/

option symbolgen;
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

%let v = score;
proc means data = score_data;
var &v1;
title "mean statistics for &v1";
run;
/*SAS interprets the macro variable's name to be v1 instead of v
because there is no delimiter between the macro variable reference and the trailing text.*/

/*To correct the problem in the previous example, you need to add a period after the
reference to the macro variable v*/
proc means data = score_data;
var &v.1;
title "mean statistics for &v.1";
run;


