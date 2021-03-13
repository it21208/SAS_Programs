/*Processing Statements Iteratively:
Many macro applications require iterative processing. With the iterative %DO statement
that you can repeatedly
• execute macro programming code
• generate SAS code.

General form, iterative %DO statement with %END statement:
%DO index-variable=start %TO stop <%BY increment>;
text
%END;

Here is an explanation of the syntax:
index-variable: is either the name of a macro variable or a text expression that generates a macro variable
name.
start and stop: integers to control how many times the portion of the macro 
between the iterative %DO and %END statements is processed.
increment: specifies an integer to be added to the value of the index variable 
in each iteration of the loop. By default, increment is 1.

%DO and %END statements are valid only inside a macro definition. The index-variable
is created in the local symbol table if it does not appear in any existing symbol table.
*/

/*The following macro uses a %DO statement to create a loop that creates a data set from
each of the specified external files:*/
OPTIONS MPRINT MLOGIC;
%macro readraw(first=1,last=5);
 %local month;
 %do month=&first %to &last;
 
 proc import datafile = "/folders/myfolders/score_month&month" 
 DBMS = xlsx out = score_month&month replace ;
 run;
 proc print data=score_month&month;
 title "score infromation for month&month";
 run;
 
 %end;
%mend readraw;

%readraw(first=1,last=5)
/*The macro creates five data sets named score_month1, score_month2, ..., score_month5. 
Remember that in order for this program to run properly, the raw data files must be named
appropriately, and they must be stored in the location that the program specifies.*/


