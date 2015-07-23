# run_analysis.R
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

# import data
test_data <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
test_y <- read.csv("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
test_subject <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
train_data <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
train_y <- read.csv("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
train_subject <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
features_frame <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
activity_df <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
activity_label <- activity_df$V2

# combine test and train data
df <- rbind(test_data, train_data)
names(df) <- features_frame$V2
y <- rbind(test_y, train_y)
activity <- as.factor(y[[1]])
levels(activity) <- activity_label
subject <- rbind(test_subject, train_subject)
names(subject) <- "subject"

# combine columns
df <- cbind(subject, activity, df)
# remove duplicated columns
df_u <- df[,!duplicated(colnames(df))]

# import to dplyr
data <- tbl_df(df_u)

# extract subject activity means stds
data_m <- select(data, subject, activity, matches("mean"), matches("std"), -matches("angle"))

tidy_data <- group_by(data_m, activity, subject)
result <- summarise_each(tidy_data, funs(mean))
write.table(result, "result.txt", row.names = FALSE)