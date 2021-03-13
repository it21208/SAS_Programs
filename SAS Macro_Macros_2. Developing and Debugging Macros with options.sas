/* Developing and Debugging Macros with options:

There are SAS system options that can display information about the execution of a
macro in the SAS log. This can be especially helpful for debugging purposes.

(1) The MPRINT Option:
When the MPRINT option is specified, the text that is sent to the SAS compiler as a
result of macro execution is printed in the SAS log.

General form, MPRINT | NOMPRINT option:
OPTIONS MPRINT | NOMPRINT;

NOMPRINT: default 
MPRINT: the text that is sent to the compiler when a macro executes is printed in the
SAS log.

(2) The MLOGIC Option
Another system option that might be useful when you debug your programs is the
MLOGIC option. The MLOGIC option prints messages that indicate macro actions that
were taken during macro execution.

General form, MLOGIC | NOMLOGIC option:
OPTIONS MLOGIC | NOMLOGIC;

NOMLOGIC: default 
MLOGIC: messages about macro actions are printed to the log during macro execution.

The MLOGIC option, along with the SYMBOLGEN option, is typically turned
• on for development and debugging purposes
• off when the application is in production mode.*/

proc import datafile = "/folders/myfolders/score_data_id" 
DBMS = xlsx out = score_data replace ;
run;

OPTIONS MPRINT;
%macro print;
   proc print data = score_data;
   title "input data on &sysdate";
   run;
%mend print;
%print
/*The messages that are written to the SAS log show the text that is sent to the compiler.
Notice that the macro variable reference (&sysdate) is resolved to the date of the SAS invocation
in the MPRINT messages that are written to the SAS log.*/

OPTIONS MLOGIC;
%macro print;
   proc print data = score_data;
   title "input data on &sysdate";
   run;
%mend print;
%print
/*When this code is submitted, the messages that are written to the SAS log show the
beginning and the end of macro processing.*/