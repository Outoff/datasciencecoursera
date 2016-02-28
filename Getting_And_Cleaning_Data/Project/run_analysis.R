#################################################################################################
#
# Getting and Cleaning Data Course Project
#  - Part of the Data Science Specialization at Coursera.org
#
# R Script name: run_analysis.R
# Author: Morten Badensoe 
# Purpose: This script goes through the 5 steps below using the following dataset:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average 
#     of each variable for each activity and each subject.
#
################################################################################################
#
## Step 1: Merge the training and test sets to create one data set
#         All datasets are contained within the ZIP-file mentioned above,
#         and this script excepts the ZIP-file to be unpacked.

# Set the Working Directory
setwd('/Users/Morten/Programming/Coursera/Data Science Specialization/Getting_And_Cleaning_Data');

# Import all datasets used in this script

# Feature and Activity_Labels (Mapping tabels) data sets - Import
features        = read.table('/data/UCI HAR Dataset/features.txt',header=FALSE)
activity_labels = read.table('./data/UCI HAR Dataset/activity_labels.txt',header=FALSE)
# Add Column Names 
colnames(activity_labels) = c("activity_Id","activity_Type")

# Train data sets - Import
x_train       = read.table('./data/UCI HAR Dataset/train/x_train.txt',header=FALSE)
y_train       = read.table('./data/UCI HAR Dataset/train/y_train.txt',header=FALSE)
subject_train   = read.table('./data/UCI HAR Dataset/train/subject_train.txt',header=FALSE)
# Train data sets - Add Column names
colnames(subject_train)  = "subject_Id"
colnames(y_train)        = "activity_Id"
colnames(x_train)        = features[,2] # Use the features mapping table to map V1,V2,..., to e.g. tBodyAcc-mean()-X,Y,Z
# Train data sets - Merge
Training_Data = cbind(y_train,subject_train,x_train);

# Test data sets - Import
x_test       = read.table('./data/UCI HAR Dataset/test/x_test.txt',header=FALSE)
y_test       = read.table('./data/UCI HAR Dataset/test/y_test.txt',header=FALSE)
subject_test = read.table('./data/UCI HAR Dataset/test/subject_test.txt',header=FALSE)
# Test data sets - Add Column names (same as for the Train data sets)
colnames(subject_test) = "subject_Id";
colnames(y_test)       = "activity_Id";
colnames(x_test)       = features[,2]; 
# Test data sets - Merge
Test_Data = cbind(y_test,subject_test,x_test);

# Test and Train data - Merge
TestTrain_data = rbind(Training_Data,Test_Data)

## Step 2 Extracts only the measurements on the mean and standard deviation for each measurement.
# Get a list of all column names from TestTrain_Data
Column_Names <- colnames(TestTrain_data)
# Create a vector (logical) with TRUE for all columns/variables with mean() and std() (standard deviation)
# and TRUE for ID variables (activity_id and subject_id). All other columns are set to FALSE.
Col_Mean_Std = (grepl("activity..",Column_Names) # First possible Condition for TRUE match (Activity_Id)
                | grepl("subject..",Column_Names) # Second possible Condition for TRUE match (Subject_Id)
                | grepl("mean\\(\\)", Column_Names) # Third possible Condition for TRUE match (mean())
                | grepl("std\\(\\)", Column_Names)) # Fourth possible Condition for TRUE match (mean())

# Keep the columns with Activity_Id, Subject_Id, mean() and std(), i.e. the columns with 
#   TRUE in the above logical vector
TestTrain_data_C = TestTrain_data[Col_Mean_Std==TRUE]

## Step 3: Uses descriptive activity names to name the activities in the data set
# Use the activity_labels mapping table to add descriptive activity names to the
#  activities in the TestTrain_data_C data set. 
# Merge the two tables by the common variable, activity_id, to include the Activity_type
TestTrain_data_C = merge(TestTrain_data_C,activity_labels,by='activity_Id',all.x=TRUE)

## Step 4: Appropriately labels the data set with descriptive variable names.
# Extract the column names from the TestTrain_data_C and change these to become more readable
# Column names:
Column_Names = colnames(TestTrain_data_C)
# Loop through the Column_Names vector, and perform various string replacements.
for(i in 1:length(Column_Names)){
  Column_Names[i] = gsub("\\(\\)","",Column_Names[i]) # Remove "()"
  Column_Names[i] = gsub("-mean","Mean",Column_Names[i]) # Initial capital letter in Mean
  Column_Names[i] = gsub("-std","STD",Column_Names[i]) # All large letters in STD
  Column_Names[i] = gsub("^(t)","Time",Column_Names[i]) # Replace starting t with Time
  Column_Names[i] = gsub("^(f)","Freq",Column_Names[i]) # Replace starting f with Freq
  Column_Names[i] = gsub("Mag","Magnitude",Column_Names[i]) # Write out magnitude
 #print(Column_Names[i])
}
# Add the new column names to the data set, TestTrain_data_C
colnames(TestTrain_data_C) = Column_Names

# Step 5: From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.

# Calculate MEAN across each activity for each subject
tidy_Data    = aggregate(TestTrain_data_C[,names(TestTrain_data_C) != c('activity_Id','subject_Id','activity_Type')],
                        by=list(subject_Id = TestTrain_data_C$subject_Id,activity_Id=TestTrain_data_C$activity_Id,activity_Type = TestTrain_data_C$activity_Type),
                        mean)
# Sort dataset after Subject, Activity (to get all the measurements of each subject grouped)
tidy_Data_Sorted <- tidy_Data[order(tidy_Data$subject_Id, tidy_Data$activity_Id),]
# Write sorted Tidy Data to wd (Working Directory), without row numbers and with comma seperator
write.table(tidy_Data_Sorted, './tidyData.txt',row.names=FALSE,sep=',')




