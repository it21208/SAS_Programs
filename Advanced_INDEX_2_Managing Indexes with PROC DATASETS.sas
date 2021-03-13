/*Managing Indexes with PROC DATASETS:
You can use the DATASETS procedure to manage indexes on an existing data set. 
This uses fewer resources than rebuilding the data set. 
You use the MODIFY statement with the INDEX CREATE statement to create indexes 
on a data set. 
You use the MODIFY statement with the INDEX DELETE statement 
to delete indexes from a data set. 
You can also use the INDEX CREATE statement and the INDEX DELETE statement 
in the same step.

General form, PROC DATASETS to create and delete an index:

PROC DATASETS LIBRARY= libref <NOLIST>;
     MODIFY SAS-data-set-name;
     INDEX DELETE index-name;
     INDEX CREATE index-specification;
QUIT;
Here is an explanation of the syntax:
libref:
points to the SAS library that contains SAS-data-set-name.
NOLIST:
option suppresses the printing of the directory of SAS files in the SAS log and 
as ODS output.
index-name:
is the name of an existing index to be deleted.
index-specification:
for a simple index is the name of the key variable.
index-specification:
for a composite index is index-name=(variable-1…variable-n).

The INDEX CREATE statement in PROC DATASETS cannot be used if the index to be 
created already exists. In this case, you must delete the existing index of 
the same name, and then create the new index since PROC DATASETS executes 
statements in order
*/

OPTIONS MSGLEVEL= I;
LIBNAME score "/folders/myfolders";

data sd1 (index=(stu_id/unique name));
   set score.score_data;
run;

/*The following example first deletes the stu_id and name indexes from the sd1 data 
set, and creates two new indexes: stu_id (simple) and Sid_name(composite) on the sd1 data set. 
*/
proc datasets library=work nolist;
   modify sd1;
   index delete name stu_id;
   index create stu_id/unique;
   index create Sid_name=(stu_id name);
quit;

