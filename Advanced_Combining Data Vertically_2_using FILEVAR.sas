/*Combining Data Vertically using FILEVAR = option
You can make the process of concatenating raw data files more flexible 
by using an INFILE statement with the FILEVAR= option. 

General form, INFILE statement with the FILEVAR= option:
INFILE file-specification FILEVAR= variable;
Here is an explanation of the syntax:
FILEVAR= variable:
   names a variable whose change in value causes the INFILE statement 
   to close the current input file and open a new input file.
variable:
contains a character string that is a physical filename.

When you use an INFILE statement with the FILEVAR= option, 
the file specification is a placeholder, not an actual filename or fileref 
that had been assigned previously to a file. 
SAS uses this placeholder for reporting processing information to the SAS log. 
The file specification must conform to the same rules as a fileref.

When the INFILE statement executes, it reads from the file that 
the FILEVAR= variable specifies. Like automatic variables, this variable is 
not written to the data set.
*/

/*we want to concatenate 3 raw data files 
with same structure:*/
data score123_;
/*the external data files are read from the DATALINES on the first 
infile statement, and using INPUT statement to store the external raw data files
infomation in the variable Rfile for later use.
On each iteration of the DATA Step, a new value of Rfile is read 
from the DATALINES.*/
infile datalines;
length rfile $60;
input rfile $;
/* The second INFILE statement opens the raw data file whose name is retrieved 
from the DATALINES. PH is the place holder, The FILEVAR= variable Rfile contains 
the extrenal data file info. to be read */
infile PH filevar=rfile end=lastobs;
/*use the END= option with the INFILE statement 
to determine the last record to prevent reading beyond the end of the file,
The END= variable Lastobs is created in the INFILE statement. When the current 
input record is the last record in the input file, the END= variable to 1.

The DO UNTIL reads the raw data and writes it to the ouput SAS Data Set Score123_.
The DO UNTIL statement conditionally executes until the value of Lastobs equals 1 
(true). */
do until (lastobs);
 input name $ score month $;
 output; /*An OUTPUT statement within the DO loop outputs each observation to 
the data set score123_.*/
end;
datalines;
/folders/myfolders/score_month1.txt
/folders/myfolders/score_month2.txt
/folders/myfolders/score_month3.txt
;
run;

