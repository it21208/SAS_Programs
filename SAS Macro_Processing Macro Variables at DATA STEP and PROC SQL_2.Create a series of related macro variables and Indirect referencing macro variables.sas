/* Create a series of related macro variables with SYMPUT and Indirect referencing macro variables
with &&:  
two knowledge points: 
(1) Creating Multiple Macro Variables with CALL SYMPUT:
Sometimes you might want to create multiple macro variables within one DATA step. 
To create multiple macro variables, you use the SYMPUT routine with DATA step expressions 
for both arguments.

General form, SYMPUT routine with DATA step expressions:

CALL SYMPUT(expression1,expression2);

expression1: evaluates to a character value that is a valid macro variable name. 
This value should change each time you want to create another macro variable.
expression2: is the value that you want to assign to a specific macro variable.

(2) Referencing Macro Variables Indirectly (a reference whose value is a reference 
to a different macro variable) and The Forward Re-Scan Rule

The Forward Re-Scan rule can be summarized as follows:
• When multiple ampersands or percent signs precede a name token, the macro
processor resolves two ampersands (&&) to one ampersand (&), and re-scans the
reference.
• To re-scan a reference, the macro processor scans and resolves tokens from left to
right from the point where multiple ampersands or percent signs are coded, until no
more triggers can be resolved.

Indirect referencing is especially useful when you are working with a series of related
macro variables.
*/


option symbolgen;
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

/*use following program to create score report for individual student*/
data score_data1;
 set score_data;
 call symput('student'||left(stu_id), trim(name)); 
run;

%let stu_id=1;
proc print data=score_data1;
 where stu_id=&stu_id;
 var name gender score1 score2 score3;
 title1 "Individual Student Score Information for Student &stu_id";
 footnote1 "Score Information for &&student&stu_id";
/*&& --> &, &stu_id --> 1, &&student&stu_id --> &student1 --> the value of Name for this student*/
run;

