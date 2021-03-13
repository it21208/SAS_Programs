/*Practical Examples using Proc SQL

9. Updating a Table with Values from Another Table

This example:
want to update score data with updated score1 values*/
proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = score_data replace ;
run;
proc import datafile = "/folders/myfolders/score1_update" 
DBMS = xlsx out = score1_data replace ;
run;

/*The WHERE clause of outer query ensures that only the rows in score_data_updated that 
have a corresponding row in score1_data are updated by checking 
each value of Name against the list of Names that is returned 
from the in-line view. */

proc sql;
create table score_data_updated as
   select * from score_data;
update score_data_updated as u
   set score1=(select score1 from score1_data as s1
            where u.name=s1.name) /*the in-line view */
        where u.name in (select Name from score1_data); /*The WHERE clause of outer query*/

title1 "updated";
select *
  from score_data_updated;

title1 "score1_data";  
select *
  from score1_data;
  
title1 "original";  
select *
  from score_data;
quit;