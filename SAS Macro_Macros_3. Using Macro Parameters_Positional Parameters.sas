/*Using Macro Parameters:
To make your macros more dynamic, you could use the %LET statement to
update the values of the macro variables used within the macros. However,
You can make these macro variables easier to update by using parameters in the macro
definition to create the macro variables. Then you can pass values to the macro variables
each time you call the macro.
There are various types of parameters to create macro variables.

(1) positional parameters
Positional parameters are so named because:
when you call a macro that includes positional parameters, you specify the values 
of the macro variables that are defined in the parameters in the same order 
in which they are defined.

To define macros that include positional parameters, you list the names of macro variables 
in the %MACRO statement of the macro definition. 

General form:
%MACRO macro-name(parameter-1<,...,parameter-n>);
text
%MEND <macro-name>;

parameter-1<,...,parameter-n>: specifies one or more positional parameters, separated by commas. 
You must give each parameter with a name.

To call a macro that includes positional parameters:

%macro-name(value-1<,...,value-n>)

*/

OPTIONS MPRINT MLOGIC; /*for debugging, lets put these options in use*/
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

%macro MeanOutputs(data,vars);

proc means data = &data;
var &vars;
title "mean statistics for &vars";
run;

%mend;

%MeanOutputs (score_data, score1 score2 score3)


