/*Creating Custom Formats Using the PICTURE Statement:
You have learned that the VALUE statement can associate a text label 
with a discrete numeric or character value. 
Suppose you want to insert text characters into a numeric value. 
You can use the PICTURE statement to create a template for printing numbers.

General form, PROC FORMAT with the PICTURE statement:

PROC FORMAT;
  PICTURE format-name
              value-or-range='picture';
RUN;
Here is an explanation of the syntax:
format-name:
is the name of the format that you are creating.
value-or-range:
is the individual value or range of values that you want to label.
picture
specifies a template for formatting values of numeric variables. 
The template is a sequence of characters enclosed in quotation marks. 
The maximum length for a picture is 40 characters.

Ways to Specify Pictures
Pictures are specified with three types of characters:

digit selectors: are numerals (0 through 9) that define positions for numbers. 
If you use nonzero digit selectors, zeros are added to the formatted value as needed. 
If you use zeros as digit selectors, no zeros are added to the formatted value.

message characters: are nonnumeric characters that are printed as specified in 
the picture. They are inserted into the picture after the numeric digits are formatted.
Digit selectors must come before message characters in the picture definition. 
The prefix option can be used to append text in front of any digits.

directives: Directives are special characters that you can use in the picture to 
format date, time, or datetime values. If you use a directive, you must specify 
the DATATYPE= option in the PICTURE statement. This option specifies that 
the picture applies to a SAS date, SAS time, or SAS datetime value.

General form, PICTURE statement with the DATATYPE= option:
PICTURE format-name
     value-or-range = 'picture' (DATATYPE=SAS-date-value-type); 
picture:
specifies a template with directives for formatting numeric values.
SAS-date-value-type:
is either DATE, TIME, or DATETIME.

This table shows some of the directives you can use in a Picture Format to customize 
the display of values of your date, time or datetime variables. 
Please consult the PROC FORMAT in SAS documentation for a complete list. 

%a: abbreviated weekday name, for example, Wed.
%A: full weekday name, for example, Wednesday.
%b: abbreviated month name, for example, Jan.
%B: full month name, for example, January.
%d: day of the month as a two-digit decimal number (01-31), for example, 02.
%e: day of the month as a two-character decimal number with leading spaces (" 1"- "31"), 
for example, " 2".
%y: year without century as a two-digit decimal number (00-99), for example, 93.
%Y: year with century as a four-digit decimal number (1970-2069), for example, 1994.
*/

data phone;
input phone_number;
datalines; 
4089813212
3427893456
7896542231
4123467863
6457845632
;
run;

/* we want the phone numbers in this format: e.g. (408)981-3212 Cell
1. use both digit selectors and message characters to define positions for numbers
as well as insert the nonnumeric characters into the picture: 999) 999-9999 Cell  
2. Since Digit selectors must come before message characters in the picture 
definition. The prefix option is used to append text to finish the picture 
in this case '(' before the first digit 9, in front of any digits.*/ 
proc format ;
picture phone_f (default = 20) /*make the default length of the Picture Format 20 characters*/
	low - high = '999) 999-9999 Cell' /* low- hign: format apply to all non-missing values*/
	(prefix = '(' );
run;

proc print data = phone;
format phone_number phone_f.;
run;

/*Use directives to give birthday a new format: e.g. Mar 12, 1999*/
proc import datafile = "/folders/myfolders/score_data_miss_birthdate" 
DBMS = xlsx out = bd (keep = name birthdate) replace ;
run;

proc format;
   picture bd_f (default = 20 )
           low-high='%b %d, %Y' (datatype=date);
run;
proc print data = bd;
format birthdate bd_f.;
run;











