---
title: "TIDYING DATA SETS ASSIGMENT"
author: "Hervin Zuluaga"
date: "24/5/2020"
output:
  html_document: default
  pdf_document: default
---

# **ABSTRACT**

This code reads a series of files from a URL, which are "data collected 
from the accelerometers from the Samsung Galaxy S smartphone". This data sets
collection are combind in an only dataset, to be tidied and merged and finally
to get interest measure average.Just below, the developed code is presented step by step along with brief descriptions of each section.             

### **DONWLOADING AND UNZIPPING FILES**
-**DataSmtf**: Checking if the folder where the files will be stored exist, then if it doesn't, the folder is created.         
-**fileURL**: store link with file .zip download link.          
-**unzip** function: unzip de file and store it in DataSmtf folder.             

```{r}
if(!dir.exists("./DataSmtf")) {dir.create("./DataSmtf")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = fileUrl, destfile = "./DataSmtf/UCIHAR.zip")
unzip(zipfile = "./DataSmtf/UCIHAR.zip", exdir = "./DataSmtf")
```
                
                
                
                
### **READING FILES**
Files are read and estored in dataframes:                     
**subject_train**: subject corresponding to each of TRAIN observation.          
**x_train**: dataframe within the datas corresponding to each of the measured characteristics to TRAIN.               
**y_train**: activity codes corresponding to each of TRAIN observation.         
**subject_test**: subject corresponding to each of TEST observation.            
**x_test**:dataframe within the datas corresponding to each of the measured characteristics to TEST.                
**y_test**: activity codes corresponding to each of TEST observation.           
**features**: dataframe within the name of each of the 561 signal from which data data was taken.              
**activity_labels**: code and name of each of the 6 kind of activities observed.              


```{r}
subject_train <- read.table("./DataSmtf/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./DataSmtf/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./DataSmtf/UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./DataSmtf/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./DataSmtf/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./DataSmtf/UCI HAR Dataset/test/y_test.txt")
features <- read.table("./DataSmtf/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./DataSmtf/UCI HAR Dataset/activity_labels.txt")
```



**observaciones**: this dataframe shows the number of rows and columns of the tables loaded above. This is an auxiliar object useful to get a clearer idea of the structure of each of the tables and how they can be related to each other.                


```{r}
observaciones <- data.frame("features" = dim(features),
                            "actividades" = dim(activity_labels), row.names = c("NRows", "NCols"),
                            "subject_train" = dim(subject_train),
                            "x_train" = dim(x_train), "y_train" = dim(y_train),
                            "subject_test" = dim(subject_test),
                            "x_test" = dim(x_test), "y_test" = dim(y_test))
print(observaciones)
```



### **MERGING SETS**

Before combining the TRAIN and TEST data sets, it is added the names to the fields of each one of them. Then the tables are joined by columns with the information of the subjects, the activities and the measured characteristics, both for the TRAIN data set and the TEST data set.          


**Merging Train Data Sets**             

```{r}
colnames(x_train) <- features[,2]
names(subject_train) <- "subject"
names(y_train) <- "codeactivity"
x_train <- cbind(subject_train, y_train, x_train)
```
**Merging Test Data Sets**              

```{r}
colnames(x_test) <- features[,2]
names(subject_test) <- "subject"
names(y_test) <- "codeactivity"
x_test <- cbind(subject_test, y_test, x_test)
```


**Merging Test and Train Data Sets**            

<p>Now the goal is the merging of the TRAIN data set with the TEST data set in only one named ***ttdf***.The naming of the columns of the "data frame" activtity_labels is done to later change the code of the activity to the name of the activity.</p>

```{r}
colnames(activity_labels) <- c("codeactivity", "nameactivity")
ttdf <- rbind(x_train, x_test)
```


**Merging "activity_labels" with "ttdf"**               

<p>At this point the  ***ttdf*** dataframe has the activity codes that correspond to each observation, but instead the name of the activities is required. To achieve this change, the "merge" function will be apply for ***ttdf*** dataframe and the ***activity_labels***, using the "CodeActivity" field as a reference column for the union. This funtions is part of the "dplyr" library.</p>

```{r}
library(dplyr)
ttdf <- merge(activity_labels, ttdf, by = "codeactivity", all.x = TRUE)
```

### **GROUPING DATA AND MEASURE AVERAGE**

<p>Finally, only the columns with measures of "mean ()" and "std ()" will be extracted in a new dataframe named **_groupeddf_**, and the average value of each field will be obtained for each activity carried out by each subject. A simple way to achieve these operations is by applying functions from the ***dplyr*** library to an object of type ***tbl_df***, which is why it is necessary to convert the dataframe into an object of that type.</p>

```{r}
groupeddf <- cbind(ttdf[,2:3],
                   select(ttdf, contains("mean()")),
                   select(ttdf, contains("std()")))

groupeddf <- tbl_df(groupeddf) %>%
        group_by(nameactivity, subject) %>%
        summarize_if(is.numeric, mean) %>%
        print 
```