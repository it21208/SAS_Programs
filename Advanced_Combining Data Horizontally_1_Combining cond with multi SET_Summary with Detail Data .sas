/*Combining Summary Data and Detail Data:
combine conditinally with multiple SET statements

In this eample, we want to calculate the percentages of 
each employee's sale to the total sale for each month. 
One way to do that is
1. Using Proc Means to calculate the total sale (sum) for each month
(3 sale vars sale_m1, sale_m2, sale_m3 )
2. combine the total sale info with the input sale data 
3. calculate the % = each employee's sale for each month / total sale for each month 
*/

proc import datafile = "/folders/myfolders/sale_m123" 
DBMS = xlsx out = sale0 replace ;
run;
/*The descriptive statistics can be generated to a SAS data set 
by using an OUTPUT statement. 
The default report can be suppressed by using the NOPRINT option.
In this example, we onlu need the SUM statistics*/
proc means data=sale0 noprint;
   var sale_m1 sale_m2 sale_m3;
   output out=summary sum=salesum_m1 salesum_m2 salesum_m3;
run;
/*two additional variables that are automatically included, as follows:
_TYPE_ contains information about the class variables
_FREQ_ contains the number of observations that an output level represents.*/
proc print data=summary;
run;

/*use multiple SET statement conditinaly combine the two data sets:
Summary and Sale0 --> calculate %
the automatic variable _N_ tracks of how many times the DATA step iterates.
if _N_ = 1, the 1st SET statement brings in summary data set which only contains 
one obs. The values of total sales are retained as each observation is read from sale0.
The second SET statement reads the first observation in data Sale0.
For 2nd iteration, _N_ = 2 false for 1st SET, then move to 2nd SET to bring in 2nd 
obs of data Sale0....
Percentages are calculated for each Obs in the data Sale0...*/
data sp;
   if _N_=1 then set summary(keep=salesum_m1 salesum_m2 salesum_m3);
   set sale0;
   PctSale_m1=sale_m1/salesum_m1;
   PctSale_m2=sale_m2/salesum_m2;
   PctSale_m3=sale_m3/salesum_m3;
format PctSale_m1 PctSale_m2 PctSale_m3 PERCENT10.2;
run;