library(dplyr)
#library(data.table)

#set working directory, get file from url, creat directory, unzip file, and record date
 setwd("C:/Users/anusha/Documents/R")
 fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 activity<-download.file(fileUrl, destfile = "./activityData.zip", mode = 'wb')
 if(!file.exists("./activityData")) {dir.create("./activityData")}
 unzip("activityData.zip")
 downloadDate<-date()

#read files
 setwd("./UCI/UCI HAR Dataset")
 y_test<-read.table("./test/y_test.txt", header=F)
 y_train<-read.table("./train/y_train.txt", header=F)

 x_test<-read.table("./test/X_test.txt", header=F)
 x_train<-read.table("./train/X_train.txt", header=F)
 
 SubTest<-read.table("./test/subject_test.txt", header=F)
 SubTrain<-read.table("./train/subject_train.txt", header=F)

 ActLabels<-read.table("./activity_labels.txt", header=F)
 Variables<-read.table("./features.txt", header=F)
 
#1: Merge data
 x_total<-rbind(x_test, x_train)
 y_total<-rbind(y_test, y_train)
 SubData<-rbind(SubTest,SubTrain)

#2: Extract measurements on mean/s.d. for each measurement - note use of regex
 select_var<-Variables[grep("mean\\(\\)|std\\(\\)",Variables[,2]),]
 x_total2<-x_total[,select_var[,1]]
 
#3: Descriptive names added to activities in the data set
 names(y_total)<- "Act_number"
 names(ActLabels)<-c("Act_number", "Activity")
 activity_labeled<-left_join(y_total, ActLabels, "Act_number")

#1b: Finish data merge begun above to make combined data table with all variables
 DATA<-cbind(SubData, activity_labeled, x_total2)

#4: Appropriately labels data set with descriptive variable names
 names(DATA)[4:69]<-Variables[select_var[,1],2]
 names(DATA)[1]<-"Subject"

#5: Create a 2nd, independent tidy data set with the average of each variable 
#   for each activity and each subject
 DATA %>%
         arrange(Subject, Activity) %>%
         group_by(Subject, Act_number, Activity) %>%
         summarise_all(mean) ->DATA2
 write.table(DATA2, "Data_final.txt", row.name=FALSE)
 

 


# names(data1)[1]<-"country"
# names(data1)[2]<-"GDP.rank"
# data1<-tbl_df(data1)
# data2<-tbl_df(data2)
