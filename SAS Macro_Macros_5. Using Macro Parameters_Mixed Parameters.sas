/*Using Macro Parameters:Include Mixed Parameter Lists

You can also include a parameter list that contains both positional and keyword
parameters in your macro definitions. All positional parameter variables in the
%MACRO statement must be listed before any keyword parameter variable is listed.

General form, macro definition that includes mixed parameters:
%MACRO macro-name(parameter-1<,...,parameter-n>,
	keyword-1=<value-1><,...,keyword-n=<value-n>>);
text
%MEND;

NOTE: parameter-1<,...,parameter-n> is listed before keyword-1=<value-1><,...,keyword-n=<value-n>>.
Similarly, when you call a macro that includes a mixed parameter list, you must list the
positional values before any keyword values, as follows:

%macro-name(value-1<,...,value-n>,
	keyword-1=value-1<,...,keyword-n=value-n>)
*/

OPTIONS MPRINT MLOGIC; 
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

%macro MeanOutputs(vars,data=); 
proc means data = &data;
var &vars;
title "mean statistics for &vars";
run;
%mend;

%MeanOutputs (score1 score2 score3, data =score_data)