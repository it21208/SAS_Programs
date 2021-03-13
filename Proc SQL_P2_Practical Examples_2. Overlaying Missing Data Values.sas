/*Practical Examples Using PROC SQL

2.Overlaying Missing Data Values
In reality, you may have multiple copies of tables, some contain missings for different variables 
or records. You may use the COALESCE function to overlay same columns and returns 
the first nonmissing value that is found.

In this eample,
1. two tables contains same students' list with score1 and gender information
2. each table contains missing values for different students:
missings in one table, may have values in another table
3. combine the two tables to fill out the missings as much as possible
*/

proc import datafile = "/folders/myfolders/score1_1"
dbms = xlsx out = score1_1 replace;
run;

proc import datafile = "/folders/myfolders/score1_2"
dbms = xlsx out = score1_2 replace;
run;

proc sql;
   select s1.name,
   		  s1.score1 'score1_s1' , s2.score1 'score1_s2', 
   		  s1.gender 'gender_s1', s2.gender 'gender_s2',
          coalesce(s1.score1,s2.score1)as score1_final ,
           coalesce(s1.gender,s2.gender)as gender_final
      from score1_1 as s1 full join score1_2 as s2
           on s1.name =s2.name
      order by name;
quit;














