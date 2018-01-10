library(tidyr)
library(reshape2)
library(plyr)
library(dplyr)


## Read features.txt file in a data table. 
test<- read.table("./files/features.txt")

## Read Subject_train.txt in a data table.
sub.train <- read.table("./files/train/subject_train.txt",quote="")

## Read Activity labels in a data table.
activity.lables <- read.table("./files/activity_labels.txt",quote="")

## Set descriptive names for Activity Labels data table
names(activity.lables) <- c("id","activity")


## Read training set and training labels in respective data tables
x.train <- read.table("./files/train/X_train.txt",quote="")
y.train <- read.table("./files/train/y_train.txt",quote="")

## Set descriptive names for training data table, training labels data table and subjects training data table
names(x.train) <- test$V2
names(y.train) = "ActivityLabels"
names(sub.train) = "Subject_Train"


## Start consolidating / binding data tables. training labels and Subject training data is to be added
## to the start of the training data table and not at the end of this data table
x.train1 <- cbind(y.train,x.train)
x.train2 <- cbind(sub.train,x.train1)

########################################################
###### Repeat the above process for test data set ######
########################################################

## Read Subject_test.txt in a data table.
sub.test <- read.table("./files/test/subject_test.txt",quote="")

## Read test data set and test labels in respective data tables
x.test <- read.table("./files/test/X_test.txt",quote="")
y.test <- read.table("./files/test/y_test.txt",quote="")

## Set descriptive names for test data table, test labels data table and subjects test data table
names(x.test) <- test$V2
names(y.test) = "ActivityLabels"
names(sub.test) = "Subject_Train"

## Start consolidating / binding data tables. Test labels and Subject test data is to be added
## to the start of the test data table and not at the end of this data table
## This will ensure that both training dataset and test data set are now loaded in exactly similar data frames
x.test1 <- cbind(y.test,x.test)
x.test2 <- cbind(sub.test,x.test1)

## Join [row bind] both training and test datasets or data tables to create a result data table
## This table now contains entire data set for analysis
result <- rbind(x.train2,x.test2)

## join for activity labels
result<- activity.lables %>% left_join(result, by = c("id"="ActivityLabels"))
result$id <- NULL

## Extract only the measurements on the mean and standard deviation for each measurement

result.subset <- result %>% select(Subject_Train,activity,ends_with("mean()-X"),ends_with("mean()-Y"),ends_with("mean()-Z"),ends_with("std()-X"),ends_with("std()-Y"),ends_with("std()-Z"))

## last thing to be done is melt and aggregate
## Create a second, independent tidy data set with the average of each variable for each activity and each subject.
result.melt <- melt(result.subset,id.vars = c("Subject_Train","activity"))

result.final <- dcast(result.melt,Subject_Train+activity ~ variable, mean)

## write tidy data into a file

write.csv(result.final,"tidy.csv",row.names = FALSE)
