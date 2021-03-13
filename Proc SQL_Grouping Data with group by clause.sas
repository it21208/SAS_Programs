/*Grouping Data
The GROUP BY clause groups data by a specified column or columns. When you use a GROUP BY clause, 
you also use an aggregate function in the SELECT clause or in a HAVING clause to 
instruct PROC SQL in how to summarize the data for each group. 
PROC SQL calculates the aggregate function separately for each group.*/

proc import datafile = "/folders/myfolders/score_data_miss" 
DBMS = xlsx out = score_data ;
run;

/*Grouping by One Column*/
proc sql;
   select *, mean (score1, score2, score3 ) as score_mean,
   max (calculated score_mean) as max_mean, min(calculated score_mean)as min_mean
      from score_data
      where calculated score_mean is not missing
      group by gender;
quit; 

/*Grouping without Summarizing
When you use a GROUP BY clause without an aggregate function, 
PROC SQL treats the GROUP BY clause as if it were an ORDER BY clause 
and displays a message in the log that informs you that this has happened. */

/*Log WARNING: A GROUP BY clause has been transformed into an ORDER BY clause 
because neither the SELECT clause nor the optional HAVING 
clause of the associated table-expression referenced a summary function.*/
proc sql;
   select *, mean (score1, score2, score3 ) as score_mean
   /*max (calculated score_mean) as max_mean, min(calculated score_mean)as min_mean*/
      from score_data
      where calculated score_mean is not missing
      group by gender;
quit; 

/*Grouping by Multiple Columns
To group by multiple columns, separate the column names with commas within the GROUP BY clause. 
You can use aggregate functions with any of the columns that you select.*/ 

proc import datafile = "/folders/myfolders/score_data_miss_with class info" 
DBMS = xlsx out = score_data_class ;
run;

/*one group is formed by the values of gender first then the values of class, 
each group has same max_ mean and min_mean*/
proc sql;
   select *, mean (score1, score2, score3 ) as score_mean,
   max (calculated score_mean) as max_mean, min(calculated score_mean)as min_mean
      from score_data_class
      where calculated score_mean is not missing
      group by gender, class;
quit; 

/*Grouping and Sorting Data
You can order grouped results with an ORDER BY clause.

The following example takes the previous example and adds an ORDER BY clause to 
change the order of the Gender column from ascending order to descending order: */
proc sql;
   select *, mean (score1, score2, score3 ) as score_mean,
   max (calculated score_mean) as max_mean, min(calculated score_mean)as min_mean
      from score_data_class
      where calculated score_mean is not missing
      group by gender, class
      order by gender desc;
quit; 

/*Grouping with Missing Values
When a column contains missing values, PROC SQL treats the missing values as a single group. 
This can sometimes provide unexpected results.*/
proc import datafile = "/folders/myfolders/score_data_miss_with class info_MJ" 
DBMS = xlsx out = score_data_class_MJ ;
run;

proc  sql;
   select *, mean (score1, score2, score3 ) as score_mean,
   max (calculated score_mean) as max_mean, min(calculated score_mean)as min_mean
      from score_data_class_MJ
      group by gender;
quit; /*unexpected results*/

/*To correct the query from the previous example, you can write a WHERE clause 
to exclude the missing values from the results:*/
proc sql;
   select *, mean (score1, score2, score3 ) as score_mean,
   max (calculated score_mean) as max_mean, min(calculated score_mean)as min_mean
      from score_data_class_MJ
      where gender is not missing 
      group by gender;
quit;


