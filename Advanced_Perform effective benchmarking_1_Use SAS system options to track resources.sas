/*Use SAS system options to track resources

You can specify one or more of the SAS system options STIMER, MEMRPT, 
FULLSTIMER, and STATS to track and report on resource use. 
The availability, usage, and functionality of these options 
vary by operating environment, as described in detail below from  
SAS Advanced Programming Certification Prep Guide.
I also included the table in the description box of this lecture.

STIMER
z/OS:::
Specifies that the CPU time is to be tracked throughout the SAS session.
Can be set at invocation only.
Is the default setting.
UNIX and Windows:::
Specifies that CPU time and real-time statistics are to be tracked and written to the SAS log throughout the SAS session.
Can be set either at invocation or by using an OPTIONS statement.
Is the default setting.

MEMRPT
z/OS::::
Specifies that memory usage statistics are to be tracked throughout the SAS session.
Can be set either at invocation or by using an OPTIONS statement.
Is the default setting.
UNIX and Windows:::
Not available as a separate option; this functionality is part of the FULLSTIMER option.

FULLSTIMER
z/OS:::
Specifies that all available resource usage statistics are to be tracked and written to the SAS log throughout the SAS session.
Can be set either at invocation or by using an OPTIONS statement.
In the z/OS operating environment, FULLSTIMER is an alias for the FULLSTATS option.
This option is ignored unless STIMER or MEMRPT is in effect.
UNIX and Windows:::
Specifies that all available resource usage statistics are to be tracked and written to the SAS log throughout the SAS session.
Can be set either at invocation or by using an OPTIONS statement.
In Windows operating environments, some statistics are not calculated accurately unless FULLSTIMER is specified at invocation.

STATS
z/OS:::
Tells SAS to write statistics that are tracked by any combination of the preceding options to the SAS log.
Can be set either at invocation or by using an OPTIONS statement.
Is the default setting.
UNIX and Windows:::
Not available as a separate option.
*/

/*OPTIONS STIMER|NOSTIMER;
options STIMER; -- default, print the real time and CPU time in Log 
aftre each step*/
data teacherid;
input tid;
datalines; 
201
202
203
204
;
run;
/*
 NOTE: The data set WORK.TEACHERID has 4 observations and 1 variables.
 NOTE: DATA statement used (Total process time):
       real time           0.00 seconds
       cpu time            0.01 seconds
*/
options NOSTIMER;
data teacherid;
input tid;
datalines; 
201
202
203
204
;
run;

/*OPTIONS FULLSTIMER|NOFULLSTIMER;
provides additional statistics*/
Options FULLSTIMER;
data teacherid;
input tid;
datalines; 
201
202
203
204
;
run;
Options NOFULLSTIMER;

/*some options are only avialable in z/OS operating system:
OPTIONS STATS|NOSTATS;
OPTIONS MEMRPT|NOMEMRPT;
*/

