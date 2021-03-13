/*SAS processing and Using Macro Quoting Functions to Mask Special
Characters:%STR

When you submit a program, it goes to an area of memory called the input stack.
SAS reads the text in the input stack (left-to-right, top-to-bottom);
then routes text to the appropriate compiler upon demand.

Between the input stack and the compiler, SAS programs are tokenized into smaller
pieces. A component of SAS known as the word scanner divides program text into
fundamental units called tokens.

Input stack --> tokenlized by word scanner: tokens --> compiler

The word scanner recognizes the following token sequences as macro triggers:
• % followed immediately by a name token (such as %let)
• & followed immediately by a name token (such as &amt).*/

/*The %STR Function:::
The %STR function is used to mask tokens during compilation so that the macro processor 
does not interpret them as macro-level syntax.
That is, the %STR function hides the normal meaning of a semicolon and other special
tokens and mnemonic equivalents of comparison or logical operators so that they appear
as constant text. Special tokens and mnemonic equivalents include
; + - * / , < > = blank ^ ~ # |
LT EQ GT AND OR NOT LE GE NE IN

General form, %STR function:
%STR (argument)

argument : is any combination of text and macro triggers.*/

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data1 replace ;
run;

options symbolgen;

%let proc_means = proc means data =score_data1; run;  ;
&proc_means
/*SYMBOLGEN:  Macro variable PROC_MEANS resolves to proc means data =score_data1*/

/* SAS interpreted the first semicolon as the end of the macro assignment statement. 
In this case, we want the semicolon to be part of the macro variable value. 
you need to hide/mask the normal meaning of the semicolon from the macro processor. 
You can use a macro quoting function (such as %STR) to do this. */

%let proc_means = %STR (proc means data =score_data1; run;);
&proc_means


