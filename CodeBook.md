CodeBook
========================================================

The data necessary for the assignment were downloaded from the UCI machine learning repository

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

in 17/04/2014. The initial data sets are separated between the data set (7352 measurements) and the training set (2947 measurements). Each measurement consists of a 561-feature vector with time and frequency domain variables. Furthermore, each measurement is related with a subject (identifier of the volunteer executing the experiment) and an activity the volunteer is performing. In total there exist 30 volunteers,distributed between the test and training data sets. 
The possible values of activities are: 

Laying, Sitting, Standing, Walking, Walking_downstairs, Walking_upstairs.

To create the first tidy data set we follow the instructions 1-4 of the assignment. Specifically, 

1. we read the training and the test sets located in files `./test/X_test.txt` and `./train/X_train.txt` respectively. To each created data frame, we assign in the beginning two columns with the data from the sets `./test/subject_test.txt` and `./test/y_test.txt` (`./train/subject_train.txt` and `./train/y_train.txt` respectively for the training data frame). We next merge the two data frames by simply binding the rows of the sets, since the `Subject` variable fully separates them. We pass on the data set to the 2nd stage.
2. From the previous data frame we next extract only the measurements on the mean and standard deviation from the 561-feature vector with time and frequency domain variables. The names are located in `./features.txt` file. Specifically, we keep only these variables whose name is of the form `-mean()` or `-std()`.
3. According to file `activity_labels.txt`, the activity numbers and labels are related as
`1->WALKING,2->WALKING_UPSTAIRS,3->WALKING_DOWNSTAIRS,4->SITTING,5->STANDING,6->LAYING`. We perform the respective assignment to the second column of the data frame of the 2nd step.
4. On the data frame of step 3, we name its columns according to the variable names extracted in step 2. To be able to access the variable names of the data frame, we remove from them the special characters `(,),-`.

The data frame constructed according to the previous steps is assigned to variable `tidyData`.

We next use the data frame `tidyData` to construct an independent data set with the average of each variable for each activity and each subject. The R package `plyr` is utilized for this purpose.
The new tidy data set is assigned to variable `IndependentTidyData`. 

--------------------------
The tidy data sets were created with the help of RStudio Version 0.98.501 and R version 3.0.3.
in a Windows 8.1 machine.
