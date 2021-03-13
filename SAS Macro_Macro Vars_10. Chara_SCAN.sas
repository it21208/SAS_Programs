/*The %SCAN function 
enables you to extract words from the value of a macro variable.

General form, %SCAN function:
%SCAN (argument, n<,delimiters>)

argument: consists of constant text, macro variable references, etc.
n: is an integer which specifies the position of the word to return. 
delimiters: specifies an optional list of one or more characters that separate "words" that yield one or more characters. 
The default delimiters are: 
 blank . < ( + | & ! $ * ) ; ¬ - / , % ¦ ¢
*/
proc import datafile = "/folders/myfolders/score_data_miss_birthdate_new" 
DBMS = xlsx out = score_data1 replace ;
run;

/* select students with birthdate in 2007*/

%let BD07_e = Dec/2007;

proc print data = score_data1;
where birthdate between
 "01Jan2007"d and
 "31%scan(&BD07_e,1)2007"d;
 /*%scan(&BD07_e,1) --> %scan(Dec/2007,1) --> Dec   (/ -- default delimiter)
 31 and 2007 are simple texts
 "31%scan(&BD07_e,1)2007"d --> "31Dec2007"d*/
title "all students with birthdate in 2007";
run;