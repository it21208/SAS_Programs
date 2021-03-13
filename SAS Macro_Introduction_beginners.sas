/*SAS macro introduction

1. Overview:

The macro facility is a tool for extending and customizing SAS and for reducing 
the amount of text that you must enter to do common tasks. 
The macro facility enables you to assign a name to character strings or groups of 
SAS programming statements. You can work with the names that you created rather than 
with the text itself.
The SAS macro language is a string-based language. 

The macro facility has two components:
•	macro processor
is the portion of SAS that does the work
•	macro language
is the syntax that you use to communicate with the macro processor

When SAS compiles program text, two delimiters trigger macro processor activity:
•	&name
refers to a macro variable. 
"Replacing Text Strings Using Macro Variables" section explains how to create a macro variable. 
The form &name is called a macro variable reference.
•	%name
refers to a macro. 
"Generating SAS Code Using Macros " section explains how to create a macro. 
The form %name is called a macro call
*/


/*examples*/
/*a. macro variables */
%let state  = Texas;
title "data for &state";

/*b. macros*/
%macro print;
   proc print data = score_data;
   title 'input data';
   run;
%mend print;

%macro data_info;
   score_data
%mend data_info;


/*2. Replacing Text Strings Using Macro Variables

Macro variables are an efficient way of replacing text strings in SAS code. 
The simplest way to define a macro variable is to use the %LET statement to assign 
the macro variable a name (subject to standard SAS naming conventions), and a value.

You refer to the variable by preceding the variable name with an ampersand (&)

Macro variables are useful for simple text substitution. */

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

%let score = score2;  /*score2, score3*/
/*Now you can use the macro variable SCORE in SAS statements 
where you would like the text score1, score2 or score3 to appear.*/ 

/*The macro processor resolves the reference to the macro variable SCORE*/
proc means data = score_data mean MAXDEC = 1;
var &score;
title "Mean for &score";
run;

/* Note:  The title is enclosed in double quotation marks. In quoted strings in open code, 
the macro processor resolves macro variable references within double quotation marks 
but not within single quotation marks.*/


/*3. Generating SAS Code Using Macros:

Each macro that you define has a distinct name. When choosing a name for your macro, 
it is recommended that you avoid a name that is a SAS language keyword or call routine name. 
A macro definition is placed between a %MACRO statement and a %MEND (macro end) statement: 

		%MACRO macro-name;
		%MEND macro-name;

The macro-name specified in the %MEND statement must match the macro-name specified 
in the %MACRO statement.


To call (or invoke) a macro, precede the name of the macro with a percent sign (%):

 		%macro-name

Although the call to the macro looks somewhat like a SAS statement, it does not 
have to end in a semicolon. */

/*A string inside a macro is called constant text or model text because it is the model, 
or pattern, for the text that becomes part of your SAS program.*/

%macro data_info;
   score_data
%mend data_info;

title "score means from %data_info"; 
/*resolve as*/
title "score means from score_data"; 

proc print data = %data_info; 
title "score means from %data_info"; 
run;

/* Note:  The title is enclosed in double quotation marks. In quoted strings in open code,
the macro processor resolves macro invocations within double quotation marks
but not within single quotation marks.*/

/*You can create macros that contain entire sections of a SAS program:*/

%macro print;
   proc print data = score_data;
   title 'input data';
   run;
%mend print;

%print;

/*4. Passing Information into a Macro Using Parameters
A macro variable defined in parentheses in a %MACRO statement is a macro parameter. 
Macro parameters enable you to pass information into a macro.

Using parameters has several advantages: 
First, you can write fewer %LET statements. 
Second, using parameters ensures that the variables never interfere with 
parts of your program outside the macro. 
Macro parameters are an example of local macro variables, which exist only 
during the execution of the macro in which they are defined.*/

%macro score_mean(score_var= );
   proc means data = score_data mean MAXDEC = 1;
      var &score_var;
   run;
%mend score_mean;

/*You invoke the macro by providing values for the parameters:*/

%score_mean(score_var= score1)
%score_mean(score_var= score2)
%score_mean(score_var= score3)











