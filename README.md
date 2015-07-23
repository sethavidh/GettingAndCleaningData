---
title: "README"
author: "Sethavidh Gertphol"
date: "23 July 2558 BE"
output: html_document
---

This project imports, cleans up, and re-formats data into tidy data for further analysis.

The original data was collected from an experiment about wearable device. The data set is located at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and the data set is explained at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data set must be manually downloaded and unzip into UCI HAR Dataset subdirectory first.

The script run_analysis.R will clean up the data and exports output to result.txt file.

The code_book.txt explains the tidy data set in result.txt file.

##The working of run_analysis.R##

* Both test and train data sets are imported along with the activity label and subject that generated each observation.
* The data sets are combined together with activity label and subject into one data frame. Any column with duplicated name is removed. (They are not needed anyway.)
* The data frame is converted into tbl object using dplyr package. Then select() function of dplyr package is used to select only mean and std columns out.
* The data is grouped by activity and subject. Then the average of all readings from a single subject in a single activity is calculated. The process repeats for all combination of subjects and activities. 
* The result is written to result.txt file.
