About X_means_by_subject_and_activity.csv
-----------------------------------------

The file X\_means\_by\_subject\_and\_activity.csv contains summary data based
on the [Human Activity Recognition Using Smartphones Data
Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The actual zip file is retrieved from a
[location](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
that is specific to Coursera _Getting and Cleaning Data_ course. 

The code to create this data set is in `run_analysis.R`. To re-generate the
data set, run the following code

    source("run_analysis.R")
    write_X_means()

The original data set contains many data points on many variables (features)
for two sets of data (a training set and a test set). All together it covers 30
test subjects. Transformation applied are:

1. Activities were converted from numerical ids to lower case names
1. Measurement names were sanitized so that they can be use as column names in R
1. Only mean measurements were preserved (standard deviation, min, max, and others were discarded)
1. The training and test sets were combined in a single set covering all 30 subjects
1. The means were then averaged per subject and activity.

The columns are:

* subject_id (1 to 30)
* activity (walking, walking_upstairs, walking_downstairs, sitting, standing and laying)
* 33 different average measurements for the subject and activity (BodyAcc_X_mean, fBodyAcc_Y_mean, fBodyAcc_Z_mean, fBodyAccJerk_X_mean, fBodyAccJerk_Y_mean, fBodyAccJerk_Z_mean, fBodyAccMag_mean, fBodyBodyAccJerkMag_mean, fBodyBodyGyroJerkMag_mean, fBodyBodyGyroMag_mean, fBodyGyro_X_mean, fBodyGyro_Y_mean, fBodyGyro_Z_mean, tBodyAcc_X_mean, tBodyAcc_Y_mean, tBodyAcc_Z_mean, tBodyAccJerk_X_mean, tBodyAccJerk_Y_mean, tBodyAccJerk_Z_mean, tBodyAccJerkMag_mean, tBodyAccMag_mean, tBodyGyro_X_mean, tBodyGyro_Y_mean, tBodyGyro_Z_mean, tBodyGyroJerk_X_mean, tBodyGyroJerk_Y_mean, tBodyGyroJerk_Z_mean, tBodyGyroJerkMag_mean, tBodyGyroMag_mean, tGravityAcc_X_mean, tGravityAcc_Y_mean, tGravityAcc_Z_mean, tGravityAccMag_mean)


Here are the details of the variables (verbatim from the original dataset):

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

