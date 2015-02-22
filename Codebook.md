#Getting and Cleaning Data Course Assignment
###22 February 2015

This codebook has been prepared as part of the Coursera Getting and Cleaning Data course.

The final data output saved within this folder consists of 180 observations and 68 variables.
One record has been recorded per test for each subject.

##Original Data
This data was developed based on an original dataset that can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The original README.txt for that dataset describes the purpose of the data collected: experiments 
had been carried out with a group of 30 volunteers within an age bracket of 19-48 years, with each 
person performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, 
LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

The data collected was the result of these experiments. The obtained dataset had been randomly 
partitioned into two sets, where 70% of the volunteers was selected for generating the training 
data and 30% the test data. 

The features_info.txt, features.txt and activity_labels.txt all contain important information 
about the original dataset.

##Current Data
The data within this folder is a merged and tidied dataset based on the requirements of the
Getting and Cleaning Data assignment.

The course assignment asked that one R script called run_analysis.R be created to:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of 
each variable for each activity and each subject.

At the end of this process a file called tiny_table.txt was the output of the mean of each 
variable for each activity and each subject. It was saved in a tab-delineated format.

The analysis_run.R file contains the steps used to merge and tidy the data. It was created
using R version 3.1.2.

##Data Development and Transformations
The following files were used to develop this dataset from the original location:

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'train/subject_train.txt': Each row identifies the subject who performed the activity 
for each window sample. Its range is from 1 to 30. 

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

* 'test/subject_test.txt': Each row identifies the subject who performed the activity 
for each window sample. Its range is from 1 to 30. 

* 'features.txt': The list of variable names used by the original data files.

The steps taken with these data files (as outlined in the analysis_run.R comments):

1. Call R libraries of packages to be used. These were "downloader" and "reshape2".
This process will not work if these packages aren't installed prior to starting analysis_run.R.

2. The location of the original data set is used to download and unzip it.

3. The key files (indicated above) are called into R using the same file names.

4. The raw data was prepared.

  *'features' had an unnecessary column deleted and the variable names were cleaned of 
problematic characters that could interfere with labelling.

  * The raw datasets were labelled to prior to merging.

  * The "subject_train" and "subject_test" variables saw their column labeled as "SubjectNumber".

  * The features variable name list was used to title the X_test and X_train data files.

 * The Y_test and Y_train variables were titled "Activity", since they represented the test
set.

5. The data files were merged
  * First the data_test data frame was merged from subject_test, Y_test, X_test, then the
same was done with subject_train, Y_train and X_train to create the data_train frame.
  * Then the data_test and data_train files were merged together.

6. Given that only the mean and standard deviation variables were wanted, these variables
were located in the data set by the use of wildcard functions.
  * However, the wildcard function for mean also returned meanFreq variables, which aren't
needed in this analysis. 
  * As such, the variable mean_variables and std_variables were created to highlight only the required 
variables.
  * The needed_variables vector was used to pull together a list of required variables in the final data set,
including SubjectNumber and Activity, plus the mean and standard deviation vectors.

7. The merged file was filtered to ensure that only the needed vectors were included in it.
  * This saw the meanFreq vectors removed from the dataset.

8. The Activity vector was named to ensure that they had descriptive names (as requested).
  * These were based on the activity_labels.txt file: 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS
4 SITTING, 5 STANDING, 6 LAYING.

9. The working data set was reshaped to create a more focused data set that combined subject number
and activity (i.e. "SubjectNumber" and "Activity"). This put the dataset in a long format. 

10. This data was then cast into its final tidy format, so that each subject's activity results
are shown as a separate row. 

11. The mean results of this tidy dataset were then created (as requested by the assignment).

12. The output from the tidy dataset was then formatted for better on-screen appearance and for
inclusion of GitHub.

13. The final output was saved as "tidy_table.txt" and is in a tab-delineated format. 

## Current Variables
Two key variables within the final tidy data set is:

 SubjectNumber - The unique subject number, ranging from 1 to 30. This vector is an integer.
 Activity - The activity the results were taken from. Each subject did each activity once. 
 This variable is a character vector. 
 
 As described in the original features_info.txt:
 
 "The features selected for this database come from the accelerometer and gyroscope 3-axial raw 
 signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were 
 captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd 
 order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the 
 acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ 
 and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

 Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk 
 signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional 
 signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, 
 tBodyGyroMag, tBodyGyroJerkMag). 

 Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, 
 fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' 
 to indicate frequency domain signals). 

 These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."

Of these outputs, only the mean and standard deviation of these measures have been included within
the dataset. All these vectors are numeric and have been standardised, so range between -1 and 1. The list of these variables are:
 
 tBodyAccmeanX 
 tBodyAccmeanY   
 tBodyAccmeanZ  
 tBodyAccstdX  
 tBodyAccstdY  
 tBodyAccstdZ  
 tGravityAccmeanX   
 tGravityAccmeanY  
 tGravityAccmeanZ   
 tGravityAccstdX   
 tGravityAccstdY   
 tGravityAccstdZ   
 tBodyAccJerkmeanX  
 tBodyAccJerkmeanY  
 tBodyAccJerkmeanZ  
 tBodyAccJerkstdX   
 tBodyAccJerkstdY   
 tBodyAccJerkstdZ  
 tBodyGyromeanX   
 tBodyGyromeanY   
 tBodyGyromeanZ   
 tBodyGyrostdX   
 tBodyGyrostdY  
 tBodyGyrostdZ  
 tBodyGyroJerkmeanX  
 tBodyGyroJerkmeanY  
 tBodyGyroJerkmeanZ  
 tBodyGyroJerkstdX  
 tBodyGyroJerkstdY  
 tBodyGyroJerkstdZ  
 tBodyAccMagmean   
 tBodyAccMagstd   
 tGravityAccMagmean  
 tGravityAccMagstd  
 tBodyAccJerkMagmean  
 tBodyAccJerkMagstd  
 tBodyGyroMagmean   
 tBodyGyroMagstd   
 tBodyGyroJerkMagmean  
 tBodyGyroJerkMagstd  
 fBodyAccmeanX  
 fBodyAccmeanY   
 fBodyAccmeanZ  
 fBodyAccstdX  
 fBodyAccstdY  
 fBodyAccstdZ  
 fBodyAccJerkmeanX  
 fBodyAccJerkmeanY  
 fBodyAccJerkmeanZ  
 fBodyAccJerkstdX  
 fBodyAccJerkstdY   
 fBodyAccJerkstdZ   
 fBodyGyromeanX   
 fBodyGyromeanY   
 fBodyGyromeanZ   
 fBodyGyrostdX  
 fBodyGyrostdY  
 fBodyGyrostdZ   
 fBodyAccMagmean   
 fBodyAccMagstd   
 fBodyBodyAccJerkMagmean  
 fBodyBodyAccJerkMagstd  
 fBodyBodyGyroMagmean  
 fBodyBodyGyroMagstd  
 fBodyBodyGyroJerkMagmean  
 fBodyBodyGyroJerkMagstd 
 
 ### Closing Note
 
 The tidy_table.txt data set is shown in a wide format in order to leave it more easily readable.
 
 ##### Thanks!
