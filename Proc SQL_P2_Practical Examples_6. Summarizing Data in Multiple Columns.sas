/*Practical Examples Using PROC SQL

6. Summarizing Data in Multiple Columns

want to produce a grand mean of multiple columns in a table.*/


proc import datafile = "/folders/myfolders/score_data_id_class" 
DBMS = xlsx out = score_data replace ;
run;

proc sql;
   select 	mean(Score1) as s1_mean format 5.2,
   			mean(Score2) as s2_mean format 5.2,
   			mean(Score3) as s3_mean format 5.2,
          	mean(calculated s1_mean, calculated s2_mean, calculated s3_mean) 
          	as GrandMean format 4.1
      from score_data;
quit;   

/*An alternative way to obtain the Grand Mean is to use nested functions:*/

proc sql;
select mean(mean(score1), mean(score2), mean(score3))
   as GrandMean format= 4.1
from score_data;
quit; 














  
   
   
