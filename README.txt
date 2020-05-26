==================================================================
Tidying data from "Human Activity Recognition Using Smartphones Dataset"[1], and getting the average of the measurable variables. 

RStudio Version 1.2.5033
R Version 4.0.0
Windows 10 Pro N - x86_64

==================================================================

This project is carried out as one of the assignments to pass the "Getting and Cleaning Data" course, which is offered on the Corsera platform, and which was designed as part of the specialized program in Data Science by Jeff Leek, Roger D. Peng and  Brian Caffo, who are professors in the Department of Biostatistics at the Johns Hopkins University Bloomberg School of Public Health.

==================================================================

This GitHub repository contains, in addition to this file (README.txt), the code for the execution of the project and a "CodeBook" where is possible to read a description of the used R code, the variables, the data and the transformations applied to the data.

==================================================================

* The data is disaggregated into a group of files, which separately contain the raw data, calculated datas, features, subjects and activities observed.
(Those files can be downladed here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
(A full description is available at the site where the data was obtained:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

==================================================================


* For achieving the project objective, the following sequence of tasks was carried out:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



========
========
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.