/*eliminate dups using Proc Sort
The NODUPKEY option deletes any observations with duplicate BY values 
(i.e., observations that duplicate a previously encountered value of Key var/ By var).
Use the NODUPREC option to delete duplicate observations 
(i.e., where all variable values are repeated)

Use the DUPOUT= option with NODUPKEY (or NODUPREC) to output duplicates to 
the specified SAS data set
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

/*Use PROC SORT to remove duplicate values:*/
proc sort data=d1 nodupkey;
 by id;
run; 

/*output duplicates to the specified SAS data set*/
proc sort data=d1 nodupkey dupout=dups;
 by id;
run; 

/*another way to keep the original input data d1 unchanged is 
adding OUT = option in Proc Sort like this:

proc sort data=d1 out = d1_k nodupkey;
 by id;
run;
proc sort data=d1 out = d2_k nodupkey dupout=dups;
 by id;
run; 

*/



