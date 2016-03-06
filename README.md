<b><font color="2">Getting and Cleaning Date Project</font></b>

**Introduction:**

The R script run_analysis.R does the following.

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names.
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

**Repro Step:**

1. download the data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. extract the data to your [current work directory]/data, so the 'readme.txt' is under "[current work directory]/data/UCI HAR Dataset" folder
3. run the script of 'run_analysis.R'
4. the clean data would be generated at  "[current work directory]/data/UCI HAR Dataset" called TidyData.txt
