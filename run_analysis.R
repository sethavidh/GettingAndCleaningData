# run_analysis.R
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Merge data including activity label and import to tbl
test_data <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
test_y <- read.csv("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
train_data <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
train_y <- read.csv("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
features_frame <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
y <- rbind(test_y, train_y)
names(y) <- "label"
df <- rbind(test_data, train_data)
names(df) <- features_frame$V2
df <- cbind(df, y)
data <- tbl_df(df)

