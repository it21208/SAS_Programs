/* Automatic macro variables:::
SAS creates and defines several automatic macro variables for you. Automatic macro
variables contain information about your computing environment, such as the date and
time of the session, and the version of SAS that you are running. 

Some automatic macro variables have fixed values that are set when SAS is invoked.
SYSDATE the date of the SAS invocation (DATE7.)
SYSDATE9 the date of the SAS invocation (DATE9.)
SYSDAY the day of the week of the SAS invocation
SYSTIME the time of the SAS invocation

Some automatic macro variables have values that automatically change based on
submitted SAS statements.
SYSLAST the name of the most recently created SAS data set, in the form
	LIBREF.NAME. This value is always stored in all capital letters. If no data
	set has been created, the value is _NULL_
SYSPARM text that is specified when SAS is invoked
SYSERR contains a return code status that is set by the DATA step and some SAS
	procedures to indicate whether the step or procedure executed successfully*/

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

footnote1 "Created &systime &sysday, &sysdate9";
proc means data = score_data;
title1 "Variable Mean Statistis on score_data";
run;
/*time of day (SYSTIME)
day of the week (SYSDAY)
date (day, month, and year) (SYSDATE9)*/
