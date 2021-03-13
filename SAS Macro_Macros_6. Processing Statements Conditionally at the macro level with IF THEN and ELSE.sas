/*Processing Statements Conditionally at the macro level:

(1) You can perform conditional execution at the macro level with %IF-%THEN and
%ELSE statements.

General form, %IF-%THEN and %ELSE statements:
%IF expression %THEN text;
<%ELSE text;>

expression can be any valid macro expression that resolves to an integer.
The %ELSE statement is optional. However, the macro language does not contain a
subsetting %IF statement. Thus, you cannot use %IF without %THEN.

(2) Simple %DO and %END statements are often used with %IF-%THEN/
%ELSE statements. Each %DO statement must be paired with an %END statement.

General form, %DO-%END with %IF-%THEN and %ELSE statements:
%IF expression %THEN %DO;
text and/or macro language statements
%END;
%ELSE %DO;
text and/or macro language statements
%END;

text and/or macro language statements: is either constant text, a text expression, 
and/or a macro statement.
Note: The statements %IF-%THEN, %ELSE, %DO, and %END are macro language
statements that can be used only inside a macro program
*/


OPTIONS MPRINT MLOGIC; 
proc import datafile = "/folders/myfolders/score_data_id_class" 
DBMS = xlsx out = score_data replace ;
run;

%macro counts (cols=,rows=,data=score_data); 
 proc freq data=&data;
 tables
 %if &rows ne %then %do;
 &rows * &cols;
 title2 "two way table for &data data set";
 %end;
 %else %do;
 &cols;
 title2 "one way table for &data data set";
 %end;
 run;
%mend counts;
%counts (cols=gender,rows=class)
%counts (cols=gender)

