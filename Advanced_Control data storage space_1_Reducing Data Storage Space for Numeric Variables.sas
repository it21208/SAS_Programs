/*Reducing length for Numeric Variables
One way to reduce data storage space is to reduce the length of numeric variables. 
In addition to conserving data storage space, reduced-length numeric variables use 
less I/O, both when data is written and when it is read. For a file that is read 
frequently, this savings can be significant.
To store numbers of large magnitude and to perform computations that require 
many digits of precision to the right of the decimal point, SAS stores all numeric 
values using double-precision floating-point representation. SAS numeric variables 
have a maximum length of 8 bytes and a minimum length of 2 or 3 bytes, 
depending on your operating environment. The default length is 8 bytes. 
The minimum length for a numeric variable is 2 bytes in mainframe environments and 
3 bytes in non-mainframe environments.

--------------------------------------------------------------------------

Assigning Lengths to Numeric Variables
You can use a LENGTH statement to assign a length from 2 to 8 bytes to 
numeric variables. Remember, the minimum length of numeric variables 
depends on the operating environment. 
Also, keep in mind that the LENGTH statement affects the length of a numeric 
variable only in the output data set. 
Numeric variables always have a length of 8 bytes in the program data vector 
and during processing.

General form, LENGTH statement for numeric variables:
LENGTH variable(s) length <DEFAULT=n>;

Here is an explanation of the syntax:
variable(s):
specifies the name of one or more numeric SAS variables, separated by spaces.
length:
is an integer that specifies the length of the variable(s).
DEFAULT =n:
this optional argument changes the default number of bytes that SAS uses 
to store any newly created numeric variables. 
If you use the DEFAULT= argument, you do not need to list any variables.
DEFAULT= applies only to numeric variables that are created after 
the LENGTH statement. 
List specific variables, and their lengths, along with the DEFAULT= argument, 
if you want the listed variables to receive a specified length. 
Then the non- listed variables receive the DEFAULT= length.
CAUTION: Numeric values lose precision if truncated. 
*/
proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = sd replace ;
run;

/*The following program assigns a length of 4 to the new variable 
average_score in the data set SD1. 
The LENGTH statement in this DATA step does not apply to the variables 
that are read from the SD data set; 
those variables maintain whatever length they had in SD data
*/

data sd1;
   length default=4;
   set sd;
   average_score = mean (score1, score2, score3);
run; 
/* 3 score vars with length = 8, average_score with length = 4*/

/*Maintaining Precision in Reduced-Length Numeric Variables
There is a limit to the values that you can precisely store in a reduced-length 
numeric variable. You have learned that reducing the number of bytes that are 
used for storing a numeric variable does not affect how the numbers are stored 
in the program data vector. Instead, specifying a value of less than 8 in the 
LENGTH statement causes the number to be truncated to the specified length when 
the value is written to the SAS data set.

You should never use the LENGTH statement to reduce the length of your numeric 
variables if the values are not integers. Fractional numbers lose precision 
if truncated. Even if the values are integers, you should keep in mind that 
reducing the length of a numeric variable limits the integer values that can 
accurately be stored as a value.

If you decide to reduce the length of your numeric variables, you might want to 
verify that you have not lost any precision in your values. 
Here is one way to do this action.

Using PROC COMPARE
You can use PROC COMPARE to gauge the precision of the values that are stored 
in a shortened numeric variable. You do this by comparing the original variable 
with the shortened variable. 
The COMPARE procedure compares the contents of two SAS data sets, selected 
variables in different data sets, or variables within the same data set.

General form, PROC COMPARE step to compare two data sets:
PROC COMPARE BASE=SAS-data-set-one
               COMPARE=SAS-data-set-two;
RUN;

Here is an explanation of the syntax:
SAS-data-set-one and SAS-data-set-two:
specifies the two SAS data sets that you want to compare.

PROC COMPARE is a good technique to use for gauging the loss of precision in 
shortened numeric variables because it shows you whether there are differences 
in the stored numeric values even if these differences do not appear once the 
numeric variables have been formatted.
*/
data sd1_;
   *length default=4;
   set sd;
   average_score = mean (score1, score2, score3);
run; 

proc compare base=SD1
             compare=SD1_;
run;
