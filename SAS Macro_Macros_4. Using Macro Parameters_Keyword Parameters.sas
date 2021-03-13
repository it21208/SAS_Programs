/*Using Macro Parameters: Keyword Parameters:
Like positional parameters, keyword parameters create macro variables. However, when you use
keyword parameters to create macro variables, you specify the name, followed by the
equal sign, and the value of each macro variable in the macro definition.

Keyword parameters can be listed in any order. Whatever value you assign to each
parameter (or variable) in the %MACRO statement becomes its default value. Null
values are allowed.

General form, macro definition that includes keyword parameters:

%MACRO macro-name(keyword-1=<value-1><,...,keyword-n=<value-n>>);
text
%MEND <macro-name>;

keyword-1=<value-1><,...,keyword-n=<value-n>>: names one or more macro parameters followed 
by equal signs. You can specify default values after the equal signs. 
If you omit a default value, the keyword parameter has a null value.*/

OPTIONS MPRINT MLOGIC; 
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

%macro MeanOutputs(data= score_data,vars = score1); 
%* %macro MeanOutputs(data= score_data,vars = ); 
proc means data = &data;
var &vars;
title "mean statistics for &vars";
run;

%mend;

/*To call the macro MeanOutputs with default values for the parameters:*/
%MeanOutputs ()
/*To call macro with a new value for Vars*/
%MeanOutputs (vars = score1 score2 score3)