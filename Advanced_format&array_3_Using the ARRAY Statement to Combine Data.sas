/*Using the ARRAY Statement to Combine Data:
previously we taked about Using the FORMAT Procedure to Combine Data,
We can also hardcode the lookup values using Array to combine data
 */

data teacherid;
input tid;
datalines; 
201
202
203
204
;
run; /*bring in teachers' birthday info*/

/*use the ARRAY statement to hardcode the teachers' birthdates into 
a temporary array named BD, and then use the array to combine the 
teachers' birthdates with the data teacherid.*/
data teacherid_b;
set teacherid;
/*the values for the dimension of the array (201, 202, 203, 204)
correspond to values of tid in the data teacherid.
The initial values signed to array are SAS dates of the hardcoded teachers' birthdays */
   array bd{201:204} _temporary_ ('01JAN1980'd
         '08AUG1971'd '23MAR1965'd '17JUN1973'd);
/*the assignment statement for the new variable Birthdate retrieves 
a value from the BD array according to the current value of Tid.*/
   Birthdate=bd{tid};
   format Birthdate date7.;
run;