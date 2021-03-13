/*Comparing PROC SQL with SAS DATA Step */


proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data ;
run;

/*get obs/rows with gender = 'm'*/
proc sql;
   create table scoredata0 as
   select stu_id,
          gender,
          name
   from score_data
   where gender in  ('m');
quit;

data scoredata1;
set score_data;
if gender in  ('m');
keep stu_id gender name;
run;

proc print data = scoredata0;
title ' data from proc sql';
run;

proc print data = scoredata1;
title ' data from data step';
run;

