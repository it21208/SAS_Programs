/*Combining Queries with Set Operators*/

/**********************OVERVIEW**********************
whereas join operations combine tables horizontally, set operations combine tables vertically. */

/*Working with Two or More Query Results:
PROC SQL can combine the results of two or more queries in various ways 
by using the following set operators:
•	UNION
produces all unique rows from both queries.
•	EXCEPT
produces rows that are part of the first query only.
•	INTERSECT
produces rows that are common to both query results.
•	OUTER UNION
concatenates the query results.*/

/*The operator is used between the two queries, for example:
________________________________________

select columns from table
set-operator
select columns from table;
________________________________________
*Place a semicolon after the last SELECT statement only. 
*Set operators combine columns from two queries based on their position in the referenced tables 
without regard to the individual column names. 
*Columns in the same relative position in the two queries must have the same data types. 
*The column names of the tables in the first query become the column names of the output table.*/ 

/*The following optional keywords give you more control over set operations:
•	ALL
does not suppress duplicate rows. When the keyword ALL is specified, PROC SQL does not make a second 
pass through the data to eliminate duplicate rows. Thus, using ALL is more efficient than not using 
it. ALL is not allowed with the OUTER UNION operator.
•	CORRESPONDING (CORR)
overlays columns that have the same name in both tables. When used with EXCEPT, INTERSECT, and UNION, 
CORR suppresses columns that are not in both tables. */


/*******************************************OVERVIEW ENDS********************************************/

/*data sets to be used*/
proc import datafile = "/folders/myfolders/math_score_so" 
DBMS = xlsx out = MATH replace;
run; 

proc import datafile = "/folders/myfolders/READ_score_so" 
DBMS = xlsx out = READ replace;
run; 

/*1. Producing Unique Rows from Both Queries (UNION)
 
The UNION operator combines two query results. It produces all the unique rows that result from both queries. 
That is, it returns a row if it occurs in the first table, the second, or both. UNION does not return 
duplicate rows. If a row occurs more than once, then only one occurrence is returned.*/

proc print data = math; run;
proc print data = read; run;

proc sql;
   title 'UNION';
   select * from math
   union
   select * from read;

/*You can use the ALL keyword to request that duplicate rows remain in the output.*/
proc sql;
   title 'UNION ALL';
   select * from math
   union all
   select * from read;


/*2. Producing Rows That Are in Only the First Query Result (EXCEPT)
 
The EXCEPT operator returns rows that result from the first query but not from the second query. */
proc print data = math; run;
proc print data = read; run;

proc sql;
   title 'EXCEPT';
   select * from math
   except
   select * from read;

/*Note that the duplicated row in Table Math does not appear in the output. 
EXCEPT does not return duplicate rows that are unmatched by rows in the second query. 
Adding ALL keeps any duplicate rows that do not occur in the second query.

You can use the ALL keyword to request that duplicate rows remain in the output.*/
proc sql;
   title 'EXCEPT ALL';
   select * from math
   except all
   select * from read;
   
/*3. Producing Rows That Belong to Both Query Results (INTERSECT)
 
The INTERSECT operator returns rows from the first query that also occur in the second.*/

proc print data = math; run;
proc print data = read; run;

proc sql;
   title 'INTERSECT';
   select * from math
   intersect
   select * from read;
   
/*The output of an INTERSECT ALL operation contains the rows produced by the first query that are 
matched one-to-one with a row produced by the second query, so the output of INTERSECT 
ALL is the same as INTERSECT.*/
proc sql;
   title 'INTERSECT ALL';
   select * from math
   intersect all
   select * from read;
   
/*4. Concatenating Query Results (OUTER UNION)
 
The OUTER UNION operator concatenates the results of the queries.*/

proc print data = math; run;
proc print data = read; run;

proc sql;
   title 'OUTER UNION';
   select * from math
   outer union
   select * from read;

/*Notice that OUTER UNION does not overlay columns from the two tables. To overlay columns 
in the same position, use the CORR keyword*/
proc sql;
   title 'OUTER UNION CORR';
   select * from math
   outer union CORR
   select * from read;

/*5. Producing Rows from the First Query or the Second Query
 
There is no keyword in PROC SQL that returns unique rows from the first or second table, 
but not rows that occur in both. Here is one way that you can simulate this operation:
________________________________________

(query1 except query2)
union
(query2 except query1)
________________________________________ */

/*The first EXCEPT returns unique rows from the first table (table math) only. 
The second EXCEPT returns unique rows from the second table (table read) only. 
The middle UNION combines the two results. 
Thus, this query returns the rows from the first table that is not in the second table, 
as well as the rows from the second table that is not in the first table.*/
proc print data = math; run;
proc print data = read; run;

proc sql; 
title 'EXCLUSIVE UNION';
   (select * from math
         except
   select * from read)
   union
   (select * from read
         except
	select * from math);
	
















