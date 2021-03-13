/*************************outer joins*********************************
Outer joins are inner joins that are augmented with rows from one table 
that do not match any row from the other table in the join. 
The resulting output includes rows that match and rows that do not match 
from the join's source tables. 
Nonmatching rows have null values in the columns from the unmatched table.
 
Use the ON clause instead of the WHERE clause to specify the column or columns 
on which you are joining the tables. 
However, you can continue to use the WHERE clause to subset the query result.*/
proc import datafile = "/folders/myfolders/score_data_id_gender_only_1l" 
DBMS = xlsx out = score_data_g replace;
run; /*has stu_id = 5, no stu_id = 11*/

proc import datafile = "/folders/myfolders/score_data_id_no_gender_1l" 
DBMS = xlsx out = score_data_ng replace;
run; /*has stu_id = 11, no stu_id = 5*/

/*A left outer join lists matching rows and rows from the left-hand table 
(the first table listed in the FROM clause) that do not match any row 
in the right-hand table. 
A left join is specified with the keywords LEFT JOIN and ON.*/

proc sql;
   SELECT g.stu_id "Gender table stu_id" ,
   		  ng.stu_id "Score table stu_id",
          
          score1, 
          score2, 
          score3,
          gender, g.Name
         
   FROM score_data_g AS g LEFT JOIN  score_data_ng AS ng
   ON g.stu_id =  ng.stu_id;
        
quit;

/*A right join, specified with the keywords RIGHT JOIN and ON, is the opposite of a left join: 
nonmatching rows from the right-hand table (the second table listed in the FROM clause) 
are included with all matching rows in the output. */

proc sql;
   SELECT g.stu_id "Gender table stu_id" ,
   		  ng.stu_id "Score table stu_id",
          
          score1, 
          score2, 
          score3,
          gender, ng.Name
         
   FROM score_data_g AS g RIGHT JOIN  score_data_ng AS ng
   ON g.stu_id =  ng.stu_id;
        
quit;

/*A full outer join, specified with the keywords FULL JOIN and ON, selects all matching and nonmatching 
rows. */

proc sql;
   SELECT g.stu_id "Gender table stu_id" ,
   		  ng.stu_id "Score table stu_id",
          
          score1, 
          score2, 
          score3,
          gender,
          g.name  "Gender table name",
          ng.Name "Score table name"
         
   FROM score_data_g AS g FULL JOIN  score_data_ng AS ng
   ON g.stu_id =  ng.stu_id;
        
quit;




