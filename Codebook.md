CodeBook — UCI HAR Tidy Dataset (tidy_data.txt)

Source Data
- Dataset: Human Activity Recognition Using Smartphones (UCI HAR).
- Files used: features.txt, activity_labels.txt, train/X_train.txt, train/y_train.txt, train/subject_train.txt, test/X_test.txt, test/y_test.txt, test/subject_test.txt.
- Not used: Inertial Signals/ subfolders.

Transformations
1) Merge train and test sets for measurements (X), activities (y), and subjects.
2) Select only features whose names match '-(mean|std)()' (i.e., exact mean() and std()); exclude meanFreq() and others.
3) Map activity codes (1–6) to descriptive names: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
4) Clean variable names: remove '()' and '-', expand prefixes (t→Time, f→Frequency), replace Acc→Accelerometer, Gyro→Gyroscope, Mag→Magnitude, fix BodyBody→Body, mean→Mean, std→STD.
5) Aggregate: compute the mean of each selected variable for each (subject, activity) pair.
6) Export tidy dataset to 'tidy_data.txt' with row.names = FALSE.

Tidy Dataset Structure
- File: tidy_data.txt (space-delimited, header present, no row names).
- Rows: 180 (30 subjects × 6 activities).
- Columns: 68 = 2 identifiers + 66 aggregated measurements.
  * subject — integer, 1–30.
  * activity — character: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
  * 66 numeric measurement variables (averages per subject-activity).
- Units: normalized, unitless values as in the original dataset (typically ~[-1, 1]).

Measurement Variables (66)
TimeBodyAccelerometerMeanX
TimeBodyAccelerometerMeanY
TimeBodyAccelerometerMeanZ
TimeBodyAccelerometerSTDX
TimeBodyAccelerometerSTDY
TimeBodyAccelerometerSTDZ
TimeGravityAccelerometerMeanX
TimeGravityAccelerometerMeanY
TimeGravityAccelerometerMeanZ
TimeGravityAccelerometerSTDX
TimeGravityAccelerometerSTDY
TimeGravityAccelerometerSTDZ
TimeBodyAccelerometerJerkMeanX
TimeBodyAccelerometerJerkMeanY
TimeBodyAccelerometerJerkMeanZ
TimeBodyAccelerometerJerkSTDX
TimeBodyAccelerometerJerkSTDY
TimeBodyAccelerometerJerkSTDZ
TimeBodyGyroscopeMeanX
TimeBodyGyroscopeMeanY
TimeBodyGyroscopeMeanZ
TimeBodyGyroscopeSTDX
TimeBodyGyroscopeSTDY
TimeBodyGyroscopeSTDZ
TimeBodyGyroscopeJerkMeanX
TimeBodyGyroscopeJerkMeanY
TimeBodyGyroscopeJerkMeanZ
TimeBodyGyroscopeJerkSTDX
TimeBodyGyroscopeJerkSTDY
TimeBodyGyroscopeJerkSTDZ
TimeBodyAccelerometerMagnitudeMean
TimeBodyAccelerometerMagnitudeSTD
TimeGravityAccelerometerMagnitudeMean
TimeGravityAccelerometerMagnitudeSTD
TimeBodyAccelerometerJerkMagnitudeMean
TimeBodyAccelerometerJerkMagnitudeSTD
TimeBodyGyroscopeMagnitudeMean
TimeBodyGyroscopeMagnitudeSTD
TimeBodyGyroscopeJerkMagnitudeMean
TimeBodyGyroscopeJerkMagnitudeSTD
FrequencyBodyAccelerometerMeanX
FrequencyBodyAccelerometerMeanY
FrequencyBodyAccelerometerMeanZ
FrequencyBodyAccelerometerSTDX
FrequencyBodyAccelerometerSTDY
FrequencyBodyAccelerometerSTDZ
FrequencyBodyAccelerometerJerkMeanX
FrequencyBodyAccelerometerJerkMeanY
FrequencyBodyAccelerometerJerkMeanZ
FrequencyBodyAccelerometerJerkSTDX
FrequencyBodyAccelerometerJerkSTDY
FrequencyBodyAccelerometerJerkSTDZ
FrequencyBodyGyroscopeMeanX
FrequencyBodyGyroscopeMeanY
FrequencyBodyGyroscopeMeanZ
FrequencyBodyGyroscopeSTDX
FrequencyBodyGyroscopeSTDY
FrequencyBodyGyroscopeSTDZ
FrequencyBodyAccelerometerMagnitudeMean
FrequencyBodyAccelerometerMagnitudeSTD
FrequencyBodyAccelerometerJerkMagnitudeMean
FrequencyBodyAccelerometerJerkMagnitudeSTD
FrequencyBodyGyroscopeMagnitudeMean
FrequencyBodyGyroscopeMagnitudeSTD
FrequencyBodyGyroscopeJerkMagnitudeMean
FrequencyBodyGyroscopeJerkMagnitudeSTD
