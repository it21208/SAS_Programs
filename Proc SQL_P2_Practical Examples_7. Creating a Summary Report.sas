/*Practical Examples Using PROC SQL

7. Creating a Summary Report

this example is to create a summary report that shows the rewards points for each student 
for each month.
*/

proc import datafile = "/folders/myfolders/rewards_ponits" 
DBMS = xlsx out = rp_data replace ;
run;


/*Solution:
1. uses an in-line view to create three temporary columns, Jan, Feb, and Mar, 
based on the month part of the Date column. 
The in-line view is a query that performs the following:
	selects the students' Name column
	uses a CASE expression to assign the value of Points to one of three columns, Jan, Feb, 
or Mar, depending on the value of the month part of the Date column

2. The outer SELECT statement in the query performs the following:
	selects the Name of students
	uses the summary function SUM to accumulate the Jan, Feb, and Mar points
	uses the GROUP BY statement to produce a line in the table for each student*/

proc sql;
   	title 'Student Reward Points for Jan., Feb. and Mar.';
   	select Name,
          sum(Jan) label='Jan',
          sum(Feb) label='Feb',
          sum(Mar) label='Mar'
    from (select Name,
      		case
   			when month(Date)=1 then /* when month = 1 then assign values of Points to column Jan*/
      		Points end as Jan,
      		case
   	    	when month(Date)=2 then
        	Points end as Feb,
        	case
   			when month(Date)=3 then
      		Points end as Mar
			from rp_data)
    group by Name;
quit;

/*result from in-line view */
proc sql;
select Name,
      		case
   			when month(Date)=1 then /* when month = 1 then assign values of Points to column Jan*/
      		Points end as Jan,
      		case
   	    	when month(Date)=2 then
        	Points end as Feb,
        	case
   			when month(Date)=3 then
      		Points end as Mar
			from rp_data;
quit;			