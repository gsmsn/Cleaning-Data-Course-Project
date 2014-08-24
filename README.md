#README.md for Data Cleaning Course Project
The README.md file, the run_analysis.R script, the CodeBook.md file and the tidyData.txt file (all contained in this repo) were created to satisfy the requirements of the Course Project for the ‘Getting and Cleaning Data’ Course offered by Coursera / Johns Hopkins University.  

The main content of this README.md file is as follows: 

1. Course Project Summary
2. Tidy Data File Description
3. CodeBook.md Overview
4. Script Operation and Overview

##Course Project Summary
The purpose of the Course Project was to demonstrate my ability to collect, work with, and clean a data set.  The goal was to create a tidy data set that can be used for later analysis. 
The input data set contains a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded accelerometers and gyroscopes.  A copy of the input data set can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Since my repo is ‘published’ to a public Github location, the license for the input data set requires a reference to the following publication:

* _Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012_

For anyone that is not taking the Data Cleaning course, additional information about the original source data set and its associated project can be found at:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
It is a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The Data Cleaning Course Project has five tasks: 

1. Merge the training and test sets, from the input data set, into a single data set.
2. Extract the mean and standard deviation measurements. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

##Tidy Data File Description
Use the following R command to read the tidyData.txt information into a data frame:   
testTidy <- read.table("./tidyData.txt", header=TRUE) 
Note that the tidyData.txt file is ‘space’ delimited. 

The tidyData.txt data table is ‘tidy’ because it adheres to the tidy principles outlined in the week 3 course video about ‘Reshaping Data’:

1. Each variable forms a column.  
2. Each observation forms a row.  
3. Each table stores data about one kind of observation (in this case the table stores information about the ‘motion’ of human subjects as measured by accelerometers in a cell phone strapped to their waist)

The tidyData.txt data table also factors in the ‘tidy’ principles discussed in the ‘Long Data, Wide Data, and Tidy Data for the Assignment’ discussion thread in the Course Discussion area.  https://class.coursera.org/getdata-006/forum/thread?thread_id=236 

Further, the variables were given descriptive names.  It was decided to reuse the names in the ‘features.txt’ data table because they were descriptive and reuse would provide continuity for anyone familiar with the original project.  

Each observation is clearly distinguished by the combination of Subject and Activity.  For example, there is a single observation in the data table for Subject ‘5’ with Activity ‘Walking’.

There were 30 human ‘Subjects’ who each performed 6 different ‘Activities’ multiple times.  The Script created for this project finds the mean of the Activities grouped by Subject and Activity, which results in a total of 180 ‘Observations’ in the tidyData.txt data table (30 Subject times 6 Activity ‘means’).  


##CodeBook.md Overview
The code book describes the variables, the data, and any transformations or work performed to clean up the data.


##Script Operation and Overview
A single R script named run_analysis.R was created.
run_analysis.R assumes that the Samsung cell phone data is in the working directory
run_analysis.R requires ‘plyr’ package installed and ‘plyr’ library loaded.

Load run_analysis.R into R, 
then execute the function accel(), 
which will create a file named tidyData.txt and write that file to the working directory. 

run_analysis.R does the following: 

1. Merges the training and test sets, from the input data set, into a single data set.
2. Extracts the mean and standard deviation measurements. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Here is a brief description of how the five Course Project tasks are accomplished by the run_analysis.R script:
* The input files are read into R. 
* The generic column names in the training and test ‘measurement’ data tables are replaced with the Feature variable ‘Name’ from the features.txt data table. 
* Feature variables are identified that are either a ‘mean’ or ‘standard deviation’ measurement and then this information is used to produce a data table with only those variables.
* The corresponding Subject and Activity information is added to the training and test ‘measurement’ data tables.
* The 7,352 training observations are merged with the 2,947 test observations to produce a single data table containing 10,299 observations. 
* The ‘aggregate’ function is used to create a second, independent tidy data set with the average of each variable for each activity and each subject
* Further ‘tidy’ up the data table by moving the ‘Subject’ variable to the first column location. This increases readability. 
* Finally, write.table is used to place a copy of the 2nd tidy data table in the working directory.

