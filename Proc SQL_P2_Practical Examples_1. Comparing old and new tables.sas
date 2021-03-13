/*Practical Examples Using PROC SQL

1. Comparing Old and New Tables:

You have two copies of a table. One of the copies has been updated. 
You want to see which rows have been changed. */

proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data_old replace ;
run;

proc import datafile = "/folders/myfolders/score_data_miss_birthdate_new" 
DBMS = xlsx out = score_data_new replace ;
run;

proc sql;
   title "rows updated";
   select * from score_data_new
   except
   select * from score_data_old;
   
   title "new data";
   select * from score_data_new;
   
   title "old data";
   select * from score_data_old;
   
quit;

/*The EXCEPT operator returns rows from the first query that are not part of the second query. 
In this example, the EXCEPT operator displays only the rows that have been added or changed 
in the score_data_new table.