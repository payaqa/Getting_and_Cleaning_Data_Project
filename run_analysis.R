# This program is for the assigment of Getting and Cleaning Data Week 4
# 2016-03-05
#1.	Merges the training and the test sets to create one data set.
#2.	Extracts only the measurements on the mean and standard deviation for each measurement.
#3.	Uses descriptive activity names to name the activities in the data set
#4.	Appropriately labels the data set with descriptive variable names.
#5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



library(reshape2)

#### 1.	Merges the training and the test sets to create one data set.

### load features and activity labels
features <- read.table("./data/UCI HAR Dataset/features.txt")[,2]
activityLabel <- read.table("./data/UCI HAR Dataset/activity_labels.txt")[,2]

### merge training data
trainingX <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainingY <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
trainingSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
names(trainingX) = features
names(trainingSubject) = "SubjectID"
### add the activity labels for the 3rd requirement
trainingY[,2] = activityLabel[trainingY[,1]]
names(trainingY) = c("ActivityID", "ActivityLabel")

trainingData <-cbind(trainingSubject,trainingX,trainingY)

### merge test data
testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
names(testX) = features
names(testSubject) = "SubjectID"
### add the activity labels for the 3rd requirement
testY[,2] = activityLabel[testY[,1]]
names(testY) = c("ActivityID", "ActivityLabel")

testData <-cbind(testSubject,testX,testY)

### merge the training data and the test data to form the final data
finalData <- rbind(trainingData,testData)

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
logicVec <- grepl("Subject|Activity|-mean\\(|-std",names(finalData))   
finalData <- finalData[logicVec == TRUE]

#### 3. Use descriptive activity names to name the activities in the data set
### already done in part 1, e.g. trainingY[,2] = activityLabel[trainingY[,1]]


#### 4.	Appropriately labels the data set with descriptive variable names.
### get the column names first
colNames = colnames(finalData)

## rename
for (i in 1:length(colNames)){
    
    colNames[i] = gsub("^(f)","Frequency",colNames[i]) 
    colNames[i] = gsub("^(t)","Time",colNames[i]) 
    colNames[i] = gsub("BodyAcc"," Body Activity",colNames[i]) 
    colNames[i] = gsub("GravityAcc"," Gravity Activity",colNames[i]) 
    colNames[i] = gsub("BodyGyro"," Body Gyro",colNames[i]) 
    colNames[i] = gsub("Jerk"," Jerk",colNames[i]) 
    colNames[i] = gsub("Mag","  Mag",colNames[i]) 
    colNames[i] = gsub("-mean\\(\\)", " Mean", colNames[i])
    colNames[i] = gsub("-std\\(\\)", " Standard deviation", colNames[i])
}

### reassign the new column names back to the data frame
colnames(finalData) = colNames


#### 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
### use dcast to do the calculation
IDColumns <- c("SubjectID","ActivityID","ActivityLabel")
dataColumns <- setdiff(colnames(finalData),IDColumns)
dataMelt <- melt(finalData,id=IDColumns,meaure.vars=dataColumns)

tidyData <- dcast(dataMelt, SubjectID+ActivityLabel ~ variable,mean)
 
### write out the tidyData to a file
write.table(tidyData, file = "./data/UCI HAR Dataset/TidyData.txt")

