## Author : Abhishek Katyal

## Date : 19-Nov-2017


## Project Discription


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Collection Of RAW Data


The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

## Content

Codebook.Rmd : Process/Transformation performed on RAW data to get the TidyData, the Discription & Statitcs of the measures in the TidyData Set.
run_analysis.R : The R Script that generates the TidyData Set by performing transformation/processing the RAW Data.
generate_codebook.R : Generates the Discription & Statitcs of the measures in the TidyData Set.


## Process

The RAW data was downloaded from the 
URL : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Steps Involved in creating the TidyData.txt :

Step 1:loaded the necessary packages for running the script

Step 2:Downloaded the RAW data from the URL provided above

Step 3:Loaded the features.txt & activity_labels.txt on R 

Step 4:In the activity lable values replaced the "_" with " "

Step 5:Since there are duplicate feature names present in features.txt combined the rowid(V1) and the fearure values(V2) to get unique features

Step 6: Converted all the values of features to lower case

Step 7:Set the working directory to load test files on R Objects

Step 8:loaded the subject_test.txt,X_test.txt,y_test.txt,y_test.txt to R Objects

Step 9:Assigned the column names to x_test from the new feature values got from Step:5

Step 10:Set the working directory to load train files on R Objects

Step 11:loaded the subject_train.txt,X_train.txt,y_train.txt,y_train.txt to R Objects

Step 12:Assigned the column names to x_train from the new feature values got from Step:5

Step 13:Merged(row bind) two data set x_test from Step 9 and x_train from Step 12

Step 14:Selecting only columns from the data set from Step 13 containing "mean()" 

Step 15:Selecting only columns from the data set from Step 13 containing "std()" 

Step 16:Merging(Column bind) the resultant data set of Step 14 & 15

Step 17:Row Binding the y_test and y_train (these are the activity label code)

Step 18:Column Binded the Result of step 17 with that of Step 16

Step 19:Renamed the newly added column in Step 18 to "activity_code"

Step 20:Row Binding the subject_test & subject_train 

Step 21:Column binding the resultant of Step 20 with that of the resultant of Step 19

Step 22:Renamed the newly added column in Step 21 to "subject_person_ID"

Step 23:Renaming the column names of activity_lable to V1 to "activity_code" & V2 to "activity_type"

Step 24:Merging the resultant data set of Step 22 with that of activity_lable by left outer Join, where joining 
column is  "activity_code" and the driving object is the resultant data set of step 22

Step 25:Removing the activity_code column from the resultant data set of Step 24 as it is not required

Step 26:Renaming the column names of the resultant data sset of Step 25 to more discriptive names and removing symbols and digits

Step 27:Extracting the column names of the resultant data set in step 25 into an object name_list

Step 28:Replacing "_" from name_list to " "

Step 29:Replacing "-" from name_list to " "

Step 30:Replacing "()" from name_list to ""

Step 31:Converting all the first alphabet of the words in the name_list to capital

Step 32:Replacing "-" from name_list to ""

Step 33:Removing all the digits from the column names in name_list

Step 34:Replacing the duplicate bodybody column name content in name_list to Body

Step 35:Replacing the body column name content in name_list to Body

Step 36:Replaing the gyro column name content in name_list to Gyro

Step 36:Replacing the std column name content in name_list to StandardDev

Step 37:Replacing the mean column name content in name_list to Mean

Step 38:Replacing the gravity column name content in name_list to Gravity

Step 39:Replacing the acc column name content in name_list to Acc

Step 40:Replacing the jerk column name content in name_list to Jerk

Step 41:Replacing the mag column name content in name_list to Mag

Step 42:Replacing the Tbody column name content in name_list to TimeDomBody

Step 43:Replacing the Fbody column name content in name_list to FreqDomBody

Step 44:Replacing the TGravity column name content in name_list to TimeDomGravity

Step 45:Removing both trailing and leading white spaces

Step 46:Replacing column names ending with x with XAxis

Step 47:Replacing column names ending with y with YAxis

Step 48:Replacing column names ending with z with ZAxis

Step 49:Replacing all " " with "" in name_list

Step 50:Assigining this resultant column names "name_list" to the names or column names of the                 resultant data set of Step 25

Step 51: Creating the TidyData Set by grouping the result of Step 50 by Activity Type & Subject and the getting the average of the rest of the column values

Step 52:Adding the AverageOf in front of all the column names of the result of Step 51 except Activity Type and Subject

## Abbreviation used in the column names of the TidyData Set

1.TimeDom = Time Domain Signals values
2.FreqDom = Frequency Domain Signal Values
3.Acc = Acceleration
4.Mag = Magnitude
5.Gyro = Gyroscope
6.StandardDev = Standard Deviation

eg.AvgerageOfTimeDomBodyGyroStandardDevZAxis = Average Of Time Domain Signal of the Body movement picked up by the Gyroscope sensor's standard deviation in the Z Axis Direction


