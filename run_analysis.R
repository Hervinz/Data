####This code reads a series of files from a URL, which are "data collected 
#from the accelerometers from the Samsung Galaxy S smartphone". This data sets
#collection are combind in an only dataset, to be tidied and merged and finally
#to get interest measure average.


####READING, DONWLOADING AND UNZIPPING FILES
if(!dir.exists("./DataSmtf")) {dir.create("./DataSmtf")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = fileUrl, destfile = "./DataSmtf/UCIHAR.zip")
unzip(zipfile = "./DataSmtf/UCIHAR.zip", exdir = "./DataSmtf")



##GUIDE INFO. CONTAINED IN THE EXPERIMENT FILES
#For each record it is provided:
#======================================
#- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
#- Triaxial Angular velocity from the gyroscope. 
#- A 561-feature vector with time and frequency domain variables. 
#- Its activity label. 
#- An identifier of the subject who carried out the experiment.



#### TRAIN DATASET ####
#Subject corresponding to each of TRAIN observation.
subject_train <- read.table("./DataSmtf/UCI HAR Dataset/train/subject_train.txt")

#Each of the types of signals that the smartphone gives
#as data to calculate the acceleration and angular velocity.
x_train <- read.table("./DataSmtf/UCI HAR Dataset/train/X_train.txt")

#Observations taken from each of the activities.
y_train <- read.table("./DataSmtf/UCI HAR Dataset/train/y_train.txt")



#### TEST DATASET ####
#Subject corresponding to each of TEST observation.
subject_test <- read.table("./DataSmtf/UCI HAR Dataset/test/subject_test.txt")

#Each of the types of signals that the smartphone gives.
#as data to calculate the acceleration and angular velocity.
x_test <- read.table("./DataSmtf/UCI HAR Dataset/test/X_test.txt")

#Observations taken from each of the activities.
y_test <- read.table("./DataSmtf/UCI HAR Dataset/test/y_test.txt") 



#### NAME OF EACH OF THE 561 SIGNALS FROM WHICH DATA WAS TAKEN,
#INCLUDES NUMBERING AND NAME OF THE FEATURE
features <- read.table("./DataSmtf/UCI HAR Dataset/features.txt") 



#### CODE AND NAME OF EACH OF THE 6 ACTIVITIES OBSERVED
#INCLUDES NUMBERING AND NAME OF THE ACTIVITY
activity_labels <- read.table("./DataSmtf/UCI HAR Dataset/activity_labels.txt")



#Number of rows and columns per file
observaciones <- data.frame("features" = dim(features),
                            "actividades" = dim(activity_labels), row.names = c("NRows", "NCols"),
                            "subject_train" = dim(subject_train),
                            "x_train" = dim(x_train), "y_train" = dim(y_train),
                            "subject_test" = dim(subject_test),
                            "x_test" = dim(x_test), "y_test" = dim(y_test))
print(observaciones)


#### MERGING SETS ####

##Merging Train Data Sets
colnames(x_train) <- features[,2]
names(subject_train) <- "subject"
names(y_train) <- "codeactivity"
x_train <- cbind(subject_train, y_train, x_train)

##Merging Test Data Sets
colnames(x_test) <- features[,2]
names(subject_test) <- "subject"
names(y_test) <- "codeactivity"
x_test <- cbind(subject_test, y_test, x_test)


##Merging Test and Train Data Sets
colnames(activity_labels) <- c("codeactivity", "nameactivity")
ttdf <- rbind(x_train, x_test)


#Merging "activity_labels" with "ttdf".
library(dplyr)
ttdf <- merge(activity_labels, ttdf, by = "codeactivity", all.x = TRUE)


##Average
groupeddf <- cbind(ttdf[,2:3],
                   select(ttdf, contains("mean()")),
                   select(ttdf, contains("std()")))

groupeddf <- tbl_df(groupeddf) %>%
        group_by(nameactivity, subject) %>%
        summarize_if(is.numeric, mean) %>%
        print