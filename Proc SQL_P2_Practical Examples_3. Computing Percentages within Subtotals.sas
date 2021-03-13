/*Practical Examples Using PROC SQL

3. Computing Percentages within Subtotals

Want to compute:
percent of students wait in carline (Yes on Carline) and 
not wait in carline (No on Carline) for each class
*/

proc import datafile = "/folders/myfolders/carline info"
dbms = xlsx out = cldata replace;
run;

/*This example:

1. Subquery: uses a subquery to calculate the subtotal counts for each value of Carline. 

2. Select Clause: 
A. count Class by each value of Class and Carline combination (Group By Clause)
B. uses the calculated Class count as the numerator and the subtotal from the subquery as 
the denominator for the percentage calculation.

3. From Clause: The code joins the result of the subquery (subtotal of Yes, No on carline) 
with the original table on Where clause (explain and show in second Proc SQL program)
*/

proc sql;
   title1 'percent of students wait in carline for each class';
   select cldata.carline, class, count(class) as Count,  
          calculated Count/Subtotal as Percent format=percent8.2
   from cldata,
        (select carline, count(carline) as Subtotal from cldata
            group by carline) as cldata2
   where cldata.carline = cldata2.carline
   group by cldata.carline, class;
quit;

proc sql;

select cldata.carline, class, count(class) as Count from cldata
group by cldata.carline, class;

select carline, count(carline) as Subtotal from cldata
            group by carline;
            
run; 





