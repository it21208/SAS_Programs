/*Obtaining Macro Variable Values during DATA Step Execution:
suppose you want to obtain the value of a macro variable during DATA step execution.
You can obtain a macro variable's value during DATA step execution by using the
SYMGET function. The SYMGET function returns the value of an existing macro
variable.

General form, SYMGET function:
SYMGET(macro-variable)

macro-variable can be specified as one of the following:
• a macro variable name, enclosed in quotation marks
• a DATA step variable name whose value is the name of a macro variable
• a DATA step character expression whose value is the name of a macro variable.

*/

option symbolgen;
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

data score_data1;
 set score_data;
 call symput('student'||left(stu_id), trim(name)); 
run;

data score_data2;
 set score_data1;
 student_name_fromMacro = symget ('student'||left(stu_id));
run;