/*Practical Examples Using PROC SQL

5. Expanding Hierarchical Data in a Table

You want to generate an output that shows a hierarchical relationship among rows in a table.

You want to create output that shows the name and ID number of each teacher who has a supervisor, 
along with the name and ID number of that teacher's supervisor.*/

proc import datafile = "/folders/myfolders/teacher id"
dbms = xlsx out = teacher_id replace;
run;

/*This solution 

uses a self-join to match teachers and their supervisors. 

When PROC SQL applies the WHERE clause, the two table are joined. 
The WHERE clause conditions restrict the output to only those rows in table A 
that have a supervisor ID that matches an teacher ID in table B. 

This operation provides a supervisor ID and name for each employee in the original table, 
except for those who do not have a supervisor.*/
proc sql;
   select a.ID "teacher id",    a.name "teacher name",
   		  b.ID "supervisor id", b.name "supervisor name"
      from teacher_id as A, teacher_id as B /*self-join*/
      where  A.Supervisor = B.ID and a.supervisor is not missing;
quit;


