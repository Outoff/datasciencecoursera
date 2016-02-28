## Codebook for Course Project (Getting and Cleaning Data, Coursera)

Author: Morten Badensø

Date: February 28th 2016

Codebook for the Course Project for the course Getting and Cleaning Data on Coursera.

### Source Data: Human Activity Recognition Using Smartphones Data Set 
The source data used in this project is "Human Activity Recognition Using Smartphones Data Set", and a full description can be
located at the UCI Machine Learning Repository:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

And the dataset ZIP-package can be found at 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip (Online: February 28th 2016)

### Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Walkthrough of the run_analysis.R script steps

#### Step 1: Import and merge the training and the test sets to create one data set.
The following datasets are being used in the script:
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt
- features.txt
- activity_labels.txt

The test and train sets are treated before being merged together to form a single data set. The features.txt and activity_labels.txt are used as mapping tables to add additional columns about activity type (WALKING, LAYING etc.) and to change column names for measurement types (Body Acceleration in X,Y and Z, etc.).

#### Step 2: Extract only the measurements on the mean and standard deviation for each measurement.
In this step, only the ID variables/columns and the columns containing mean and standard deviation measurements are kept. A logical vector is created, that contains TRUE for the following conditions:
- Activity_id
- Subject_id
- Columns containing "mean()"
- Columns containing "std()"

And FALSE for every other column. The logical vector is then used to shrink the dataset.

#### Step 3: Uses descriptive activity names to name the activities in the data set
Using the mapping table, activity_labels, the column activity_type(WALKING, LAYING etc.)is added to the data set by the by-variable activity_id(1,2, etc).

#### Step 4: Appropriately label the data set with descriptive variable names.
The column names in the features table is a bit 'dirty', and needs to be cleaned up. This is done using string replacement and regular expressions (gsub). The following clean up has been done:
- "()" has been replaced with "" (nothing)
- "mean" has been given a large initial letter: "Mean"
- "std" has been given all large letters: "STD"
- Leading "t" has been replaced with "Time" 
- Leading "f" has been replaced with "Freq" (for Frequency)
- "Mag" has been replaced with "Magnitude"

#### Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The last step of the run_analysis.R script created a tidy data set, where the data has been averaged for each variable for each activity and each subject. Thus, 
for every subject the mean value for the different features (e.g. Body Acceleration) has been calculated for each activity. The tidy data set is written to the chosen working directory.
