
libname myfmts "/folders/myfolders/formats" ;
/*libname myfmts “c:\SAS learning\formats”;*/


PROC FORMAT library = myfmts;                            
   VALUE $genderf 	'm' = 'Male'              
                	'f' = 'Female';   
   VALUE asgroup    0-<60 = 'F'
   					60-<70 = 'D'
   					70-<80 = 'C'  
   					80-<90 = 'B'
   					90-High = 'A'
   					Other = 'Missing';
run;

title "Format Definitions in the MYFMTS Library";
proc format library=myfmts fmtlib;
run;
