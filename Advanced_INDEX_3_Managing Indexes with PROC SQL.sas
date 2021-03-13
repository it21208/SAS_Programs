/*Managing Indexes with PROC SQL:
You can also create or delete indexes from an existing data set within 
a PROC SQL step. 
The CREATE INDEX statement enables you to create an index on a data set. 
The DROP INDEX statement enables you to delete an index from a data set.

General form, PROC SQL to create and delete an index:

PROC SQL;
     CREATE <UNIQUE > INDEX index-name
          ON table-name(column-name-1<…,column-name-n>);
     DROP INDEX index-name FROM table-name;
QUIT;

Here is an explanation of the syntax:
index-name:
is the same as column-name-1 if the index is based on the values of one column only.
index-name:
is not the same as any column-name if the index is based on multiple columns.
table-name:
is the name of the data set that index-name is associated with.
*/
OPTIONS MSGLEVEL= I;
LIBNAME score "/folders/myfolders";
proc sql;
   create index stu_id on score.score_data(stu_id);
   drop index stu_id from score.score_data;
   create index Sid_name on score.score_data(stu_id, name);
quit;
proc SQL;
drop index Sid_name from score.score_data;
quit;
