/*SAS macro variables: Introduction

(1)SAS macro variables enable you to substitute text in your SAS programs. Macro
variables can supply a variety of information, including
• operating system information
• SAS session information
• text strings.
When you reference a macro variable in a SAS program, SAS replaces the reference
with the text value that has been assigned to that macro variable. By substituting text
into programs, SAS macro variables make your programs more reusable and dynamic.

(2)There are two types of macro variables:
• automatic macro variables, which are provided by SAS
• user-defined macro variables, whose values you create and define.

(3) In order to substitute the value of a macro variable in your program, you must reference
the macro variable. A macro variable reference is created by preceding the macro
variable name with an ampersand (&). 

If you need to reference a macro variable within quotation marks,
such as in a title, you must use double quotation marks. The macro processor does not
resolve macro variable references that appear within single quotation marks.*/


/*The following sample code shows how a macro variable DATA is used to substitute the data
set information score_data1 throughout a program.
If the data infomation changes, you only need to change the value of
Macro var data throughout the programs:*/

%let data = score_data1;

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = &data replace ;
run;

Proc print data = &data;
title1 "&data information";
run;
proc means data = &data;
title1 "Variable Mean Statistis on &data";
run;
