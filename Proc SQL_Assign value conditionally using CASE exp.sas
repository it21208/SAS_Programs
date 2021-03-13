/* assign values conditinally*/


proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data ;
run; /*vars: score 1-3, gender*/

/*Using a Simple CASE Expression  --- can use comparison operators or other types of operators
Please Note: You must close the CASE logic with the END keyword.*/
proc sql;
   select *,
   sum (score1, score2, score3 )/3 as score_ave,
          case
             when Calculated score_ave >= 90 then 'A'
             when 80 <= Calculated score_ave < 90 then 'B'
             when 70 <= Calculated score_ave < 80 then 'C'
             when 60 <= Calculated score_ave < 70 then 'D'
             when 0< Calculated score_ave < 60 then 'F'
             else 'Absent'
          end as Grade
      from score_data
      order by Name;
quit;      
      
/*Using the CASE-OPERAND Form --- must all be equality tests*/

proc sql;
   select *,
          case gender
             when 'f' then 'female'
             when 'm' then 'male'
          end as gender_new
      from score_data
      order by Name;
quit;         
