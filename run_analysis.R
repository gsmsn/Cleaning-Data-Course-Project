accel <- function() {

  ## setwd("./UCI HAR Dataset")  ## assume the Samsung data is in working directory
  
    ## read the Subject IDs, Activity IDs and the measurement data from 'training' data set
  trainingSubjects <- read.table("./train/subject_train.txt", col.names=c("Subject"))  ## Subject ID 
  trainingActivities <- read.table("./train/y_train.txt") ## Activity ID
  trainingData <- read.table("./train/X_train.txt")  ## measurement data 

    ## read the Subject IDs, Activity IDs and the measurement data from 'test' data set
  testSubjects <- read.table("./test/subject_test.txt", col.names=c("Subject"))
  testActivities <- read.table("./test/y_test.txt") 
  testData <- read.table("./test/X_test.txt")

    ## read the table info that maps Activity 'ID' to Activity 'Name'
  activityLabels <- read.table("./activity_labels.txt", colClasses=c("integer","character"))

    ## replace Activity 'ID' with corresponding Activity 'Name' in Training set
  labelTrainingVector <- NULL
  for(i in 1:nrow(trainingActivities)){
    labelTrainingVector[i] <- activityLabels$V2[trainingActivities$V1[i]]
  }
  labelTrainingActivities <- data.frame(Activity=labelTrainingVector)

    ## replace the Activity 'ID' with corresponding Activity 'Name' in Test set
  labelTestVector <- NULL
  for(i in 1:nrow(testActivities)){
    labelTestVector[i] <- activityLabels$V2[testActivities$V1[i]]
  }
  labelTestActivities <- data.frame(Activity=labelTestVector)

    ## get the names/labels for the 561 columns of data set 'Feature' variables
  features <- read.table("./features.txt")

    ## identify only the variables of interest --- mean() and std();  mean & standard deviation
  result <- features[ grep("mean", features$V2), ]
  result2 <- features[ grep("std", features$V2), ]
  combineResult <- rbind(result, result2)
  featuresMeanStd <- arrange(combineResult,(combineResult$V1))  ## sort in ascending order

    ## use vector of col numbers to extract only mean() and std() features (variable columns) 
  trainingDataMeanStd <- trainingData[,featuresMeanStd[,1]] 
  testDataMeanStd <- testData[,featuresMeanStd[,1]]

    ## replace Feature 'ID' with the corresponsing Feature 'Name'
  colNameFeaturesMeanStd <- featuresMeanStd[,2]  ## vector of character names for features
  names(trainingDataMeanStd) <- colNameFeaturesMeanStd
  names(testDataMeanStd) <- colNameFeaturesMeanStd

  ## add columns of Subjects and Activities to the Training and Test Data sets
  ActTrainingDataMeanStd <- cbind(labelTrainingActivities , trainingDataMeanStd)
  SubActTrainingDataMeanStd <- cbind(trainingSubjects , ActTrainingDataMeanStd)
  ActTestDataMeanStd <- cbind(labelTestActivities , testDataMeanStd)
  SubActTestDataMeanStd <- cbind(testSubjects , ActTestDataMeanStd)

    ## now recombine into a single data set by appending the 
    ## rows of testDataMeanStd to the end of trainingDataMeanStd 
  allDataMeanStd <- rbind(SubActTrainingDataMeanStd, SubActTestDataMeanStd)

    ## Create a second, independent tidy data set with the average of each variable for 
    ## each activity and each subject
  justDataMeanStd <- allDataMeanStd[,-1:-2]  ## remove Activity and Subject columns for aggregate funtion
  attach(allDataMeanStd)
    meanOfMeanStd <-aggregate(justDataMeanStd, by=list("Activity"=Activity,"Subject"=Subject), 
                    FUN=mean, na.rm=TRUE)
  detach(allDataMeanStd)

  ## now move the column for variable "Subject" so it before "Activity" instead of after
  tidy<- cbind("Subject"=meanOfMeanStd$Subject, meanOfMeanStd)
  tidy[,3] <- NULL  ## delete the old "Subject" column

    ## Done!  write the tidy data table out to the working directory with name: tidyData.txt
  write.table(tidy,"./tidyData.txt", row.names=FALSE)

  testTidy <- read.table("./tidyData.txt", header=TRUE); head(testTidy[1:4], 10)
}