/*Using Macro Functions to Manipulate Character Strings:
The %SUBSTR function enables you to extract part of a character string from the value
of a macro variable.

General form, %SUBSTR function:
%SUBSTR (argument, position<,n>)

***argument: is a character string or a text expression from which a substring is returned.
***position: is an integer or an expression (text, logical, or mathematical) that yields an integer, which
specifies the position of the first character in the substring.
***n: is an optional integer or an expression (text, logical, or mathematical) that yields an integer
that specifies the number of characters in the substring. If n is not specified, %SUBSTR
also returns a substring that contains the characters from position to the end of the
string.*/


proc import datafile = "/folders/myfolders/score_data_miss_birthdate_new" 
DBMS = xlsx out = score_data1 replace ;
run; 

/* select students with birthdate in 2007*/
%let BD07_e = 31Dec2007;

proc print data = score_data1;
where birthdate between
 "01Jan2007"d and
 "31%substr(&BD07_e,3)"d;
 /*31->text, %substr(&BD07_e,3) --> %substr(31Dec2007,3)--> Dec2007
 "31%substr(&BD07_e,3)"d --> "31Dec2007"d*/
title "all students with birthdate in 2007";
run;


