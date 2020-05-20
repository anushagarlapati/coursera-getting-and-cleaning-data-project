The run_analysis.R script performs the data preparation necessary to meet the criteria
outlined in the Readme.txt file.

The data analyzed was collected from the accelerometers from the Samsung Galaxy S smartphone. 
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2fprojectfiles%2fuci%20har%20dataset.zip

Steps taken in organizing data:
1. Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

2. Read data files with read.table, then assign variable names to data
  Variables represent the various forms of data collected via the Samsung phone:
Variables <- features.txt
  ActLabels are the activities performed while data was collected:
ActLabels <- activity_labels.txt

SubTest <- test/subject_test.txt 
SubTrain <- test/subject_train.txt
   Contains the test and train data of subjects observed
x_test <- test/X_test.txt 
x_train <- test/X_train.txt 
   Contain the recorded test and train data
y_test <- test/y_test.txt 
y_train <- test/y_train.txt 
   Contain the recorded activities at the time test and train data was collected

3. Merge the training and the test sets to create one data set
x_total is combined test and train data
y_total is combined test and train recorded activities
SubData is combined data of subjects observed

4. Extract measurements on mean/s.d. for each measurement
select_var represents the columns of variables of interest
x_total is the vector containing data of interest

5. Uses descriptive activity names to name the activities in the data set
column names adjusted, variable activity_labeled created to label numeric recorded activity with its name

6. Data merge finished with all variables of interest - variable DATA

7. Appropriately labels the data set with descriptive variable names

8. DATA2 created representing tidy data set with mean of each variable for each activity and each subject
