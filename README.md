Getting-and-Cleaning-Data---Coursera
====================================

This is a repository for the course project in the Course "Getting and Cleaning Data" as part of the Data Science Specialization

find all project-related materials in the UCI HAR Dataset directory, however, copies of the important files have been put into this main directory to fulfill the submission requirement)

    Unzip the source (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a folder on your local drive


    In RStudio: setwd(""C:/manas study/Data Science Specialization/Getting and Cleaning Data/data/UCI HAR Dataset"), followed by: source("run_analysis.R")

    Use data <- read.table("data_set_with_the_averages.txt") to read the data. It is 180x68 because there are 30 subjects and 6 activities, thus "for each activity and each subject" means 30 * 6 = 180 rows. Note that the provided R script has no assumptions on numbers of records, only on locations of files.
    
    The Steps in the analysis:
    
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The first step is done in a separate function at the end of the analysis

The second function is done using grep
featurenames <- read.table("features.txt")
numericmean <- grep("mean", names(propertrain))
numericstd <- grep("std", names(propertrain))
numericsubset <- c(1,2,numericmean,numericstd)
propertrain <- propertrain[,numericsubset]

The third step is done using an if statement

The last statment is done in the big for loop

