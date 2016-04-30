## This file contains r script to meet the requirements of the Coursera
## 'Data Science - Getting and Cleaning Data' course project

## The working directory is assumed to be the expanded UCI HAR Dataset
## folders created when unzipping the data file downloaded from:
##
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##

## Each project question is commented and provides the following output:
## Q1. Initial merged dataset: X_data
## Q2. Merged data with columns extracted for all 'mean' and 'std variables: X_data_filtered
## Q3. Merged data with activity names added: X_data_tidy
## Q4. Existing names considered adequate: X_data_tidy
## Q5. Data set of 2 independent tables: avg_by_subject & avg_by_activity. Also creates output
##     text file Q5Dataset.txt which includes avg_by_subject and avg_by_activity

## I have assumd the features.txt list provides variables names to the X_test and X_train
## datasets such that top to bottom (features) matches left to right (X_test/train)
## datasets.

run_Analysis <- function(){

        library(dplyr)
        library(tidyr)
        library(LaF)
        
        ## read in the required data tables
        features <- read.table("features.txt", stringsAsFactors = FALSE)
        activity_labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
        
        subject_test <- read.table("./test/subject_test.txt")
        subject_train <- read.table("./train/subject_train.txt")
        y_test <- read.table("./test/y_test.txt")
        y_train <- read.table("./train/y_train.txt")
        
        d <- laf_open_fwf("./test/X_test.txt", column_types = rep("double", times = 561),
                          column_widths = rep(16, times = 561))
        X_test <- d[,]
        d <- laf_open_fwf("./train/X_train.txt", column_types = rep("double", times = 561),
                          column_widths = rep(16, times = 561))
        X_train <- d[,]
        
        ## Q1. merge data sets to form one set
        names(subject_test) <- "subject"
        names(subject_train) <- "subject"
        names(y_test) <- "activity_id"
        names(y_train) <- "activity_id"
        names(X_test) <- gsub("()", "", features[,2], fixed = TRUE)
        names(X_train) <- gsub("()", "", features[,2], fixed = TRUE)
        
        X_test <- cbind(y_test, subject_test, X_test)
        X_train <- cbind(y_train, subject_train, X_train)
        
        X_data <- rbind(X_train, X_test)
        
        ##Q2. Extract mean and std variables only
        ##    Note, I have chosen to exclude FreqMean variables, but have retained
        ##    all other variables containing the word "mean" or "std".
        X_data_filtered <- X_data[,c("activity_id", "subject",
                                  grep("mean", names(X_data), value = TRUE),
                                  grep("std", names(X_data), value = TRUE))]
        X_data_filtered <- X_data_filtered[,-grep("Freq", names(X_data_filtered))]

        ##Q3. Use descriptive Activity names
        names(activity_labels) <- c("activity_id", "activity")
        X_data_merged <- merge(activity_labels, X_data_filtered)
        X_data_tidy <- X_data_merged[,-1]
        
        ##Q4. Appropriately label the dataset with descriptive names
        
        ## I'm satisified that the labels provided during the analysis so far are
        ## appropriately descriptive, and are reflctive of the information provided
        ## in the features.txt file.
        
        ##Q5. Create independent dataset showing the average of each variable for
        ##    each activity and subject
        avg_by_activity <- aggregate(X_data_tidy[,-X_data_tidy$subject],
                                    by=list(X_data_tidy$activity), mean)
        avg_by_subject <- aggregate(X_data_tidy[,-(1:2)],
                                    by=list(X_data_tidy$subject), mean)
        write.table(avg_by_subject, file = "Q5Dataset.txt", row.names = FALSE)
        write.table(avg_by_activity, file = "Q5Dataset.txt", row.names = FALSE, append = TRUE)

}
        
