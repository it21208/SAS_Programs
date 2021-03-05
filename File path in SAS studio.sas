/* 
Read original data seperated by blanks into SAS

the original data are below:

Tim M 50 145
Sara . 23 130 
Mike M 65 180
Laura F . 130
Sean M 15 167
*/


data sdata_blanks;
	infile "/folders/myfolders/DATA_blanks.txt"; /* Specifies an external to read with an INPUT statement */
	input name $ Gender $ Age Weight;
	/* 'C:\SASUniversityEdition\DATA_blanks.txt' */
run;

proc print data=sdata_blanks;
run;