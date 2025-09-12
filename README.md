Getting and Cleaning Data — UCI HAR Project

How the script works (run_analysis.R)
- Merges the training and test datasets.
- Extracts only the measurements on the exact mean() and std() features.
- Uses descriptive activity names for activities.
- Labels the dataset with descriptive, human-readable variable names.
- Creates a second tidy dataset with the average of each variable for each activity and each subject.

How to run
1) Place the unzipped folder named exactly 'UCI HAR Dataset' in your working directory.
2) Ensure 'run_analysis.R' is in the same working directory.
3) In R, run:  source('run_analysis.R')
4) Output: 'tidy_data.txt' (created with write.table(..., row.names = FALSE)).