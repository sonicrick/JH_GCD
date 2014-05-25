
## ------------------------------------------------------------------------
# if you're reading this from the .R script, please note that the code script has minimal comments.
# Script comments can be found in README.md in this repo
data.path <- "UCI HAR Dataset/test"


## ------------------------------------------------------------------------
features <- read.table("UCI HAR Dataset/features.txt", col.names=c("no", "name"))



## ------------------------------------------------------------------------
feature.name.pattern <- "mean\\(\\)|std\\(\\)"
header.keep <- grep(feature.name.pattern, features$name)


## ------------------------------------------------------------------------
header.list <- rep("NULL", nrow(features))
header.list[header.keep] <- NA 


## ------------------------------------------------------------------------
X_data <- rbind(
  read.table("UCI HAR Dataset/train/X_train.txt", colClasses=header.list),
  read.table("UCI HAR Dataset/test/X_test.txt", colClasses=header.list)
  )


## ------------------------------------------------------------------------
names(X_data) <- features$name[header.keep]


## ------------------------------------------------------------------------
y_data <- rbind(
  read.table("UCI HAR Dataset/train/y_train.txt"),
  read.table("UCI HAR Dataset/test/y_test.txt")
  )


## ------------------------------------------------------------------------
activities <- read.table("UCI HAR Dataset/activity_labels.txt")


## ----, message=FALSE, warning=FALSE--------------------------------------
library(plyr)
y.labeled <- join(y_data, activities)  # implicitly join by first columns (V1) in both dataframes
X_data$ActivityLabel <- y.labeled$V2


## ------------------------------------------------------------------------
Subject <- rbind(
  read.table("UCI HAR Dataset/train/subject_train.txt"),
  read.table("UCI HAR Dataset/test/subject_test.txt")
  )
X_data$Subject <- Subject$V1


## ------------------------------------------------------------------------
write.table(X_data, "Tidy Full Dataset.txt", row.names=FALSE)


## ----, message=FALSE, warning=FALSE--------------------------------------
library(reshape2)
molten <- melt(X_data, id.vars=c("ActivityLabel", "Subject"),
               variable.name="Measurement", value.name="Value")


## ------------------------------------------------------------------------
average.data <- dcast(molten, ActivityLabel + Subject ~ Measurement, mean)
write.table(average.data, "Tidy Averages.txt", row.names=FALSE)


## ------------------------------------------------------------------------
var.names <- as.character(features$name[header.keep])  # convert from factor to text
desc1 <- ifelse(grepl("mean\\(\\)", var.names), "Mean of",
         ifelse(grepl("std\\(\\)", var.names), "Standard deviation of", ""
         ))

desc2 <- ifelse(grepl("Mag", var.names), "magnitude of",
         ifelse(grepl("-X", var.names), "X-direction",
         ifelse(grepl("-Y", var.names), "Y-direction",
         ifelse(grepl("-Z", var.names), "Z-direction", ""
         ))))

desc3 <- ifelse(substr(var.names,1,1) == "t", "time-domain signal",
         ifelse(substr(var.names,1,1) == "f", "frequncy-domain signal", ""
         ))

desc4 <- ifelse(grepl("Body", var.names), "of body",
         ifelse(grepl("Gravity", var.names), "of gravity", ""
         ))

desc5 <- ifelse(grepl("Jerk", var.names), "jerk", "acceleration")

desc6 <- ifelse(grepl("Acc", var.names), "from the accelerator raw signal",
         ifelse(grepl("Gyro", var.names), "from the accelerator raw signal", ""
         ))

var.description <- paste(var.names, ":", desc1, desc2, desc3, desc4, desc5, desc6)

write.table(var.description, "Var descriptions.txt", row.names=FALSE)


