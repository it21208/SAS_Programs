/*Using SQL Procedure Tables in SAS Software & Deleting a table*/

proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;

proc sql;
   create table new_score_data like score_data;
   insert into new_score_data
   select * from score_data
      where gender = 'm';
quit;      

/*1. Using SQL Procedure Tables in SAS Software
Because PROC SQL tables are SAS data files, you can use them as input to a DATA step 
or to other SAS procedures.*/ 

proc means data=new_score_data mean maxdec=2;
   var score1 - score3;
run;

/*2. Deleting a Table
To delete a PROC SQL table, use the DROP TABLE statement:*/     
proc sql;
   drop table new_score_data;
quit;   /*look at the Log and Library*/




















