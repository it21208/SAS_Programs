/*Combining Data Vertically using FILENAME statement:
Combining data vertically refers to the process of concatenating or 
interleaving data. In this lecture we will learn how to create a SAS data set by 
concatenating multiple raw data files using the FILENAME and INFILE statements.

The FILENAME statement associates a SAS fileref (a file reference name) with an
external file's complete name (directory plus file name). 
The fileref is then used as a shorthand reference to the file in the SAS programming 
statements that access external files.
you can use a FILENAME statement to associate a fileref with a single raw data file. 
You can also use a FILENAME statement to concatenate raw data files 
by assigning a single fileref to the raw data files that you want to combine.

General form, FILENAME statement:
FILENAME fileref ('external-filel' 'external-file2' …'external-filen')\
Here is an explanation of the syntax:
fileref:
   is any SAS name that is eight characters or fewer.
external-file:
   is the physical name of an external file. 
   The physical name is the name that is recognized by
   the operating environment.

All of the file specifications must be enclosed in one set of parentheses.
When the fileref is specified in an INFILE statement, each raw data file 
that has been referenced can be sequentially read into a data set 
using an INPUT statement.*/

/*In the following program, we want to read 3 raw data files 
with same structure:
the FILENAME statement creates the fileref Score, 
which references the raw data files score_month1.txt, score_month2.txt, 
and score_month3.txt
The data files are stored in the "/folders/myfolders" directory 
in SAS studio environment. 
In the DATA step, the INFILE statement identifies the fileref, 
and the INPUT statement describes the raw data.
*/

filename score ("/folders/myfolders/score_month1.txt"
               "/folders/myfolders/score_month2.txt"
               "/folders/myfolders/score_month3.txt");
data score123;
   infile score;
   input name $ score month $;
run;
/*The SAS log indicates that the raw data files referenced by Score are 
sequentially read into the data set score123*/