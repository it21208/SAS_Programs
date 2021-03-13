/*eliminating duplicate rows*/

proc import datafile = "/folders/myfolders/score_data_id_dups" 
DBMS = xlsx out = score_data ;
run;

proc sql;
Select gender
From score_data;
quit;

proc sql;
Select DISTINCT gender
From score_data;
quit;

proc sql;
Select DISTINCT *
From score_data
order by name;
quit;


/*To obtain a list of all of the columns in a table and their attributes*/

proc sql;
   describe table score_data;
