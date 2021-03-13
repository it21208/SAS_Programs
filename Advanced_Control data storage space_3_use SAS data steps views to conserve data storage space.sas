/*use SAS data steps views to conserve data storage space
(for Proc SQL view, Please see 
section 7. SAS SQL: Creating and Updating Tables and Views)
Another way to save disk space is to leave your data in its original location and 
use a SAS data view to access it. 

A SAS data file and a SAS data view are both types of SAS data sets. 
A SAS data file contains both descriptor information and the data. 
A SAS data view, contains only descriptor information and instructions 
on how to retrieve data stored elsewhere.The main difference between 
SAS data files and SAS data views is where the data is stored.

The compiled DATA step does not use much room for storage, so you can create DATA 
step views to conserve disk space. On the other hand, use of DATA step views can 
increase CPU usage because SAS must execute the stored DATA step each time you use
the view.
General Recommendations
*Create a SAS DATA step view to avoid storing a SAS copy of a raw data file.
*Use a SAS DATA step view if the content, but not the structure, of the flat 
file is dynamic.
*Create a DATA step view to combine multiple SAS data sets with a merge or 
concatenation.
*Create a DATA step view to access frequently used subsets.

----------------------------------------------------------------
To create a DATA step view, specify the VIEW= option after the final DATA set name 
in the DATA statement.

General form, DATA step to create a DATA step view:
DATA SAS-data-view <SAS-data-file-1 ... SAS data-file-n> /
                        VIEW=SAS-data-view;
                     <SAS statements>
RUN;
Here is an explanation of the syntax:
SAS-data-view:
names the data view to be created.
SAS-data-file-1 … SAS-data-file-n:
is an optional list that names any data files to be created.
SAS statements:
includes other DATA step statements to create the data view and 
any data files that are listed in the DATA statement.

The VIEW= option tells SAS to compile, but not to execute, the source program 
and to store the compiled code in the DATA step view that is named in the option.*/


/*The following program creates a DATA step view named scoreall that 
concatenate 5 raw external data files using the FILENAME and INFILE statements.
--- creating data step view instead of data set, we have eliminated the need for 
extra amount of work space where a data set “scoreall” would have been stored. 
Next we will join DATA step view 'scoreall' with data set "SD0" 
in a Proc SQL program. */
filename score ("/folders/myfolders/score_month1.txt"
               "/folders/myfolders/score_month2.txt"
               "/folders/myfolders/score_month3.txt"
               "/folders/myfolders/score_month4.txt"
               "/folders/myfolders/score_month5.txt");
data scoreall / view = scoreall;
   infile score;
   input name $ score month $;
run;

proc import datafile = "/folders/myfolders/score_data_id_class" 
DBMS = xlsx out = sd0 (keep = name stu_id gender class) replace ;
run;

proc sql;
create table sdm as 
select a.name, score, month, gender,stu_id,	class
from sd0 as s right join scoreall as a
on s.name = a.name;
quit; 


