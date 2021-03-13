/*create columns*/

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data ;
run;

/*Adding Text to Output*/
proc sql;
select "Math Score 1 for", Name, "is", Score1
      from score_data;

/*PROC SQL does not output the column name when a label is assigned, 
and it does not output labels that begin with special characters. */
proc sql;
select "Math Score 1 for", Name label='#', "is", Score1 label='#'
      from score_data;


/*Calculating Values, Assigning a Column Alias,
Referring to a Calculated Column by Alias*/
proc sql;
   create table scoredata1 as
/*By specifying a column alias, you can assign a new name 
to any column within a PROC SQL query.*/   
select *, 
   mean(score1) as score1_ave format 4.1 ,
   mean(score2) as score2_ave format 4.1 ,
   mean(score3) as score3_ave format 4.1 ,
/*When you use a column alias to refer to a calculated value, you must 
use the CALCULATED keyword with the alias to inform PROC SQL that the 
value is calculated within the query. */
(Calculated score1_ave - Calculated score2_ave)
                   as Diff12 format=4.1

   from score_data
   group by gender
   order by gender;
quit;

proc print data = scoredata1;
run;