### run_analysis.R does the following: 
        # Merges the training and the test sets to create one data set.
        # Extracts only the measurements on the mean and standard deviation for each measurement
        # Uses descriptive activity names to name the activities in the data set
        # Appropriately labels the data set with descriptive variable names. 
        # Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("~/Documents/CourseraDataScience/Getting and Cleaning Data/Project")
library(reshape2)
library(plyr)

## Load the data sets into R. 
activityLabels <- read.table("activity_labels.txt", col.names = c("activityNum", "activityName"), stringsAsFactors = TRUE)
featuresLabels <- read.table("features.txt")
xTrain <- read.table("x_train.txt", col.names = featuresLabels[,2])
xTest <- read.table("x_test.txt", col.names = featuresLabels[,2])
yTest <- read.table("y_test.txt", col.names = c("activityNum"))
yTrain <- read.table("y_train.txt", col.names = c("activityNum"))
subjectTrain <- read.table("subject_train.txt", col.names = c("subjectID"))
subjectTest <- read.table("subject_test.txt", col.names = c("subjectID"))

## Merge Test Data Sets
testData <- cbind(subjectTest, yTest)
testData <- cbind(testData, xTest)

## Merge the Train Data Sets
trainData <- cbind(subjectTrain, yTrain)
trainData <- cbind(trainData, xTrain)

## Merge Test and Train Data Sets
allData <- rbind(testData, trainData)

## Subset data set to include the mean and standard deviation values for tBodyAcc-XYZ and tGravityAcc-XYZ.  The variables analyzed in this analysis and outputted into the final table cab be easily expanded by changing which columns are included from the 'allData' data frame. This analysis script only uses a small number of the available features variables in order to make the final data frame submitted for this project easily readable. 
indexFromFeatures <- c(1:6, 41:46)
meanANDstdIndex <- indexFromFeatures + 2
meanANDstdData <- allData[,c(1:2, meanANDstdIndex)]

## Add activity labels to data using merge() function
dataWithActivityLabels <- merge(activityLabels, meanANDstdData, by.x = "activityNum", by.y = "activityNum")

## Subset the big data frame into data frames for each of the six activities
activity1 <- dataWithActivityLabels[dataWithActivityLabels$activityNum == 1,]
activity2 <- dataWithActivityLabels[dataWithActivityLabels$activityNum == 2,]
activity3 <- dataWithActivityLabels[dataWithActivityLabels$activityNum == 3,]
activity4 <- dataWithActivityLabels[dataWithActivityLabels$activityNum == 4,]
activity5 <- dataWithActivityLabels[dataWithActivityLabels$activityNum == 5,]
activity6 <- dataWithActivityLabels[dataWithActivityLabels$activityNum == 6,]

## Melt the data frames
columnNames <- names(dataWithActivityLabels)
variableNames <- columnNames[4:15]
meltedData1 <- melt(activity1, id.vars = c("subjectID"), measure.vars = variableNames)
meltedData2 <- melt(activity2, id.vars = c("subjectID"), measure.vars = variableNames)
meltedData3 <- melt(activity3, id.vars = c("subjectID"), measure.vars = variableNames)
meltedData4 <- melt(activity4, id.vars = c("subjectID"), measure.vars = variableNames)
meltedData5 <- melt(activity5, id.vars = c("subjectID"), measure.vars = variableNames)
meltedData6 <- melt(activity6, id.vars = c("subjectID"), measure.vars = variableNames)

## dcast data frames to get averages for each variable
castData1 <- dcast(meltedData1, subjectID ~ variable, mean)
castData1 <- cbind("Activity" = rep("WALKING", 30), castData1)
castData2 <- dcast(meltedData2, subjectID ~ variable, mean)
castData2 <- cbind("Activity" = rep("WALKING_UPSTAIRS", 30), castData2)
castData3 <- dcast(meltedData3, subjectID ~ variable, mean)
castData3 <- cbind("Activity" = rep("WALKING_DOWNSTAIRS", 30), castData3)
castData4 <- dcast(meltedData4, subjectID ~ variable, mean)
castData4 <- cbind("Activity" = rep("SITTING", 30), castData4)
castData5 <- dcast(meltedData5, subjectID ~ variable, mean)
castData5 <- cbind("Activity" = rep("STANDING", 30), castData5)
castData6 <- dcast(meltedData6, subjectID ~ variable, mean)
castData6 <- cbind("Activity" = rep("LAYING", 30), castData6)

## append the data frames into the final data frame and order the final data frame by subject then activity
unorderedFinalData <- data.frame()
unorderedFinalData <- rbind(unorderedFinalData, castData1)
unorderedFinalData <- rbind(unorderedFinalData, castData2)
unorderedFinalData <- rbind(unorderedFinalData, castData3)
unorderedFinalData <- rbind(unorderedFinalData, castData4)
unorderedFinalData <- rbind(unorderedFinalData, castData5)
unorderedFinalData <- rbind(unorderedFinalData, castData6)
finalData <- arrange(unorderedFinalData, subjectID, Activity)



## Write combined data frame to a file
write.table(finalData, file = "dataFrame_Project.txt")

## remove unnecessary files from memory
remove(castData1, castData2, castData3, castData4, castData5, castData6, meltedData1, meltedData2, meltedData3, meltedData4, meltedData5, meltedData6, activity1, activity2, activity3, activity4, activity5, activity6, dataWithActivityLabels, xTrain, yTrain, xTest, yTest, subjectTrain, subjectTest, activityLabels, allData, featuresLabels, testData, trainData, unorderedFinalData)



