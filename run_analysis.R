        # Getting and Cleaning Data Course Assignment 22 February 2015
        
        ##Libraries called
        library(downloader)
        library(reshape2)
        
        ##Getting the file, which is a zip file
        
        ###Setting the file location
        
        fileurl_zip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        
        ###Unzipping the files
        
        download.file(fileurl_zip,"Dataset.zip", mode="wb")
        unzip("Dataset.zip")
        
        ###Reading in the necessary files
        
        subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE, header = FALSE)
        X_test <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE, header = FALSE)
        Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", stringsAsFactors = FALSE, header = FALSE)
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE, header = FALSE)
        X_train <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE, header = FALSE)
        Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt", stringsAsFactors = FALSE, header = FALSE)
        features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE, header = FALSE)
        
        ##Preparing the data
        
        ###Dropping an unnecessary column from the features dataset
        features$V1 <- NULL
        
        ###Cleaning up the features dataset to remove problematic characters that could interfere with labelling
        features$V2 <- gsub(",|-", "", features$V2)
        features$V2 <- gsub("\\(", "", features$V2)
        features$V2 <- gsub("\\)", "", features$V2)
        
        ##Labelling the data sets prior to merging
        
        ###Variable (or column) labelling
        names(subject_test) <- "SubjectNumber"
        names(subject_train) <- "SubjectNumber"
        names(Y_test) <- "Activity"
        names(Y_train) <- "Activity"
        
        ###Labelling the X_test and X_train variables using the names in the features dataset
        for (i in 1:nrow(features)) {
                names(X_test)[i]<-features[i, ]
        }
        
        for (i in 1:nrow(features)) {
                names(X_train)[i]<-features[i, ]
        }
        
        ##Merging the data files
        
        ###Merging the test and train sets of data files from their individual files
        data_test <- cbind(subject_test, Y_test, X_test)
        data_train <- cbind(subject_train, Y_train, X_train)
        
        ###Merging the full test and full train data sets
        test_train_merge <- rbind(data_test, data_train)
        
        ##Removing the non-mean and non-std dev columns that aren't needed
        
        ###Starting this process by creating wildcards for mean and std dev variable names
        wild_mean <- glob2rx("*mean*")
        wild_std <- glob2rx("*std*")
        
        ###However, meanFreq variables need to be removed from the list, and need to be identified
        wild_meanFreq <- glob2rx("*Freq*")
        
        ###Creating a list of mean and std dev variables that exist in the data that should be included
        mean_variables <- with(features, features[grep(wild_mean, V2), ])
        std_variables <- with(features, features[grep(wild_std, V2), ])
        
        ###Creating a list of variables that need to be excluded
        meanFreq_variables <- with(features, features[grep(wild_meanFreq, V2), ])
        
        ###Create the list of needed variables (which still includes meanFreq variables)
        needed_variables <- c("SubjectNumber", "Activity", mean_variables, std_variables)
        
        ###Create a final working data file, then remove the unneeded meanFreq variables
        working_data <- test_train_merge[ , which(names(test_train_merge) %in% needed_variables)]
        working_data <- working_data[ , -which(names(working_data) %in% meanFreq_variables)]
        
        ##Labelling the Activity data with more descriptive labels (taken from the activity_labels file)
        
        working_data <- within(working_data, {
                Activity <- gsub(1, "WALKING", Activity)
                Activity <- gsub(2, "WALKING_UPSTAIRS", Activity)
                Activity <- gsub(3, "WALKING_DOWNSTAIRS", Activity)
                Activity <- gsub(4, "SITTING", Activity)
                Activity <- gsub(5, "STANDING", Activity)
                Activity <- gsub(6, "LAYING", Activity)
        })
        
        ##Reshaping the data by SubjectNumber and Activity 
        data_melt <- melt(working_data, id = c("SubjectNumber", "Activity"))
        
        ##Creation of a tidy data set
        tidy_table <- dcast(data_melt, SubjectNumber + Activity ~ variable)
        
        ###Creating a mean of the tidy data set variables as requested by the assignment
        tidy_table_mean <- dcast(data_melt, SubjectNumber + Activity ~ variable, mean)
        
        ##Formatting the output table to make it easier to look at
        format_tidy_table <- format(tidy_table_mean, digits=8, scientific=FALSE, justify='right')
        
        ##Write the final table as output to an external .txt file
        write.table(format_tidy_table, row.name = FALSE, sep ='\t', file = "tidy_table.txt", quote=FALSE)