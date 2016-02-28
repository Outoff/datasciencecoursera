## README for Course Project (Getting and Cleaning Data, Coursera)

Author: Morten Badensø

Date: February 28th 2016

README file for the Course Project for the course Getting and Cleaning Data on Coursera.

### Overview
In this project it is demonstrated how to collect and clean data using the R language. The goal
is to create a data set that is tidy, and easy to use in subsequent analysis. 

The data used in this project is accelerometer data from a Samsung Galaxy S smartphone. For further information see:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

And the source data used in this project can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Using the R script associated with this project, run_analysis.R
Write your working directory in the run_analysis.R script, and place the unpacked data from the above ZIPfile in a folder called 'data' in your working directory. A tidy, analysis-ready, dataset is created in your chosen working directory after execution of the script - this data set is called "tidyData.txt".

### Summary for the Course Project
The summary for the project as given by Coursera Instructions page.

You should create one R script called run_analysis.R that does the following.

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The steps 1-5 are also reflected in the run_analysis.R script.

### Further information
For further information regarding the data and transformations, please see Codebook.md