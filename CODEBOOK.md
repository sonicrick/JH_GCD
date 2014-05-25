Codebook for 'Tidy Full Dataset.csv'
====================================

'Tidy Full Dataset.csv' contains data from experiments under the project "Human Activity Recognition Using Smartphones" by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

# Experiment Overview
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

# Features
561 features are calculated from the raw inertial signals in the experiment. Of those features, only 66 which are mean or standard deviation of estimated variables are retained in 'Tidy Full Dataset.csv'. Some general information on the features:
- All features are normalized and bounded within [-1,1].
- Time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise
- Fast Fourier Transform (FFT) was applied to produce the frequency domain signals.
- Acceleration features are measured in standard gravity units 'g'.
- Magnitude features are calculated using the Euclidean norm.
- body linear acceleration and angular velocity were derived in time to obtain Jerk signals


# Feature Definition
tBodyAcc-mean()-X : Mean of X-direction time-domain signal of body acceleration from the accelerometer raw signal  
tBodyAcc-mean()-Y : Mean of Y-direction time-domain signal of body acceleration from the accelerometer raw signal  
tBodyAcc-mean()-Z : Mean of Z-direction time-domain signal of body acceleration from the accelerometer raw signal  
tBodyAcc-std()-X : Standard deviation of X-direction time-domain signal of body acceleration from the accelerometer raw signal  
tBodyAcc-std()-Y : Standard deviation of Y-direction time-domain signal of body acceleration from the accelerometer raw signal  
tBodyAcc-std()-Z : Standard deviation of Z-direction time-domain signal of body acceleration from the accelerometer raw signal  
tGravityAcc-mean()-X : Mean of X-direction time-domain signal of gravity acceleration from the accelerometer raw signal  
tGravityAcc-mean()-Y : Mean of Y-direction time-domain signal of gravity acceleration from the accelerometer raw signal  
tGravityAcc-mean()-Z : Mean of Z-direction time-domain signal of gravity acceleration from the accelerometer raw signal  
tGravityAcc-std()-X : Standard deviation of X-direction time-domain signal of gravity acceleration from the accelerometer raw signal  
tGravityAcc-std()-Y : Standard deviation of Y-direction time-domain signal of gravity acceleration from the accelerometer raw signal  
tGravityAcc-std()-Z : Standard deviation of Z-direction time-domain signal of gravity acceleration from the accelerometer raw signal  
tBodyAccJerk-mean()-X : Mean of X-direction time-domain signal of body jerk from the accelerometer raw signal  
tBodyAccJerk-mean()-Y : Mean of Y-direction time-domain signal of body jerk from the accelerometer raw signal  
tBodyAccJerk-mean()-Z : Mean of Z-direction time-domain signal of body jerk from the accelerometer raw signal  
tBodyAccJerk-std()-X : Standard deviation of X-direction time-domain signal of body jerk from the accelerometer raw signal  
tBodyAccJerk-std()-Y : Standard deviation of Y-direction time-domain signal of body jerk from the accelerometer raw signal  
tBodyAccJerk-std()-Z : Standard deviation of Z-direction time-domain signal of body jerk from the accelerometer raw signal  
tBodyGyro-mean()-X : Mean of X-direction time-domain signal of body acceleration from the gyroscope raw signal  
tBodyGyro-mean()-Y : Mean of Y-direction time-domain signal of body acceleration from the gyroscope raw signal  
tBodyGyro-mean()-Z : Mean of Z-direction time-domain signal of body acceleration from the gyroscope raw signal  
tBodyGyro-std()-X : Standard deviation of X-direction time-domain signal of body acceleration from the gyroscope raw signal  
tBodyGyro-std()-Y : Standard deviation of Y-direction time-domain signal of body acceleration from the gyroscope raw signal  
tBodyGyro-std()-Z : Standard deviation of Z-direction time-domain signal of body acceleration from the gyroscope raw signal  
tBodyGyroJerk-mean()-X : Mean of X-direction time-domain signal of body jerk from the gyroscope raw signal  
tBodyGyroJerk-mean()-Y : Mean of Y-direction time-domain signal of body jerk from the gyroscope raw signal  
tBodyGyroJerk-mean()-Z : Mean of Z-direction time-domain signal of body jerk from the gyroscope raw signal  
tBodyGyroJerk-std()-X : Standard deviation of X-direction time-domain signal of body jerk from the gyroscope raw signal  
tBodyGyroJerk-std()-Y : Standard deviation of Y-direction time-domain signal of body jerk from the gyroscope raw signal  
tBodyGyroJerk-std()-Z : Standard deviation of Z-direction time-domain signal of body jerk from the gyroscope raw signal  
tBodyAccMag-mean() : Mean of magnitude of time-domain signal of body acceleration from the accelerometer raw signal  
tBodyAccMag-std() : Standard deviation of magnitude of time-domain signal of body acceleration from the accelerometer raw signal  
tGravityAccMag-mean() : Mean of magnitude of time-domain signal of gravity acceleration from the accelerometer raw signal  
tGravityAccMag-std() : Standard deviation of magnitude of time-domain signal of gravity acceleration from the accelerometer raw signal  
tBodyAccJerkMag-mean() : Mean of magnitude of time-domain signal of body jerk from the accelerometer raw signal  
tBodyAccJerkMag-std() : Standard deviation of magnitude of time-domain signal of body jerk from the accelerometer raw signal  
tBodyGyroMag-mean() : Mean of magnitude of time-domain signal of body acceleration from the gyroscope raw signal  
tBodyGyroMag-std() : Standard deviation of magnitude of time-domain signal of body acceleration from the gyroscope raw signal  
tBodyGyroJerkMag-mean() : Mean of magnitude of time-domain signal of body jerk from the gyroscope raw signal  
tBodyGyroJerkMag-std() : Standard deviation of magnitude of time-domain signal of body jerk from the gyroscope raw signal  
fBodyAcc-mean()-X : Mean of X-direction frequncy-domain signal of body acceleration from the accelerometer raw signal  
fBodyAcc-mean()-Y : Mean of Y-direction frequncy-domain signal of body acceleration from the accelerometer raw signal  
fBodyAcc-mean()-Z : Mean of Z-direction frequncy-domain signal of body acceleration from the accelerometer raw signal  
fBodyAcc-std()-X : Standard deviation of X-direction frequncy-domain signal of body acceleration from the accelerometer raw signal  
fBodyAcc-std()-Y : Standard deviation of Y-direction frequncy-domain signal of body acceleration from the accelerometer raw signal  
fBodyAcc-std()-Z : Standard deviation of Z-direction frequncy-domain signal of body acceleration from the accelerometer raw signal  
fBodyAccJerk-mean()-X : Mean of X-direction frequncy-domain signal of body jerk from the accelerometer raw signal  
fBodyAccJerk-mean()-Y : Mean of Y-direction frequncy-domain signal of body jerk from the accelerometer raw signal  
fBodyAccJerk-mean()-Z : Mean of Z-direction frequncy-domain signal of body jerk from the accelerometer raw signal  
fBodyAccJerk-std()-X : Standard deviation of X-direction frequncy-domain signal of body jerk from the accelerometer raw signal  
ActivityLabel : activity performed by subject during measurement. It may take one of the following six values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
Subject : label indicating the person who performed the activity for each window sample. Its range is from 1 to 30.

