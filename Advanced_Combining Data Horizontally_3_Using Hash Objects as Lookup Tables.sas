/*Using Hash Objects as Lookup Tables

Beginning with SAS 9, the hash object is available for use in a DATA step. 
The hash object provides an efficient, convenient mechanism 
for quick data storage and retrieval.
A hash object can be loaded from hardcoded values or a SAS data set, 
and exists for the duration of the DATA step.
A hash object resembles a table with rows and columns and contains 
a key component and a data component.

The hash object is a DATA step component object.To use it in your SAS program, 
you must first declare and create the object.

You declare a hash object using the DECLARE statement.
General form, DECLARE statement:
DECLARE object-name <(<argument_tag-1: value-1<, ...argument_tag-n: value-n>>)>;
object: specifies the component object.
Valid values for object are as follows:
hash indicates a hash object.
hiter indicates a hash iterator object.
object-name: specifies the name for the component object.
arg_tag: specifies the information that is used to create an instance of 
the component object.
value: specifies the value for an argument tag. 

Defining Keys and Data:
The keys and the data are DATA step variables that you use to initialize 
the hash object by using object dot notation method calls.
General form, object dot notation method calls:
object.method(<argument_tag-1: value-1<, ...argument_tag-n: value-n>>);
Here is an explanation of the syntax:
object:specifies the name for the DATA step component object.
method:specifies the name of the method to invoke.
argument-tag:identifies the arguments that are passed to the method.
value:specifies the argument value.

A key component
is defined by passing the key variable name to the DEFINEKEY method. 
A data component 
is defined by passing the data variable name to the DEFINEDATA method. 
When all key and data components are defined, the DEFINEDONE method is called. 
Keys and data can consist of any number of character or numeric DATA step variables.

*/

/*the following programs are to combine data set S1 with 'the sale averages by states' info.
retrieved from the created hash object with key State*/ 
proc import datafile = "/folders/myfolders/sale_one sale_extra" 
DBMS = xlsx out = s1 replace ;
run;

/*the following data set S0 is for create hash object as a lookup table
the hash object stores 'the sale averages by states'*/
proc import datafile = "/folders/myfolders/sale_one sale" 
DBMS = xlsx out = s0 replace ;
run; 
proc means data = s0 noprint;
class state;
vars sale;
output out = summary (keep = state saleaverage) mean = saleaverage;
run; 
data summary;
set summary;
saleaverage = round (saleaverage, 1);
where state ne ' ';
run; /*state -- key variable, saleaverage -- data variable*/

data salereport;
   if _N_ = 1 then do;
      declare hash ag (dataset: "summary" );
       ag.definekey("state");
       ag.definedata("saleaverage");
       ag.defineDone();
/*Since the variable saleaverage is not in an input data set and does not appear on the 
left side of an equal sign in an assignment statement, SAS issues a note 
stating that this variable is not initialized.
To avoid receiving these notes, use the CALL MISSING routine with  
variable name as parameters. The CALL MISSING routine assigns a missing value 
to the specified character or numeric variables.*/
       call missing(saleaverage);
   end;
   set s1;
/*Use the FIND method to retrieve matching data from the hash object. 
The FIND method generates a numeric return code that indicates 
whether the key is found in the hash object. 
A return code of zero indicates a successful find. A nonzero value 
indicates a find failure.*/
	RC= ag.find();
   Diff = sale - saleaverage;
   if diff >=0 then performance = 'above or equal average';
   if diff <0 then performance = 'below average';
run;

