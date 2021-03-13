/*replace missing values*/

proc import datafile = "/folders/myfolders/score_data_miss" 
DBMS = xlsx out = score_data ;
run; /*score1, gender*/

/*using Coalesce function: 
The COALESCE function enables you to replace missing values in a column with a new value that you specify.
The following query 
replaces missing values in the Score1 column in the score_data table with the value -7
and replaces missing values in the Gender column with the word Missing */
proc sql;
select Name, 
coalesce(score1, -7) as score1, 
coalesce(gender, 'Missing') as gender
from score_data;
quit;


/*use Case expression:
The following CASE expression shows another way to perform the same replacement of missing values. 
However, the COALESCE function requires fewer lines of code to obtain the same results*/
proc sql;
select Name, 

case
when Score1 = . then -7
     else Score1
end as Score1,

case
when Gender = ' ' then 'Missing'
     else Gender
end as Gender

from score_data;
quit;
