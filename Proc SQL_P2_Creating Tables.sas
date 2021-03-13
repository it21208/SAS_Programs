/*Creating and Updating Tables and Views

Creating Tables
The CREATE TABLE statement enables you to create tables without rows from column definitions 
or to create tables from a query result. 
You can also use CREATE TABLE to copy an existing table.*/

/*1. create a new table without rows by using the CREATE TABLE statement to define the 
columns and their attributes. You can specify a column's name, type, length, informat, 
format, and label.*/

proc sql;
   create table stu_info
          ( stu_name 	 char(10),          /*10–character column for students' first name */
            stu_gender   char(1),            /*1- character column for students' gender*/         
			Birthdate    num				/*numeric column for student birthdate*/
         				 informat=date9.     /* with an informat */
               			 format=date9.);      /* and format of DATE9. */
quit;

/*Use the DESCRIBE TABLE statement to verify that the table exists and to see the column attributes. */
proc sql;
   describe table stu_info;
quit;

/*2. Creating Tables from a Query Result
To create a PROC SQL table from a query result, use a CREATE TABLE statement with the AS keyword, 
and place it before the SELECT statement. When a table is created this way, 
its data is derived from the table or view that is referenced in the query's FROM clause.

The new table's column names are as specified in the query's SELECT clause list. 
The new table's column attributes (the type, length, informat, format, and extended attributes) 
are the same as the selected source columns.*/ 

proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;

/*In this form of the CREATE TABLE statement, assigning an alias to a column renames the column, 
but assigning a label does not. 

Note the use of the OUTOBS option, which limits the size of the table to 10 rows.*/
proc sql outobs=10;
   create table score_data_part as
     select Name 'student name' format $15.,
     		score1, score2, score3,
            gender as student_gender,
            birthdate 'student birthdate' format=date10. 
        from score_data;
quit;

/*3. Creating Tables like an Existing Table
To create an empty table that has the same columns and attributes as an existing table or view, 
use the LIKE clause in the CREATE TABLE statement*/
proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;

proc sql;
   create table newscoredata
     like score_data;

   describe table newscoredata;
quit;   

/*4. Copying an Existing Table
A quick way to copy a table using PROC SQL is to use the CREATE TABLE statement with a query 
that returns an entire table. */

proc sql;
create table score_data1 as
  select * from score_data;
quit; 

/*5. Using Data Set Options
You can use SAS data set options in the CREATE TABLE statement.
example: The DROP= option 

For more info on SAS data set options, Please visit the following link
http://support.sas.com/documentation/cdl/en/lrdict/64316/HTML/default/viewer.htm#a002295655.htm */
 
proc sql;
create table score_data1 as
  select * from score_data (drop = score1);
quit; 
   




