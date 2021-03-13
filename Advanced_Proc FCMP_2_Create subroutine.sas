/*CREATE and use SUBROUTINES WITH PROC FCMP
One limitation of functions is that only one value can be returned. Oftentimes, 
it can be advantageous to have multiple values returned or updated and this 
can be done in PROC FCMP with subroutines. 
Subroutines work similarly to how functions work in that variables are taken in 
as arguments and can be manipulated to return new values. 
The SUBROUTINE statement names the block of code that is processed 
and specifies the parameters. 
The OUTARGS statement specifies the parameters that the subroutine returns. 
The ENDSUB statement ends the definition of the subroutine. */

/*In this example, a subroutine named CIRCLE is created with three numeric variables 
as arguments. The subroutine finds the area and circumference of a circle with 
the given radius using 3.14 for pi. 
The OUTARGS statement is specified to return AREA and CIRCUM.*/ 
PROC FCMP OUTLIB = work.functions.subR;
subroutine circle(radius, area, circum);
outargs area, circum;
area = 3.14 * radius ** 2;
circum = 3.14 * 2 * radius;
ENDSUB;
quit;
/*The code below shows how the subroutine is called in a DATA step.
Calling a subroutine in a DATA step is different from calling a function. 
Variables that are returned in the OUTARGS statement must be initialized 
before the routine can be called. 
In this example, the DATA step first initializes AREA and CIRCUM to missing values. 
Then, a do loop is created to generate ten observations with radius equal to the
iterator. The CALL statement calls the subroutine CIRCLE created in the PROC FCMP step, 
with the variables specified for all three arguments. Once called, the subroutine 
replaces the missing values for AREA and CIRCUM with the calculated values.*/
options cmplib=(work.functions);
data example;
area=.;
circum=.;
do i=1 to 10;
radius=i;
call circle(radius, area, circum);
output;
end;
run;
proc print data=example;
var radius area circum;
run;
