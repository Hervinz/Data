fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = fileUrl, destfile = "UCIHAR.zip")


#### DATOS GRUPO DE ENTRENAMIENTO

#Sujeto al cual está asociada cada obervación
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Cada uno de los tipos de señales que el teléfono inteligente
#entrega como datos para calcular la asceleración y velocidad angular.
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

#Obervaciones tomadas de cada una de las actividades
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")



#### DATOS GRUPO DE PRUEBA
#Sujeto al cual está asociada cada obervación
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Cada uno de los tipos de señales que el teléfono inteligente
#entrega como datos para calcular la asceleración y velocidad angular.
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

#Obervaciones tomadas de cada una de las actividades 
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 



####NOMBRE DE CADA UNA DE LAS 561 SEÑALES DE LAS QUE SE TOMARON DATOS,
#INCLUYE NUMERACIÓN Y NOMBRE DE LA CARACTERÍSTICA
features <- read.table("./UCI HAR Dataset/features.txt") 



####CÓDGICO Y NOMBRE DE CADA UNA DE LAS 6 ACTIVIDADES OBSERVADAS
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")



#Cantidad filas y columnas por archivo
observaciones <- data.frame("features" = dim(features),
                            "actividades" = dim(activity_labels), row.names = c("NRows", "NCols"),
                            "subject_train" = dim(subject_train),
                            "x_train" = dim(x_train), "y_train" = dim(y_train),
                            "subject_test" = dim(subject_test),
                            "x_test" = dim(x_test), "y_test" = dim(y_test))
observaciones