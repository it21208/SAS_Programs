/*Specialty Joins
Overview of Specialty Joins
Three types of joins:
cross joins, union joins, and natural joins 
are special cases of the standard join types. */

proc import datafile = "/folders/myfolders/score_data_id_gender_only_1l" 
DBMS = xlsx out = score_data_g replace;
run; /*has stu_id = 5, no stu_id = 11*/

proc import datafile = "/folders/myfolders/score_data_id_no_gender_1l" 
DBMS = xlsx out = score_data_ng replace;
run; /*has stu_id = 11, no stu_id = 5*/

/*Including All Combinations of Rows with the Cross Join
A cross join is a Cartesian product; it returns the product of two tables. 
Like a Cartesian product, a cross join's output can be limited by a WHERE clause.*/

proc sql;
   SELECT g.stu_id "left table stu_id" ,
   		  ng.stu_id "right table stu_id",
          
          score1, 
          score2, 
          score3,
          gender,
          g.name  "left table name",
          ng.Name "right table name"
         
   FROM score_data_g AS g CROSS JOIN  score_data_ng AS ng;
        
quit;

/*Including All Rows with the Union Join
A union join combines two tables without attempting to match rows. 
All columns and rows from both tables are included. Combining tables 
with a union join is similar to combining them with the OUTER UNION set operator. 
A union join's output can be limited by a WHERE clause. */

proc sql;
   SELECT g.stu_id "left table stu_id" ,
   		  ng.stu_id "right table stu_id",
          
          score1, 
          score2, 
          score3,
          gender,
          g.name  "left table name",
          ng.Name "right table name"
         
   FROM score_data_g AS g UNION JOIN  score_data_ng AS ng;
        
quit;

/*Matching Rows with a Natural Join
A natural join automatically selects columns from each table to use in determining 
matching rows. With a natural join, PROC SQL identifies columns in each table that 
have the same name and type; rows in which the values of these columns are equal are 
returned as matching rows. The ON clause is implied. */

proc sql;
   SELECT g.stu_id "left table stu_id" ,
   		  ng.stu_id "right table stu_id",
          
          score1, 
          score2, 
          score3,
          gender,
          g.name  "left table name",
          ng.Name "right table name"
         
   FROM score_data_g AS g NATURAL JOIN  score_data_ng AS ng;
        
quit; /*only matching rows included in the result*/

/*The advantage of using a natural join is that the coding is streamlined. 
The ON clause is implied, and you do not need to use table aliases to 
qualify column names that are common to both tables.

A natural join assumes that you want to base the join on equal values of 
all pairs of common columns. 

The following two queries return the same results: */

title 'LEFT JOIN';
proc sql;
   SELECT g.stu_id "left table stu_id" ,
   		  ng.stu_id "right table stu_id",
          
          score1, 
          score2, 
          score3,
          gender, g.Name
         
   FROM score_data_g AS g LEFT JOIN  score_data_ng AS ng
   ON g.stu_id =  ng.stu_id
   order by g.stu_id;
quit;

title 'NATURAL LEFT JOIN';
proc sql;
   SELECT g.stu_id "left table stu_id" ,
   		  ng.stu_id "right table stu_id",
          
          score1, 
          score2, 
          score3,
          gender, g.Name
         
   FROM score_data_g AS g NATURAL LEFT JOIN  score_data_ng AS ng
   order by g.stu_id;
quit;

/*If you specify a natural join on tables that do not have at least one column 
with a common name and type, then the result is a Cartesian product. 
You can use a WHERE clause to limit the output.

Because the natural join makes certain assumptions about what you want to accomplish, 
you should know your data thoroughly before using it. You could get unexpected or 
incorrect results.
You can use the FEEDBACK option to see exactly how PROC SQL is implementing your query.

Look at the log... */

proc sql feedback;
   SELECT g.stu_id "left table stu_id" ,
   		  ng.stu_id "right table stu_id",
          
          score1, 
          score2, 
          score3,
          gender, g.Name
         
   FROM score_data_g AS g NATURAL LEFT JOIN  score_data_ng AS ng
   order by g.stu_id;
quit;