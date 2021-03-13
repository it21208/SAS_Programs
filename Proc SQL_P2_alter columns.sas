/*Altering Columns
The ALTER TABLE statement adds, modifies, and deletes columns in existing tables. 
You can use the ALTER TABLE statement with tables only; it does not work with views. 
A note appears in the SAS log that describes how you have modified the table.*/

/* 1. Adding a Column
The ADD clause adds a new column to an existing table. You must specify the column name 
and data type. You can also specify a length (LENGTH=), format (FORMAT=), 
informat (INFORMAT=), and a label (LABEL=). */


proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;

proc sql;
   create table new_score_data like score_data;
   insert into new_score_data
   select * from score_data
      where gender = 'm';

/*add a new column without data values*/
proc sql; 
   alter table new_score_data
      add score123_mean num label='Average of Score 1,2,3' format=4.1;

   title "adding score123_mean";
   select *
      from new_score_data;
quit;      

/*The following UPDATE statement changes the missing values to the appropriate 
averages of score1,2,3*/

proc sql;
   update new_score_data
      set score123_mean = mean (score1, score2, score3);

   title "average of score1,2,3 Table";
   select *
      from new_score_data;
quit;

/*You can accomplish the same update by using an arithmetic expression to create 
mean of score 1,2,3 column as you re-create the table:*/

proc sql;
   create table new_score_data as
   select *, mean (score1, score2, score3) as score123_mean
             label='Average of Score 1,2,3' 
             format=4.1
      from score_data
      where gender = 'm';
      
         select *
      from new_score_data;
quit;      
      
      
      
/*2. Modifying a Column
You can use the MODIFY clause to change the width, informat, format, and label of a column. 
To change a column's name, use the RENAME= data set option. You cannot change 
a column's data type by using the MODIFY clause.*/

proc sql;
   create table new_score_data like score_data;
   insert into new_score_data
   select * from score_data
      where gender = 'm';

proc sql;
   alter table new_score_data
      modify birthdate label = 'birth_date' format = date8.;
   
   select * 
   from new_score_data;
quit;

/*3. Deleting a Column
The DROP clause deletes columns from tables.*/

proc sql;
   alter table new_score_data
     drop score3;
quit;     















