/*Summarizing Data*/

/*Overview of Summarizing Data
You can use an aggregate function (or summary function) to produce a statistical summary of 
data in a table. 
The aggregate function instructs PROC SQL in how to combine data in one or 
more columns. 
when you use an aggregate function, PROC SQL applies the function to the entire table, 
unless you use a GROUP BY clause. You can use aggregate functions in the SELECT or HAVING clauses.
*/


/*Summarizing Data with a WHERE Clause
You can use aggregate, or summary functions, by using a WHERE clause. 

Function			Definition
AVG, MEAN			mean or average of values
COUNT, FREQ, N		number of nonmissing values
CSS					corrected sum of squares
Cv					coefficient of variation (percent)
MAX					largest value
MIN					smallest value
NMISS				number of missing values
PRT					probability of a greater absolute value of Student's t
RANGE				range of values
STD					standard deviation
STDERR				standard error of the mean
SUM					sum of values
SUMWGT				sum of the WEIGHT variable values
T					Student's t value for testing the hypothesis that the population mean is zero
USS					uncorrected sum of squares
vAR					variance
*/

proc import datafile = "/folders/myfolders/score_data_miss" 
DBMS = xlsx out = score_data ;
run;

/*Using the MEAN Function with a WHERE Clause*/
proc sql;
   select *, mean (score1, score2, score3 ) as score_mean
      from score_data
      where calculated score_mean >= 0
      order by score_mean;
quit; 

/*Displaying Sums*/
/*The SUM function produces a single row of output for the requested sum
because no non-aggregate value appears in the SELECT clause.
--- an example of PROC SQL combined information from multiple rows of data 
into a single row of output:*/

proc sql;
   select sum (score1 ) as score1_sum
      from score_data;
quit; 

/*Remerging Summary Statistics
Aggregate functions, such as the MAX function, can cause the same calculation to 
repeat for every row. This occurs whenever PROC SQL remerges data. */
proc sql;
   select *, mean (score1, score2, score3 ) as score_mean,
   max (calculated score_mean) as max_mean, min(calculated score_mean)as min_mean
      from score_data
      order by score_mean;
quit; 

/*Using Aggregate Functions with Unique Values*/
/*Counting Unique Values
You can use DISTINCT with an aggregate function to cause the function to use only unique 
values from a column.*/
proc sql;
   select count (distinct gender ) as count
      from score_data;
quit; *2;

/*Counting Nonmissing Values --- all nonmissing values are counted including duplicated values 
Compare the previous example with the following query, which does not use 
the DISTINCT keyword. */
proc sql;
   select count (gender ) as count
      from score_data;
quit; *11;

/*Counting All Rows
In the previous two examples, the missing values are ignored by the COUNT function. 
To obtain a count of all rows in the table: */
proc sql;
   select count (*) as total_num
      from score_data;
quit; *12;




