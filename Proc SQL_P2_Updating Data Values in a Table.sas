/*Updating Data Values in a Table
You can use the UPDATE statement to modify data values in tables 
The UPDATE statement updates data in existing columns; it does not create new columns. */

/*1. Updating All Rows in a Column with the Same Expression
The following UPDATE statement increases all score1 < 85 by 10%*/

proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;


proc sql;
   create table new_score_data like score_data; /*create empty new_score_data*/
   
   insert into new_score_data   /*Insert all of the columns/rows into new_score_data from a query*/
   select * from score_data;
quit;

proc sql;
   update new_score_data
      set score1=score1*1.1
      where score1 < 85;
      
   title "Updated Score1 Values for Score1 < 85"; /*print updated score1*/
   select name format=$10.,
          gender,
          score1 format=2.
      from new_score_data;
   
   title "Original Score1 Values"; /*print original score1*/
   select name format=$10.,
          gender,
          score1 format=2.
      from score_data; 
      
quit;

/*2. Updating Rows in a Column with Different Expressions
To update some, but not all, of a column's values, use a WHERE expression in the UPDATE 
statement. You can use multiple UPDATE statements, each of which can contain a different 
WHERE expression. Each UPDATE statement can have only one WHERE expression. */

proc sql;
	create table new_score_data as /*copy an existing table*/
    select * from score_data;
quit; 

proc sql;
   update new_score_data
      set score1=score1*1.1
      where score1 <= 60;
   update new_score_data
      set score1=score1*1.05
      where 60 < score1 <= 70;
      
      
   title "Selectively Updated Score1 Values";
   select name format=$10.,
          gender,
          score1 format=2.
      from new_score_data;
      
   title "Original Score1 Values";
   select name format=$10.,
          gender,
          score1 format=2.
      from score_data; 
quit;

/*You can accomplish the same result with a CASE expression:*/

proc sql;
	create table new_score_data as /*copy an existing table*/
    select * from score_data;
quit;

/*Make sure that you specify the ELSE clause. If you omit the ELSE clause, 
then each row that is not described in one of the WHEN clauses receives a missing value 
for the column that you are updating. 
This happens because the CASE expression supplies a missing value to the SET clause, 
and the column is multiplied by a missing value, which produces a missing value.*/
proc sql;
update new_score_data
   set score1 = score1 *
      case when score1 <= 60 then 1.1
           when 60 < score1 <= 70 then 1.05
           else 1
      end;

   title "Selectively Updated Score1 Values";
   select name format=$10.,
          gender,
          score1 format=2.
      from new_score_data;
quit;





















