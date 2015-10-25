# I set the working directory for running on my machine, but to run this on your you will need to go to the working directory with the Samsung data.
#Set working directory
# setwd("~/WSR/Coursera_GCD_201510/UCI HAR Dataset")

#Load data.table and dplyr packages
library("data.table", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("dplyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")

#Read data
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
X_train <- read.table("train/X_train.txt")
X_test <- read.table("test/X_test.txt")
y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

#make data.table
subject_train <- data.table(subject_train)
subject_test <- data.table(subject_test)
X_train <- data.table(X_train)
X_test <- data.table(X_test)
y_train <- data.table(y_train)
y_test <- data.table(y_test)
activity_labels <- data.table(activity_labels)
features <- data.table(features)

#combined
subject <- rbind(subject_train, subject_test)
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)

#remove the training and testing DFs
rm(subject_train, subject_test, X_train, X_test, y_train, y_test)

#create activity vector with activity label
activity <- activity_labels[y$V1, V2]

#change column names
colnames(X) <- as.character(features$V2)
colnames(subject) <- c("subject")

#pick out only the mean and std
picks <- grepl("mean|std", features$V2)
cols <- which(picks)
X_selected <- select(X, cols)


#make the tidy DT by combinding subject, activity and data with selected columns
tidy <- cbind(subject, activity, X_selected)

#write data out to text file
write.table(tidy, file = "tidy.txt", row.name=FALSE)



