/*Use formats to create data via lookups
The FORMAT procedure uses a binary search (a rapid search technique) through 
the lookup table. Another benefit of using this technique is that maintenance 
is centralized; if a lookup value changes, you have to change it in only one 
place (in the format), and every program that uses the format will use the new value.


Term Definition
combining data horizontally: A technique in which data is retrieved from an 
auxiliary source or sources, based on the values of variables in the primary source.
performing a table lookup:A technique in which data is retrieved from an 
auxiliary source or sources, based on the values of variables in the primary source.
base table:The primary source in a horizontal combination. 
lookup table or tables: Any input data source, except the base table, that is 
used in a horizontal combination.
************************************
lookup values or return value:The data value or values that are retrieved 
from the lookup table or tables during a horizontal combination. 
Sometimes, lookup values that are not stored in a SAS data set, 
You can use techniques to hardcode lookup values into your program.
*************************************
key variable or variables: One or more variables that reside in both the 
base table and the lookup table. Usually, key values are unique in the lookup 
table but are not necessarily unique in the base table.
key value or values: A lookup is successful when the key value in the base table 
finds a matching key value in the lookup table.*/

data teacherid;
input tid;
datalines; 
201
202
203
204
;
run; /*we want bring in teachers birthday*/

/*The following PROC FORMAT step uses a VALUE statement to hardcode the lookup values
in the BIRTHDATE format.*/ 
proc format;
   value birthdate 201 = '01JAN1980'
                   202 = '08AUG1971'
                   203 = '23MAR1965'
                   204 = '17JUN1973';
run;

/*The DATA step uses the PUT function to associate the birthday lookup values from 
the format with the values of Tid. It is a process of numeric to character coversion;
The INPUT function associates the lookup value with the DATE9. informat, and 
assigns the formatted values to a new variable named Birthdate_n. 
It is a process of character to numeric coversion*/
data teacherid_b;
   set teacherid;
   /*numeric to character coversion*/
   B_C = put(tid, birthdate.);
   /*character to numeric coversion*/
   Birthdate_n=input(B_C,date9.);
   /*you can also write one line of code like below*/
  *Birthdate_n=input(put(tid,birthdate.),date9.);
   format Birthdate_n date7.;
run;