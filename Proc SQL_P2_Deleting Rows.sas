/* Deleting Rows
The DELETE statement deletes one or more rows in a table */

proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;

proc sql;
create table new_score_data as 
select * from score_data;
quit;

/*A note in the SAS log tells you how many rows were deleted.

Note If you omit a WHERE clause, then the DELETE statement deletes all the rows from the specified table 
or the table that is described by a view. */
proc sql;
delete
from new_score_data
where gender = 'f';

select * from new_score_data; /*print*/
quit;
/*look at Log*/