/* More on Using Macro Quoting Functions to Mask Special
Characters:%STR

More ways using %STR*/

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data1 replace ;
run;
options symbolgen;

/*from last tutorial*/
%let proc_means = %STR (proc means data =score_data1; run;);
&proc_means

/* can also only mask/quote semicolon ( ; ) using %str(;) */
%let proc_means = proc means data =score_data1 %str(;) run %str(;);
&proc_means

/*You could create an additional macro variable %let s=%str(;);, assign a quoted value to it, and
reference it in the assignment statement for the Proc_means macro variable.  */
%let s= %str(;);
%let proc_means = proc means data =score_data1 &s run &s;
&proc_means






