/* Create and use user-defined Functions with PROC FCMP
The SAS Function Compiler (FCMP) procedure enables you to create, test, and 
store user-defined functions, CALL routines, and subroutines for use in 
other SAS procedures and the DATA step.
PROC FCMP makes programming in SAS more efficient by allowing users to 
store frequently used and repetitive code into customizable functions 
and subroutines

General form for a basic PROC FCMP step to create and save a function.
PROC FCMP OUTLIB = libref.data-set.package;
Function function-name(argument-1<$>,...,argument-n<$>);
Programming statements;
Return (expression);
ENDSUB;
QUIT;

OUTLIB: specifies the three-level name of an output package where functions and 
routines are stored. The first level specifies the library name, 
followed by the dataset name (the data set that is contain the function definition. 
This data set is subdivided into packages), and then the specific package. 
Function: begins the definition of the function. The FUNCTION definition ends with 
the ENDSUB statement.
Return: specifies the value that is returned by the function.
Programming statements: are a series of DATA step statements that describe the 
function’s actions.
*/


PROC FCMP OUTLIB = work.functions.func;
function days_diff(start, end);
day_num = end- start;
return (day_num);
ENDSUB;
quit;

/*In order to use the newly-defined function, the following system option must be 
specified. The CMPLIB= option specifies the location of the stored function 
with a two-level name. This location must match the first two levels of the
name given in the FCMP procedure’s OUTLIB= option.

options cmplib = libref.data-set;
.*/
options cmplib=(work.functions);
proc import datafile = "/folders/myfolders/Patient_HD" 
DBMS = xlsx out = PD replace ;
run;
data PD_F;
set PD;
HS = days_diff(start_date, end_date);
run;
