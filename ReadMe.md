==================================================================
Getting and Cleaning Data - Course Project
Coursera Data Science Specialization
July 27, 2014
==================================================================

This repository has been created as the submission for the Course Project for the 'Getting and Cleaning Data' course on Coursera.  The project assignment was to create a script called r'un_analysis.R' that does the following using the data indicated below: 
 
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The 'run_analysis.R' script in this repository limits its analysis to the mean and std variables for tBodyAcc-XYZ and tGravityAcc-XYZ in order to improve readability and limit the size of the data frame submitted for grading.  As this script is written, expanding the number of variables analysed merely requires changing the indexes used in the 'meanANDstdData' data frame (see lines 34-36 of the script). 

The 'run_analysis.R' script uses some functions, including melt, dcast and arrange, from the reshape2 and plyr packages. 

Comments are included in the script file describing the step by step process that generates the final data frame. 


This repository includes the following files:
=========================================

- 'ReadMe.md' : The informational ReadMe file that you are currently reading. 

- 'CodeBook.md' : Indicates variables and summaries calculated by 'run_analysis.R'

- 'run_analysis.R' : Returns a data frame showing the mean value of each variable measured for each of the 30 subjects for each of the 6 activities. 

=========================================

The original data used in the project can be obtained here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The files from the orignal data set that were used by 'run_analysis.R' to create the final data frame include: 

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

=========================================
