repos
=====

R assignment

run_analysis R script
========================================================

The R script 'run_analysis.R' was created with the help of RStudio Version 0.98.501 and R version 3.0.3.
in a Windows 8.1 machine.

To execute correctly the R script 'run_analysis.R', the respective file must lie 
in the same directory where data collected from the accelerometers from 
the ***Samsung Galaxy S*** smartphone reside. In particular, the R file must reside in the same directory
as this unzipped from the provided link
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
(e.g. UCI HAR Dataset).
If any of the requested files is not located, an error is dropped.

The script takes no input and returns/stores in the global R environment two independent tidy data sets:

1.The first one results from questions 1-4 of the assignment and is stored in variable **'tidyData'** 

2.The second comes from question 5 of the assignement and is stored in variable **'IndependentTidyData'**.



