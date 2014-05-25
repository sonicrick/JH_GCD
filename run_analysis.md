run_analysis.R
========================================================

This is a submission for the project in the Coursera course "Getting and Cleaning Data". The codes are written in R Markdown on RStudio, and knitted to produce both the R script and the README.md for submission. CODEBOOK.md is produced separately, but will be described below.


# Project description
The aim is to perform the five tasks below on data downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Each 5 tasks above will be explained below.



# Approach
The data are all stored in the subdirectory 'UCI HAR Dataset'. It comes with some explanatory documents detailed in the 'README.txt' in the root of the subdirectory, which I shall refer to in the descriptions below.


```r
# if you're reading this from the .R script, please note that the code
# script has minimal comments.  Script comments can be found in README.md in
# this repo
data.path <- "UCI HAR Dataset/test"
```



## Tasks 1 and 2: Merging and extracting test sets
This section merges tasks 1 and 2 above. It is sequentially logical to read all the training set and then all the test set to merge them into one, before extracting the measurements of interest. However, this will mean loading all the data into memory before selecting just a fraction of them. Given the reasonably big size of the data, this can potentially hit a memory limt. It will also incur a long time to read all the data from disk to memory.

I decided to minimise this by selectively identifying only the measurements we are interested in, and reading only those into memory. Hence it actually intertwine tasks 1 and 2 above.

### Identifying measurements
As identified in the dataset's 'README.txt', all the feature names can be found in 'features.txt'. I first read all feature names from 'features.txt' into the variable feature.


```r
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("no", "name"))
```


All the features are described in 'features_info.txt'. Task 2 of this project requires specifically only measurement on "mean and standard deviation", which in 'features_info.txt'corresponds to variables that have the words 'mean()' and 'std()' only, following description in features_info.txt

To do so, I create a regular expression pattern to extract all names that have either 'mean()' or 'std()' in it (note the inclusion of the brackets). I then find the column numbers for all the columns that fit this criteria.


```r
feature.name.pattern <- "mean\\(\\)|std\\(\\)"
header.keep <- grep(feature.name.pattern, features$name)
```


Note that I explicitly only take variables which are defined to be mean or standard deviation. This means I exclude other variables that don't have 'mean' or 'standard deviation' as their main definitions e.g.:
- those which has the word 'mean' in the variable name but without explicit definition, e.g. gravityMean
- those that says 'average' rather than 'mean' e.g. meanFreq()
Any change to this criteria will simply require a change to the feature.name.pattern variable above in searching the variables to extract.

### Reading and merging from file
Before starting reading from file, I first setup a vector of columns to read or exclude.
Based on the parameter for colClasses in read.table function, columns to be excluded are to be indicated as "NULL". Classes for classes to be read can be coerced, but I prefer to let R determine it, so I set them to NA.


```r
header.list <- rep("NULL", nrow(features))
header.list[header.keep] <- NA
```


With the above set, I can simply read the data using read.table, passing header.list as parameter to read columns selectively.

The project requires merging of the data for training and test. Here I first do it for the data in files 'X_test.txt'. To do so, I simply use rbind() to add the rows read from subfolder 'test'  to those from subfolder 'training'.



```r
X_data <- rbind(read.table("UCI HAR Dataset/train/X_train.txt", colClasses = header.list), 
    read.table("UCI HAR Dataset/test/X_test.txt", colClasses = header.list))
```



## Task 3: Use descriptive activity names
I interpret this to mean to give a meaningful name to all the extracted data columns so far. I simply reuse the index in variable header.keep, which identify the column numbers to use. The names from the same column numbers (already extracted initially for selecting the measurements) are then applied as the name of the columns read from the file.


```r
names(X_data) <- features$name[header.keep]
```


(Note this can be merged into read.table command above in tasks 1 and 2 with the col.names parameter. But since it doesn't improve memory or speed much, I keep it separate here to avoid merging Task 3 into the already-merged tasks 1 and 2)


## Task 4: Labeling the dataset
As described in 'README.txt' of the dataset, files 'y_train.txt' and 'y_test.txt' contain labels for the training and test datasets respectively. So firstly I read in the data and merge them into one, in the same sequence as the X_data earlier.


```r
y_data <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt"))
```


The 'README.txt' also mentions that the activity names are in 'activity_labels.txt'. So we read this in too.


```r
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
```


To provide descriptive meaning for the labels, we merge the y_data with activities. However, merge() function from R does not preserve order of the data. Hence, I use join() from plyr package. The label is then added as a new variable in the X_data dataframe, excluding the integer coding.


```r
library(plyr)
y.labeled <- join(y_data, activities)  # implicitly join by first columns (V1) in both dataframes
X_data$ActivityLabel <- y.labeled$V2
```


The subject of the experiment for each record is added in the same way as label above, but without the need for joining.


```r
Subject <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt"))
X_data$Subject <- Subject$V1
```


Finally, the final data written out to a text file. The row number is suppressed to avoid creating an additional column


```r
write.table(X_data, "Tidy Full Dataset.txt", row.names = FALSE)
```



## Task 5: Creating a second tidy dataset containing averages
Firstly, for a tidy data, all observations have to be a single row. Therefore, I need to reshape the data such that every combination of a measurement, an activity label, and a subject is a single row. 


```r
library(reshape2)
molten <- melt(X_data, id.vars = c("ActivityLabel", "Subject"), variable.name = "Measurement", 
    value.name = "Value")
```


The data is then cast back into the original data frame headers but with the function mean applied to calculate the average. The result is written out as a text file.


```r
average.data <- dcast(molten, ActivityLabel + Subject ~ Measurement, mean)
```

```
## Using Value as value column: use value.var to override.
```

```r
write.table(average.data, "Tidy Averages.txt", row.names = FALSE)
```




# Creation of CODEBOOK.md
A codebook is requested as part of the project, to be stored as CODEBOOK.md . I divide the codebook into two parts:
1. General information on the experiment, or anything that applies to all variables
2. A table of description of every variables included in 'Tidy Full Dataset.csv'


## General information
The original dataset's README.txt provides a number of information on the experiment and how the data is obtained. I copy and paste the relevant info into CODEBOOK.md


## Variable definitions
There is a very structured naming convention for the variables as defined in 'features_info.txt'. I make use of that definition to create the script to auto-generate the human-readable definitions of the variables kept in 'Tidy Full Dataset.csv'. This excludes ActivitiesLabel and Subject, which are added separately and hence requires a manual entry into the CODEBOOK.md

The code below will generate all the definitions and write it to a text file for my copy-and-paste.


```r
var.names <- as.character(features$name[header.keep])  # convert from factor to text
desc1 <- ifelse(grepl("mean\\(\\)", var.names), "Mean of", ifelse(grepl("std\\(\\)", 
    var.names), "Standard deviation of", ""))

desc2 <- ifelse(grepl("Mag", var.names), "magnitude of", ifelse(grepl("-X", 
    var.names), "X-direction", ifelse(grepl("-Y", var.names), "Y-direction", 
    ifelse(grepl("-Z", var.names), "Z-direction", ""))))

desc3 <- ifelse(substr(var.names, 1, 1) == "t", "time-domain signal", ifelse(substr(var.names, 
    1, 1) == "f", "frequncy-domain signal", ""))

desc4 <- ifelse(grepl("Body", var.names), "of body", ifelse(grepl("Gravity", 
    var.names), "of gravity", ""))

desc5 <- ifelse(grepl("Jerk", var.names), "jerk", "acceleration")

desc6 <- ifelse(grepl("Acc", var.names), "from the accelerometer raw signal  ", 
    ifelse(grepl("Gyro", var.names), "from the gyroscope raw signal  ", ""))

var.description <- paste(var.names, ":", desc1, desc2, desc3, desc4, desc5, 
    desc6)

write.table(var.description, "Var descriptions.txt", row.names = FALSE)
```


(Note: quite a few feature names are found of the construct 'fBodyBody[description]' e.g. 'fBodyBodyGyroMag-mean()'. 'features_info.txt' did not mention existence of such features. Hence, it is assumed that these are typos of where there is one too many 'Body' in the file name. i.e. the example above would be defined as 'fBodyGyroMag-mean()'. In this codebook, I will apply this definition in absence of other explanation in the dataset documentation, but will NOT rename the actual feature name.)
