/*Overview of Comparing DATA Step Match-Merges with PROC SQL Joins

Many SAS users are familiar with using a DATA step to merge data sets. 
This section compares merges to joins. DATA step match-merges and PROC SQL joins 
can produce the same results. However, a significant difference between a match-merge 
and a join is that you do not have to sort the tables before you join them.*/

/*When All of the Values Match:
When all of the values match in the BY variable and there are no duplicate BY variables, 
you can use an inner join to produce the same result as a match-merge. */

proc import datafile = "/folders/myfolders/score_data_id_gender_only_1l" 
DBMS = xlsx out = score_data_g replace;
run; /*Contain Gender info., has stu_id = 5, no stu_id = 11*/

proc import datafile = "/folders/myfolders/score_data_id_no_gender_1l" 
DBMS = xlsx out = score_data_ng replace;
run; /*Contain Scores info., has stu_id = 11, no stu_id = 5*/

data score_data_g1;
set score_data_g;
if stu_id ne 5;
run;
data score_data_ng1;
set score_data_ng;
if stu_id ne 11;
run;

Title 'Proc SQL';
proc sql;
   SELECT g.stu_id ,
   		  score1, 
          score2, 
          score3,
          gender, g.Name
         
   FROM score_data_g1 AS g INNER JOIN  score_data_ng1 AS ng
   ON g.stu_id =  ng.stu_id;
        
quit;

/*match-merge*/
proc sort data = score_data_g1;
by stu_id;
run;

proc sort data = score_data_ng1;
by stu_id;
run;

data match_merge;
merge score_data_g1 score_data_ng1;
by stu_id;
run;

proc print data=match_merge;
title "match merge";
run;


/*When Only Some of the Values Match:
When only some of the values match in the BY variable, you can use an outer join to 
produce the same result as a match-merge. */

/*match-merge*/
proc sort data = score_data_g;
by stu_id;
run;

proc sort data = score_data_ng;
by stu_id;
run;

data match_merge;
merge score_data_g score_data_ng;
by stu_id;
run;

proc print data=match_merge;
title "match merge";
run;

/*To get the same result with PROC SQL, use an outer join so that the query result will contain the 
nonmatching rows from the two tables. 
In addition, use the COALESCE function to overlay the Stu_id columns from both tables.
COALESCE takes a list of columns as its arguments and returns the first nonmissing value that it encounters */

Title 'Proc SQL';
proc sql;
   SELECT g.stu_id "gender table stu_id",ng.stu_id "score table stu_id",
   		  g.name "gender table Name",ng.name "score table name",
   		  score1, 
          score2, 
          score3,
          gender 
         
   FROM score_data_g AS g FULL JOIN  score_data_ng AS ng
   ON g.stu_id =  ng.stu_id;
        
quit;

Title 'Proc SQL';
proc sql;
   SELECT coalesce (g.stu_id,ng.stu_id) as stu_id   ,
   		  coalesce (g.name,ng.name) as name   ,
   		  score1, 
          score2, 
          score3,
          gender
         
   FROM score_data_g AS g FULL JOIN  score_data_ng AS ng
   ON g.stu_id =  ng.stu_id;
        
quit;

/*When the Position of the Values Is Important

When you want to merge two tables and the position of the values is important, 
you might need to use a DATA step merge, 
because the DATA step merges data based on the position of values in BY groups

PROC SQL does not process joins according to the position of values in BY groups. 
Instead, PROC SQL processes data only according to the data values. */

proc import datafile = "/folders/myfolders/math_score_long" 
DBMS = xlsx out = math replace;
run;
proc import datafile = "/folders/myfolders/read_score_long" 
DBMS = xlsx out = read replace;
run;


/*match-merge*/
proc sort data = math;
by stu_id;
run;

proc sort data = read;
by stu_id;
run;

data match_merge;
merge math read;
by stu_id;
run;

proc print data = math; run;
proc print data = read; run;
proc print data=match_merge;
title "match merge";
run;

/*PROC SQL builds the Cartesian product and then lists the rows that meet the WHERE clause condition. 
The WHERE clause returns two rows for each math score --- one row for each read score.*/
Title 'Proc SQL';
proc sql;
   SELECT *
         
   FROM math AS g,  read AS ng
   where g.stu_id =  ng.stu_id;
        
quit;









