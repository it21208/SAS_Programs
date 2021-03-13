/*Inserting Rows into Tables
Use the INSERT statement to insert data values into tables. 

The INSERT statement first adds a new row to an existing table, 
and then inserts the values that you specify into the row. 
You specify values by using a SET clause or VALUES clause. 
You can also insert the rows resulting from a query. 

Under most conditions, you can insert data into tables through PROC SQL and SAS/ACCESS views.*/


/*1. Inserting Rows with the SET Clause
With the SET clause, you assign values to columns by name. The columns can appear 
in any order in the SET clause. */

proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;

/* Create the new_score_data empty table LIKE the input table. */
proc sql;
   create table new_score_data
      like score_data;

/*In the following example, 
Insert 2 new rows with SET clauses in the new_score_data table. 
Then print the table. 

Note the following features of SET clauses:
	As with other SQL clauses, use commas to separate columns. In addition, you must use a semicolon 
after the last SET clause only.
	If you omit data for a column, then the value in that column is a missing value.
	To specify that a value is missing, use a blank in single quotation marks for character values 
and a period for numeric values.
*/
proc sql;
   insert into new_score_data    /*Insert 2 new rows with SET clause*/
      set name='David',
          	gender = 'm',
          score1=78
      set name='Tod',
          birthdate = '03Dec2007'd,
          	gender = 'm';
   
   select *							/*print the table*/
      from new_score_data;
quit;


/*2. Inserting Rows with the VALUES Clause
With the VALUES clause, you assign values to a column by position.

Note the following features of VALUES clauses:
	As with other SQL clauses, use commas to separate columns. In addition, you must use a semicolon 
after the last VALUES clause only.
	If you omit data for a column without indicating a missing value, then you receive an error message 
and the row is not inserted.
	To specify that a value is missing, use a space in single quotation marks for character values and 
a period for numeric values.
 */
proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;

proc sql;
   create table new_score_data /* Create the new_score_data empty table. */
      like score_data;
      
Proc SQL;  												/*six columns: name, score1-3, gender, birthdate*/
   insert into new_score_data							/*Inserting Rows with the VALUES Clause*/
      values ('Sara', 78,. , 75, 'f', '07Dec2006'd)
      values ('Tina', 69, 80, ., 'f', .)
      values ('David', 90, 92, 97, ' ', '06Jun2007'd);
  
   select name, score1, score2, score3, gender, birthdate format= date10.   /*Print the table*/
      from new_score_data;
quit;

/*3. Inserting Rows with a Query
You can insert the rows from a query result into a table. */

proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;

proc sql;
   create table new_score_data /* Create the new_score_data empty table. */
      like score_data;

/*3a. Insert all of the columns  and rows from score_data into new_score_data */
proc sql;
   insert into new_score_data
   select * from score_data;
quit;

/*3b. To insert rows by using a query for a subset of columns from the source table: 
**specify all column names in a comma-separated list, enclosed in parentheses, in the INSERT statement. 
**In the SELECT clause, specify column names that correspond to the columns of the INSERT statement. 
**The order and number of columns must match in the INSERT statement and in the SELECT clause. 

An error occurs if the query selects more columns than what exists for column names 
in the table that is specified in the INSERT statement.*/

proc sql;
   create table new_score_data /* Create the new_score_data empty table. */
      like score_data;

proc sql;   
   insert into new_score_data (Name,gender,birthdate)  /*Insert a subset of the columns*/
   select Name,gender,birthdate 
   		from score_data;

   select name format=$10., gender, birthdate format=date8. /*print the table*/
      from new_score_data;
quit;














