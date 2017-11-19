##

library(dplyr)
library(stringr)
library(memisc)

#Setting the Dir to get features

setwd("C:/Users/Portal X/Documents/Data Science Coursera/data/UCI HAR Dataset")


features <- read.table("features.txt")
activity_label <- read.table("activity_labels.txt")
activity_label$V2 <- gsub("_"," ",activity_label$V2)

# Since there are duplicate values in features$V2 combining features$V1 and features$v2 to give unique values to features$V3 which will be used as the header names for the data set

l <- length(features$V2)

for(i in 1:l){features[i,3] <- paste(features[i,1],"-",features[i,2])}

features$V3 <- tolower(features$V3)


# Setting the Dir for importing the  Test Data

setwd("C:/Users/Portal X/Documents/Data Science Coursera/data/UCI HAR Dataset/test")

subject_test <- read.table("subject_test.txt")
x_test<- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
names(x_test) <- features$V3



# Setting the Dir for importing the  Train Data

setwd("C:/Users/Portal X/Documents/Data Science Coursera/data/UCI HAR Dataset/train")

subject_train <- read.table("subject_train.txt")
x_train<- read.table("X_train.txt")
y_train<- read.table("y_train.txt")

names(x_train) <- features$V3

# Merging Train & Test Data Set

data_train_test <- rbind.data.frame(x_train,x_test)

#selecting the columns in "data" related to mean() calculation



data_mean <- dplyr::select(data_train_test,contains("mean()"))

#selecting the columns in "data" related to std() calculation


data_std <- dplyr::select(data_train_test,contains("std()"))

# combining the data_mean and data_std in one data frame

data_mean_std <- cbind.data.frame(data_mean,data_std)


#merging activity label with that data_mean_std

activity_code <-  rbind(y_train,y_test)

data_mean_std <-  cbind.data.frame(data_mean_std,activity_code)
data_mean_std <- dplyr::rename(data_mean_std,"activity_code" = "V1")

#merging subject_test & subject_train to data_mean_std

subject_person_ID <- rbind(subject_train,subject_test)

data_mean_std <- cbind.data.frame(data_mean_std,subject_person_ID)
data_mean_std <- dplyr::rename(data_mean_std,"subject_person_ID" = "V1")


#giving activity_label a descriptive activity names to name the activities in the data set 

activity_label <- dplyr::rename(activity_label, "activity_type" = "V2")
activity_label <- dplyr::rename(activity_label, "activity_code" = "V1")


data_set <- merge(data_mean_std, activity_label,by = "activity_code",all.x=  TRUE)

# Removing the un-necessary column activity_code for the data_set resulting from above

data_set <- dplyr::select(data_set,-activity_code)

#Appropriately labeling the data set with descriptive variable names. 

name_list <- names(data_set)

name_list <- gsub("_"," ",name_list)
name_list <- gsub("-"," ",name_list)
name_list <- gsub("[()]","",name_list)

name_list <- str_to_title(name_list)


name_list <-sub("[-]","",name_list)

name_list <-sub("[0-9]","",name_list)
name_list <-sub("[0-9]","",name_list)
name_list <-sub("[0-9]","",name_list)
name_list <-sub("[0-9]","",name_list)
name_list <-sub("[0-9]","",name_list)

name_list <-sub("bodybody","body",name_list)
name_list <-sub("body","Body",name_list)

name_list <-sub("gyro","Gyro",name_list)

name_list <-sub("Std","StandardDev",name_list)
name_list <-sub("mean","Mean",name_list)
name_list <-sub("gravity","Gravity",name_list)
name_list <-sub("acc","Acc",name_list)
name_list <-sub("jerk","Jerk",name_list)
name_list <-sub("mag","Mag",name_list)

name_list <-sub("TBody","TimeDomBody",name_list)
name_list <-sub("FBody","FreqDomBody",name_list)
name_list <-sub("TGravity","TimeDomGravity",name_list)

name_list <-trimws(name_list,which = "both")

name_list <-sub("X$","XAxis",name_list)
name_list <-sub("Y$","YAxis",name_list)
name_list <-sub("Z$","ZAxis",name_list)
name_list <- gsub(" ","",name_list)

names(data_set) <- name_list


# Setp 5 : Creating a second data set from  the above resulting data set with average of each activity and subject

new_data_mean <- data_set %>% group_by(ActivityType,SubjectPersonId) %>% summarise_each(funs = "mean")

names(new_data_mean) <- sub("Time","AvgerageOfTime",names(new_data_mean))

names(new_data_mean) <- sub("Freq","AvgerageOfFreq",names(new_data_mean))


setwd("C:/Users/Portal X/Documents/Data Science Coursera/data/UCI HAR Dataset")

write.table(new_data_mean,"TidyData.txt",row.names = FALSE)




# Generating a Code Book for the tidy data set created above


setwd("C:/Users/Portal X/Documents/Data Science Coursera/data/UCI HAR Dataset")

#code_book <- codebook(new_data_mean)
























