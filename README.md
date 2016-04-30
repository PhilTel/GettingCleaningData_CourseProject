==================================================================
Coursera - Getting & Cleaning Data Course Project
Version 1.0
Author - Phillip Telfer

This repository contains output to meet the requirements of the Coursera
'Data Science - Getting and Cleaning Data' course project

The files were created manipulating the required dataset downloaded from:

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This project used the following files from the subject dataset:
===============================================================
- 'features.txt'
- 'activity_labels.txt'
- 'train/X_train.txt'
- 'train/y_train.txt'
- 'test/X_test.txt'
- 'test/y_test.txt'

I assumed the features.txt list provides variables names to the X_test and X_train
datasets such that top to bottom (features) matches left to right (X_test/train)
datasets.

This project conducted the analysis according to the project questions
and produces the following data outputs:  
======================================================================
Q1. Initial merged dataset: X_data
Q2. Merged data with columns extracted for all 'mean' and 'std variables: X_data_filtered
Q3. Merged data with activity names added: X_data_tidy
Q4. Existing names considered adequate: X_data_tidy
Q5. Data set of 2 independent tables: avg_by_subject & avg_by_activity

In answering Q3, I assumed that the question required extraction of all variables with
'mean' or 'std' in their names.

Files associated with this project are:
- 'README.txt'
- 'codebook.txt': contains information on the analyses undertaken
- 'run_Analysis.r': contains the r code for the required analysis
# GettingCleaningData_CourseProject
