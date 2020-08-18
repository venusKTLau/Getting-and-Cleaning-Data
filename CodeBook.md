The run_analysis.R aimed to finish all 5 required tasks by the following instructions.

# Preparation
Download the raw dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and unzip it, place it in the working directory,

# Create variables for the data (rows x columns)
1. activities from activity_labels.txt  (6 x 2)
    The 6 activities performed by 30 volunteers and measurements were taken         while they were performing.

2. features from features.txt  (561 x 2)
    List of features that were selected for this database come from the             accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. .

3. subject_test from test/subject_test.txt  (2947 x 1)
    The test data of 9 volunteers subjects (30 percent of total)

4. x_test from test/X_test.txt  (2947 x 561)
    The features of test data

5. y_test from test/y_test.txt  (2947 x 1)
    The activities' labels of test data

6. subject_train from test/subject_train.txt (7352 x 1) 
    The train data of 21 volunteers subjects (70 percent of total)

7. x_train from test/X_train.txt  (7352 x 561)
    The features of train data

8. y_train from test/y_train.txt  (7352 x 1)
    The activities' labels of train data
    
# Merges the training and the test sets to create one data set.(rows x columns)
1. new subject_test(2947 x 563) is created by merging original subject_test,    y_test and x_test(cbind() function)

2. new subject_train(7352 x 563) is created by merging original subject_train,  y_train and x_train(cbind() function)

3. mergedData(10299 x 563) is created by merging subject_train and subject_test (rbind() function)

# Extracts only the measurements on the mean and standard deviation for each measurement. (rows x columns)
4. By subsetting mergedData, selecting subject, code, and measurements(features) which contains mean or std, targetData(10299 x 88) can be obtained

# Uses descriptive activity names to name the activities in the data set
5. labels column in targetData will be replaced by the corresponding labels in the second column of activities 

# Appropriately labels the data set with descriptive variable names.
 - second column of targetData is named as "activities"
 - tBody -> TimeBody
 - Acc -> Accelerometer
 - mean -> Mean
 - All start with "t" -> Time
 - Gyro -> Gyroscope
 - Mag -> Magnitude
 - All start with "f" -> Frequency
 - freq -> Frequency
 - std -> STD
 - angle -> Angle
 - gravity -> Gravitiy
 - BodyBody -> Body
 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. (rows x columns)

Average each variable for each activity and each subject in the targetData and group by subject, followed by activities. Assign the value to a new variable called final (180 x 88)

data in final is written to a new file "FinalTable.txt"

