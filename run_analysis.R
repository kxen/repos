#ytest corresponds to the activities performed (walking, sitting, ….)
#subject corresponds to the number of the volunteer performing the experiment
#feature contains the names of the variables measurements

# check for the existence of the required files
featureFile<-c("./features.txt")
testFiles<-c("./test/X_test.txt","./test/subject_test.txt","./test/y_test.txt")
trainFiles<-c("./train/X_train.txt","./train/subject_train.txt","./train/y_train.txt")

if (any(!file.exists(featureFile))){
  stop("Feature file does not exist")
}
if (any(!file.exists(testFiles))){
  stop("One or more of the test files could not be found")
}
if (any(!file.exists(trainFiles))){
  stop("One or more of the train files could not be found")
}
rm(featureFile,testFiles,trainFiles)


#1. Merge the training and the test sets to create one data set.
#read the names of 561 features
features<-read.table("./features.txt",sep="")

#read the data from the test set
xtest<-read.table("./test/X_test.txt",sep="")

#read the subject from the test data
subjectTest<-read.table("./test/subject_test.txt",sep="")

#read the ytest (activities) from the test data
ytest<-read.table("./test/y_test.txt",sep="")

# create a new data frame for xtest by adding column-variables 
#subjectTest and ytest in the first positions of data frame xtest
newXtest<-cbind(c(subjectTest,ytest),xtest)

#perform the same procedure for the training set
#read the data from the train set
xtrain<-read.table("./train/X_train.txt",sep="")
#read the subject from the train data
subjectTrain<-read.table("./train/subject_train.txt",sep="")
#read the ytest (activities) from the train data
ytrain<-read.table("./train/y_train.txt",sep="")


# create a new data frame for xtrain by adding column-variables 
#subjectTest and ytrain in the first positions of data frame xtrain
newXtrain<-cbind(c(subjectTrain,ytrain),xtrain)

# merge is not necessary (rbind is enough) since the subject of Train and Test data sets are different
mergedData<-rbind(newXtest,newXtrain)

# 2.Extract only the measurements on the mean and standard deviation for each measurement. 

# from the second column of data frame features we extract the names of all variables that
# contain patterns of the form “-mean()” and “-std()”
meanVar<-grep("*-mean\\(\\)",features[,2])
stdVar<-grep("*-std\\(\\)",features[,2])
# merge the vectors that contain the positions of the requested variables
# we add 2 to the positions since we have added two columns in "mergedData"
posit<-c(meanVar,stdVar)+2

subData<-mergedData[,c(1,2,posit)]

# 3. Use descriptive activity names to name the activities in the data set

# create a vector with the names of possible activities
actNames<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

subData[,2]<-actNames[subData[,2]]
# 4. Appropriately label the data set with descriptive activity names. 

# create a vector with the names from "features" data frame that match the positions
# located by vectors "meanVar" and "stdVar"
feats<-as.vector(features[c(meanVar,stdVar),2])
# we remove '-,(,)' from the names of the variables 
feats<-gsub("[()-]","",feats)
names(subData)<-c("Subject","Activity",feats)

# we sort the subData data frame in ascending order according to the variable "Subject"
tidyData<-subData[order(subData$Subject),]
row.names(tidyData) <- NULL 
# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

#load package "plyr"
library(plyr)

# define a function that evaluates the mean value of every "feature" variable 
# for every possible combination of "Subject" and "Activity"
myfunction<-function(dataframe){
  feats<-as.vector(names(dataframe))[3:68]
  vc<-sapply(dataframe[,feats],mean)
  return(vc)}
# create the required independent tidy data set
IndependentTidyData<-ddply(tidyData,.(Subject,Activity),myfunction)
#remove all variables that are not related to the tidy data sets
rm(xtest,ytest,xtrain,ytrain,newXtest,newXtrain)
rm(subjectTest,subjectTrain,subData,mergedData)
rm(features,feats,actNames,meanVar,stdVar,posit)
rm(myfunction)
