/*Compressing Data Files:
By default, a SAS data file is uncompressed. You can compress your data files in order 
to conserve disk space, although some files are not good candidates for compression.
Remember that in order for SAS to read a compressed file, each observation must be 
uncompressed. This requires more CPU resources than reading an uncompressed file. 
However, compression can be beneficial when the data file has one or more of the 
following properties:
It is large.
It contains many long character values.
It contains many values that have repeated characters or binary zeros.
It contains many missing values.
It contains repeated values in variables that are physically stored next to one another. 
*/

/*1.use the COMPRESS= data set option or system option to compress a data file
You use the COMPRESS= system option to compress all data files that you create during 
a SAS session. 
Similarly, you use the COMPRESS= data set option to compress an individual data file.

COMPRESS= system option:
OPTIONS COMPRESS= NO | YES | CHAR | BINARY;
COMPRESS= data set option:
DATA SAS-data-set (COMPRESS= NO | YES | CHAR | BINARY);
Note: The COMPRESS= data set option overrides the COMPRESS= system option.

NO:is the default setting, which does not compress the data set.
The YES or CHAR setting for the COMPRESS= option:
uses the RLE compression algorithm. RLE compresses observations by reducing repeated 
consecutive characters (including blanks) to two-byte or three-byte representations. 
RLE is most often useful for character data with repeated blanks and numeric data 
with most of the values are zero.
The BINARY setting for the COMPRESS= option:
uses RDC, which combines run- length encoding and sliding-window compression. 
This method is highly effective for compressing medium to large blocks of binary 
data. The compressed data with BINARY option takes more CPU time to uncompress.
BINARY is more efficient with observations that are several hundred bytes or more 
in length, as well as with character data that contains patterns rather than simple 
repetitions.
*/

/* data sashelp.bei contains lots of missings */
data  bei_compressd (compress=char);
   set sashelp.bei;
run;
/*NOTE: Compressing data set WORK.BEI_COMPRESSD decreased size by 22.22 percent. 
       Compressed is 56 pages; un-compressed would require 72 pages.*/
data  bei_compressd (compress=binary);
   set sashelp.bei;
run;
/*NOTE: Compressing data set WORK.BEI_COMPRESSD decreased size by 47.22 percent. 
       Compressed is 38 pages; un-compressed would require 72 pages.*/
      
/*2. use the POINTOBS= data set option .
Allowing direct access to observations in a compressed data set increases the CPU 
time that is required for creating or updating the data set. You can set an option 
that does not allow direct access for compressed data sets. If it is not important 
for you to be able to point directly to an observation by number within a compressed 
data set, it is a good idea to disallow direct access in order to improve the 
efficiency of creating and updating the data set.

POINTOBS= data set option: 
DATA SAS-data-set (COMPRESS=YES | CHAR | BINARY POINTOBS= YES | NO);
YES: is the default setting, which allows random access to the data set.
NO: does not allow random access to the data set. */    
data  bei_compressd (compress=binary pointobs=no);
   set sashelp.bei;
run;

/*3.use the REUSE= data set option or system option to specify that SAS should reuse 
space in a compressed file when observations are added or updated.

SAS appends new observations to the end of all data sets by default. If you delete 
an observation within the data set, empty disk space remains in its place. 
However, in compressed data sets only, it is possible to track and reuse free space 
when you add or update observations. By reusing space within a data set, you can 
conserve data storage space.

REUSE= system option: for all compressed data sets that are created in current SAS session
OPTIONS REUSE= NO | YES;
REUSE= data set option: for the compressed data set that is created in that DATA step
DATA SAS-data-set (COMPRESS=YES REUSE=NO | YES);
NO
is the default setting, which specifies that SAS does not track unused space in 
the compressed data set.
YES
specifies that SAS tracks free space and reuses it whenever observations are 
added to an existing compressed data set.
*/
data  bei_compressd (compress=binary reuse = yes);
   set sashelp.bei;
run;