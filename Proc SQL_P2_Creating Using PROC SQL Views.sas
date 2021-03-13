/*Creating and Using PROC SQL Views

Overview of Creating and Using PROC SQL Views
A PROC SQL view contains a stored query that is executed when you use the view in a 
SAS procedure or DATA step. Views are useful for the following reasons:
	often save space, because a view is frequently quite small compared with the data 
that it accesses
	prevent users from continually submitting queries to omit unwanted columns or row
	shield sensitive or confidential columns from users while enabling the same users 
to view other columns in the same table
	ensure that input data sets are always current, because data is derived from tables 
at execution time
	hide complex joins or queries from users*/

/*1. Creating Views
To create a PROC SQL view, use the CREATE VIEW statement*/

proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;


proc sql;
   create view new_score_data as
   select *,
   mean(score1, score2, score3 ) as score_ave,
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
      
  select * from new_score_data  ;  
quit; 

/*2. Describing a View
The DESCRIBE VIEW statement writes a description of the PROC SQL view to the SAS log. */
proc sql;
   describe view new_score_data;
quit;   

/*3. Deleting a View
To delete a view, use the DROP VIEW statement:*/

proc sql;
   drop view new_score_data;
quit;   


/*4. You can use PROC SQL views as input to a DATA step or to other SAS procedures. 
The syntax for using a PROC SQL view in SAS is the same as that for a PROC SQL table. */
PROC MEANS data = new_score_data mean maxdec = 2;
var score1-score3 score_ave;
run;

data data_fromView;
set new_score_data;
run;


/*5. Specifying In-Line Views
In some cases, you might want to use a query in a FROM clause instead of a table or view. 
You could create a view and refer to it in your FROM clause, but that process involves two steps. 
To save the extra step, specify the view in-line, enclosed in parentheses, in the FROM clause.

An in-line view is a query that appears in the FROM clause. An in-line view produces a table internally 
that the outer query uses to select data. Unlike views that are created with the CREATE VIEW statement, 
in-line views are not assigned names and cannot be referenced in other queries or SAS procedures 
as if they were tables. An in-line view can be referenced only in the query in which it is defined.
*/


proc import datafile = "/folders/myfolders/score average by class" 
DBMS = xlsx out = class_ave replace ;
run;

proc SQL;
 	select s.Name, s.Gender, s.Birthdate, 
 		   mean(score1, score2, score3) as score123_mean 'student mean score' format = 4.1,
 		   c.all_class_mean
 	from (select mean (score_average) as all_class_mean format = 4.1
 				from class_ave) as c, score_data as s
 				
 	where (calculated score123_mean lt calculated all_class_mean) 
 			and calculated score123_mean ne .;
quit; 	

























