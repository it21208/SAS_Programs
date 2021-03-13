/* eliminate dups using Data step:
IDENTIFYING DUPLICATES WITH FIRST./LAST. VARIABLES

Use FIRST./LAST. variables to identify observations as the first, last, or 
neither the first nor the last time that a value occurs. 
FIRST./LAST. variables are created by SAS when a data set is SET BY one or 
more variables. FIRST.and LAST.can have only two values, 0 or 1 
The data set must be sorted with PROC SORT by the BY var. 
*/
data d1;
input ID count;
datalines;
101 1
102 1
103 1
104 1
104 2
105 1
105 2
105 3
;
run;
proc sort data = d1; by id; run;
data d2;
set d1;
by id;
first_id = first.id ;
last_id = last.id ;
run;
proc print data = d2; run;
/*Use the values of First_ID and LAST_ID to identify duplicates: Any observation where 
both First_ID and LAST_ID do not equal 1 means it is not the first and the last time 
that the value occurs (i.e., there are duplicates). */

/*Use the values of First_ID and LAST_ID to output duplicates to a 
SAS data set:*/
data unique_id dups;
 set d2;
 by id;
 if not(First_id =1 and Last_id=1) then output dups;
 else output unique_id;
run; 