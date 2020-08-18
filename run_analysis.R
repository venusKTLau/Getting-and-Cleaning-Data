library(dplyr)

path <-getwd()
filename<- "GettingAndCleaningData.zip"

if(!file.exists(filename)){
    fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL,file.path(path, filename),method = "curl")
    unzip(filename)
}

activities <- read.table(file.path(path,"UCI HAR Dataset/activity_labels.txt"), col.names = c("labels","activities"))
features <- read.table(file.path(path,"UCI HAR Dataset/features.txt"), col.names = c("number", "features"))
subject_test <- read.table(file.path(path, "UCI HAR Dataset/test/subject_test.txt"), col.names = "subject")
x_test <- read.table(file.path(path, "UCI HAR Dataset/test/X_test.txt"), col.names = features$features)
y_test <- read.table(file.path(path, "UCI HAR Dataset/test/y_test.txt"), col.names = "labels")
subject_train <- read.table(file.path(path, "UCI HAR Dataset/train/subject_train.txt"), col.names = "subject")
x_train <- read.table(file.path(path, "UCI HAR Dataset/train/X_train.txt"), col.names = features$features)
y_train <- read.table(file.path(path, "UCI HAR Dataset/train/y_train.txt"), col.names = "labels")

## 1. Merges the training and the test sets to create one data set.
subject_test <- cbind(subject_test, y_test, x_test)
subject_train <- cbind(subject_train, y_train, x_train)
mergedData <- rbind(subject_train, subject_test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
targetData <- mergedData %>% select(subject, labels, contains("mean"), contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set
targetData$labels <- activities[targetData$labels, 2]

## 4. Appropriately labels the data set with descriptive variable names.
names(targetData)[2] = "activities" ##labels -> activities
names(targetData)<- gsub("tBody", "TimeBody", names(targetData))
names(targetData)<- gsub("Acc", "Accelerometer", names(targetData))
names(targetData)<- gsub("mean", "Mean", names(targetData))
names(targetData)<- gsub("^t", "Time", names(targetData))
names(targetData)<- gsub("Gyro", "Gyroscope", names(targetData))
names(targetData)<- gsub("Mag", "Magnitude", names(targetData))
names(targetData)<- gsub("^f", "Frequency", names(targetData))
names(targetData)<- gsub("freq", "Frequency", names(targetData))
names(targetData)<- gsub("std", "STD", names(targetData))
names(targetData)<- gsub("angle", "Angle", names(targetData))
names(targetData)<- gsub("gravity", "Gravity", names(targetData))
names(targetData)<- gsub("BodyBody", "Body", names(targetData))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
final <- targetData %>%
    group_by(subject, activities) %>%
    summarise_all(mean)
write.table(final, "FinalTable.txt", row.name = FALSE)

