/* access OBS with Index:
Index Overview
An index can help you quickly locate one or more observations 
that you want to read. Indexes provide direct access to observations 
in SAS data sets based on values of one or more key variables. 
Without an index, SAS accesses observations sequentially, in the order in which 
they are stored in a data set. 

You can create two types of indexes: 
• a simple index: consists of the values of one key variable, which can be 
character or numeric. When you create a simple index, 
SAS names the index after the key variable.
• a composite index: consists of the values of multiple key variables, which 
can be character, numeric, or a combination. The values of these key 
variables are concatenated to form a single value. When you create a 
composite index, you must specify a unique index name that is not 
the name of any existing variable or index in the data set.
-------------------------------------------------------------------

Creating Indexes in the DATA Step: 
To create an index at the same time that you create a data set, 
use the INDEX= data set option in the DATA statement.

General form, DATA statement with the INDEX= option:

DATA SAS-data-file-name (INDEX=
         (index-specification-1</UNIQUE><…index-specification-n>
         </UNIQUE>));

Here is an explanation of the syntax:

SAS-data-file-name:

is a valid SAS data set name.

index-specification:

for a simple index is the name of the key variable.

index-specification:

for a composite index is (index-name=(variable-1…variable-n)).

UNIQUE:

specifies that values for the key variable must be unique for 
each observation. If having duplicate values, log shows error message and 
the index is not created.

You can create multiple indexes on a single SAS data set. 
However, keep in mind that creating and storing indexes 
does use system resources. Therefore, you should create indexes 
only on variables that are commonly used to select observations.

--------------------------------------------------------------------
/*When you create or use an index, you might want to verify that it has been 
created or used correctly. To display information in the SAS log concerning 
index creation or index usage, set the value of the MSGLEVEL= system option to I.

General form, MSGLEVEL= system option:

OPTIONS MSGLEVEL= N|I;
Here is an explanation of the syntax:
N: prints notes, warnings, and error messages only. This is the default.
I:prints additional notes or INFO messages pertaining to index usage, merge processing, 
and sort utilities along with standard notes, warnings, and error messages.
*/

OPTIONS MSGLEVEL= I;
LIBNAME score "/folders/myfolders";

/*creates two simple indexes on the sd1 data set. 
The first index is named Stu_id, and it contains unique values of the Stu_id variable.
The second index is named Name which contains values of the Name variable*/
data sd1 (index=(stu_id/unique name));
   set score.score_data;
run;
proc print data = sd1;
where stu_id in (3,7);
run;

/*The following example creates a composite index 
on the sd2 data set. The index is named Sid_name, 
and it contains concatenated values of the stu_id 
variable and the Name variable.*/

data sd2 (index=(Sid_name=(stu_id name)));
   set score.score_data;
run;






