/*Using Macro Functions to Manipulate Character Strings:
Macro character functions have the same basic syntax as the corresponding DATA step
functions, and they yield similar results. */

/*The %UPCASE Function
The %UPCASE function enables you to change the value of a macro variable from
lowercase to uppercase before substituting that value in a SAS program.

%UPCASE (argument)

argument: is a character string. */

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data1 replace ;
run; 

/* select students with name contain letter m*/

%let name_m = m;

proc print data = score_data1;
where name contains "&name_m";
title "students with name contain m";
run;

proc print data = score_data1;
where name contains "%upcase(&name_m)";
title "students with name contain M";
run;












