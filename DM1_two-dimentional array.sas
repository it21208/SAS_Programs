/*two-dimentional array*/

proc import datafile = "/folders/myfolders/monthly" 
DBMS = xlsx out = monthly replace ;
run;

/*The task is to generate a new data set of 
quarterly sales rather than monthly sales.
*/
data quarters(drop=i j);
   set monthly;
   array m{4,3} month1-month12;
/*Defining the array m{4,3} puts the variables Month1 
through Month12 into four groups/rows of three months/columns
as following:

month1 month2 month3
month4 month5 month6
month7 month8 month9
month10 month11 month12 

*/
    array Qtr{4};
/*Defining the array Qtr{4} creates the numeric variables 
Qtr1, Qtr2, Qtr3, Qtr4, which will be used to sum the 
sales for each quarter.
Each element in the Qtr array represents the sum of one row 
in the m array. 
The number of elements in the Qtr array should match the first 
dimension of the m array */
     do i=1 to 4;
/*This first DO loop executes once for each of the four elements 
of the Qtr array.*/
      qtr{i}=0;
/*The assignment statement, qtr{i}=0, sets the value of qtr{i} 
to zero after each iteration of the first DO loop. 
Without the assignment statement, the values of Qtrl, Qtr2, Qtr3,
and Qtr4 would accumulate across iterations of the DATA step 
due to the qtr{i}+m{i,j} sum statement within the DO loop.*/
       do j=1 to 3;
/*This second DO loop executes the same number of times as the 
second dimension of the m array (that is, the number of columns 
in each row of the m array).*/
          qtr{i}+m{i,j};
          PUTLOG 'check:  ' qtr{i}=;
/*sum statement to sum the monthly sales within a row 
to obtain quartely sale*/
      end;
   end;
run;

proc print data = quarters (keep = year qtr1 - qtr4);
run;



