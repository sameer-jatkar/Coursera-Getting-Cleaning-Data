---
title: "CodeBook.md"
output: html_document
---

This code book contains a brief description of data used in this project along with the processing done to prepare tidy data.

### Overview

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

### Files used for this activity

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

### Process to prepare tidy dataset

- Merge the training and the test sets to create one data set.

- Extract only the measurements on the mean and standard deviation for each measurement.

- Use descriptive activity names to name the activities in the data set

- Appropriately label the data set with descriptive variable names.

- From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.