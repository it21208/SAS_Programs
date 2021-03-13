/*Practical Examples Using PROC SQL

8. Creating a Customized Sort Order

want to sort the data using logical order of monthes*/

proc import datafile = "/folders/myfolders/score by month"
dbms = xlsx out = score_month replace;
run;

/*This example uses an in-line view to create a temporary column that can be used as an ORDER BY column. 

Create a new column, Sorter, 
that will have values of 1 through 5 for monthes from Jan to May. 
Use the new column to order the query, but do not select it to appear*/
proc sql;
     select Name, Score, Month
      from (select Name, Score, Month,
              case
                 when Month = 'Jan' then 1
                 when Month = 'Feb' then 2
                 when Month = 'Mar' then 3
                 when Month = 'Apr' then 4
                 when Month = 'May' then 5
                 else .
              end as Sorter
              from score_month)
      order by Sorter, name;
quit;

/*the Sorter column is not included in the SELECT statement. 
That causes a note to be written to the log indicating that you have used a column 
in an ORDER BY statement that does not appear in the SELECT statement.*/