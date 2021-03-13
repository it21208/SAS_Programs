/*more on Delimiting in Macro Variable Names 
--using delimiter for a macro variable name immediately before text*/

option symbolgen;
LIBNAME Sdata "/folders/myfolders";
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = SDATA.score_data replace ;
run;

%let lib = Sdata;

proc means data = &lib.score_data; /*add a . before trailing text score*/
var score1;
title "mean statistics for score1";
run; 
/* &lib.score_data --> SDATASCORE_DATA
The period after &lib is interpreted as a delimiter. You need to use a second period after
the delimiter period to supply the necessary token.*/

proc means data = &lib..score_data; /*The first period is treated as a delimiter, 
										and the second period is treated as text.*/
var score1;
title "mean statistics for score1";
run;
/* &lib..score_data --> SDATA.SCORE_DATA */