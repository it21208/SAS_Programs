/*Creating and Using Macro Programs: Basic Concepts:
Like macro variables, macro programs (also known as macros) enable you to substitute
text into your SAS programs. Macros are different from macro variables because they
can use conditional logic to make decisions about the text that you substitute into your
programs.

(1) Defining a Macro by including %MACRO statement, and %MEND statement:

%MACRO macro-name;    
text
%MEND <macro-name - optional>;   

(2) In order to use this macro later in your SAS programs, you must first compile it by
submitting the macro definition

The MCOMPILENOTE= option causes a note to be issued to the SAS log when a macro
has completed compilation.

OPTIONS MCOMPILENOTE= NONE | NOAUTOCALL | ALL;
NONE: default
NOAUTOCALL: specifies a note for all macros except autocall macros
ALL: specifies a note for all macros

(3)Calling Macros:
you can call a macro program and use it in your SAS programs for the
duration of your SAS session without resubmitting the macro definition. 
A macro call is specified by placing a percent sign (%) before the name of the macro,
It requires no semicolon, a semicolon after a macro call might lead to errors
 */
 
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

OPTIONS MCOMPILENOTE= ALL;
%macro print;
   proc print data = score_data;
   title 'input data';
   run;
%mend print;

%print