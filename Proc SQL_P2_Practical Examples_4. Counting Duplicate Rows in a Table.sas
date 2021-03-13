/*Practical Examples Using PROC SQL

4. Counting Exact Duplicate Rows in a Table
The dupliacte records often exist in the uncleaned data. 
Identify the duplicates are the commom task in data management assigments.

In this eample we will generate duplicate records and count the number of duplicate rows */

proc import datafile = "/folders/myfolders/score_data_id_dups"
dbms = xlsx out = dups replace;
run;

/*Note:  You must include all of the columns in your table in the GROUP BY clause 
 to find exact duplicates, then we can eliminate the exact dups.
 For partial dups (such as having same names but different info.), further investigation 
 often is needed during the data cleaning process. */

proc sql;
   title 'Duplicate Rows in the Table';
   select *, count(*) as Count /*counts all rows*/
      from Dups
      group by name, score1,score2,	score3, gender,stu_id
      having count(*) > 1; /*excludes the rows that have no duplicates*/
quit;