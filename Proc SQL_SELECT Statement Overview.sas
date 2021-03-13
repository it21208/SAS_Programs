/*SELECT statement & its clauses*/

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data ;
run;

proc sql;
   create table scoredata0 as
   select *
   from score_data
   where gender in  ('m')
   order by name;
quit;
proc print data = scoredata0;
run;


/*The following query uses the MEAN function to list the average 
of score1 of each gender. 
The GROUP BY clause groups the students by gender, 
and the ORDER BY clause puts the values of gender in 
alphabetical order*/
proc sql;
   create table scoredata1 as
   
   select *, 
   mean(score1)as score1_ave,
   mean(score2)as score2_ave,
   mean(score3)as score3_ave
   
   from score_data
   group by gender
   order by gender;
quit;
proc print data = scoredata1;
run;

/*the having clause restricts the groups to include only 
gender = ‘f’ (female) in the query's results*/
proc sql;
   create table scoredata2 as
   
   select *, 
   mean(score1)as score1_ave,
   mean(score2)as score2_ave,
   mean(score3)as score3_ave
   
   from score_data
   group by gender
   having gender = 'f'
   order by gender;
quit;
proc print data = scoredata2;
run;