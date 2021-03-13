/*Using an Index to Combine Data:
multiple SET statements with KEY = option
(Terminology:
lookup table or tables: Any input data source, except the base table, 
that is used in a horizontal combination.
base table: The primary source in a horizontal combination. )

You have seen how to use multiple SET statements in a DATA step in order to combine 
summary data and detail data in a new data set. You can also use multiple SET 
statements to read only the matching observations and use index to efficiently 
select only the matching observations via direct access.

You specify the KEY= option in the SET statement to use an index to retrieve 
matching observations from the lookup data set.
General form, SET statement with KEY= option:
SET SAS-data-set-name KEY= index-name;

Here is an explanation of the syntax:
index-name:
is the name of an index that is associated with the SAS-data-set-name data set.

To use the SET statement with the KEY= option to perform a lookup operation, 
your lookup values must be stored in a SAS data set that has an index. 
This technique is appropriate only when you are working with one-to-one matches, 
with a lookup table of any size.*/

options MSGLEVEL=I;
proc import datafile = "/folders/myfolders/score_data_id_partial_score4_extra" 
DBMS = xlsx out = sdp (keep = stu_id name score4 ) replace ;
run;

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = sda (index=(Sid_name=(stu_id name))) replace ;
run; /*uses an index on the larger of the two input data sets*/

/*In the following example,we use two SET statements to combine these two data sets, 
and use the KEY= option in the second SET statement to take advantage of the index.
the first SET statement reads an observation sequentially from the sdp data set. 
the second SET statement uses the Sid_name index on sda to find an observation 
in sda to match the obs with the matching values of Stu_id and Name in the first
data set 
Note: If you use the KEY= option to read a SAS data set, you cannot use WHERE 
processing on that data set in the same DATA step.*/
data sd_all0;
   set sdp;
   set sda key=Sid_name;
   score_average= mean (score1, score2,score3,score4);
run; /*check the log _ERROR_ and _IORC_ , and data*/

/*The _IORC_ Variable
When you use the KEY= option, SAS creates an automatic variable named _IORC_, 
which stands for INPUT/OUTPUT Return Code. You can use _IORC_ to determine 
whether the index search was successful. If the value of _IORC_ is zero, 
SAS found a matching observation. If the value of _IORC_ is not zero, 
SAS did not find a matching observation.

To prevent writing the data error to the log and to your output data set, 
do the following:
*check the value of _IORC_ to determine whether a match has been found
*set _ERROR_ to 0 if there is no match
*delete the nonmatching data or write the nonmatching data to an errors data set
*/
data sd_all1 non_match;
   set sdp;
   set sda key=Sid_name;
   if _iorc_=0 then do; /*if matching*/
      score_average= mean (score1, score2,score3,score4);
      output sd_all1;
   end;
   else do;
      _error_=0;
      output non_match;
   end;
run;