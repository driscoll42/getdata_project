# Assignment for https://class.coursera.org/getdata-003/human_grading

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "dataset.zip"
dataDir <- "UCI HAR Dataset"

# Check if zip file is present, if not download it. Unzip the file
# unconditionally.
downloadData <- function() {
    if (!file.exists(filename)) {
        download.file(fileurl, dest=filename, method="curl")
    }
    unzip(filename)
}

# Load features names and return a frame with original name (names) and a
# sanitized name (cleanNames)
loadFeatures <- function() {
    features <- read.table(file.path(dataDir, "features.txt"),
                           sep=" ", colClasses=c("integer", "character"))
    features$cleanNames <- gsub("\\W+", "_",
                                sub("-(std|mean)\\(\\)(.*)", "\\2-\\1",
                                    features$V2))
    features$names <- features$V2 
    features[,c("names", "cleanNames")]
}

# Load activity labels as a factor after converting to lowercase.
loadActivityLabels <- function() {
    labels <- read.table(file.path(dataDir, "activity_labels.txt"),
                         sep=" ", colClasses=c("integer", "character"),
                         col.names=c("id", "name"))
    labels$name <- factor(tolower(labels$name), levels=tolower(labels$name))
    labels
}

# Load the feature data under directory `dir` along with the subject id and
# activity and return the data as a frame.
# subject_*.txt, y_*.txt and X_*.txt are expected to have the same number of 
# rows.
loadDataSet <- function(dir, features = loadFeatures(), labels = loadActivityLabels()) {
    subjects <- read.table(file.path(dataDir, dir, paste0("subject_", dir, ".txt")))
    subjects$subject_id <- subjects$V1
    
    activities <- read.table(file.path(dataDir, dir, paste0("y_", dir, ".txt")))
    activities$activity <- labels$name[activities$V1]
    activities

    data_X <- read.table(file.path(dataDir, dir, paste0("X_", dir, ".txt")),
                         col.names=features$cleanNames,
                         colClasses=rep("numeric", length(features$cleanNames)))
    data_X$subject_id <- subjects$subject_id
    data_X$set <- dir
    data_X$activity <- activities$activity
    
    data_X
}

# Load "train" and "test" data sets and combine them into a single data.frame.
loadAllSets <- function(features) {
    labels <- loadActivityLabels()
    train <- loadDataSet("train", features, labels)
    test <- loadDataSet("test", features, labels)
    rbind(train, test)
}

# Filter some of the features (columns) of the data set and discard the rest.
# Keep the subject_id, set and activity.
filterFeatures <- function(dataSet, features, featureNameRegex) {
    # Extracts only the measurement variables where the identifier matches 
    # the featureNameRegex
    mean_std_cols <- grep(featureNameRegex, features$cleanNames, value = TRUE)
    sorted_vars <- mean_std_cols[sort.list(mean_std_cols)]
    dataSet[,c("subject_id", "set", "activity", sorted_vars)]
}

# This covers requirements 1 to 4 of the assignment:
# 1. "train" and "test" data sets are merged
# 2. only mean and std are extracted
# 3. activities are labeled with names such as "standing"
# 4. each row is labeled with its activity in the activity column.
loadTidySetStep1 <- function() {
    features <- loadFeatures()
    filterFeatures(loadAllSets(features), features, "(_mean|_std)$")
}

# This creates a new data set with the average of each mean variable for each
# activity and each subjet:
#     subject_id,activity,var1_mean,...,varN_mean
# save the data with a header as csv file called
# X_means_by_subject_and_activity.csv.
write_X_means <- function() {
    library(plyr) # for ddply
    features <- loadFeatures()
    dataSet <- filterFeatures(loadAllSets(features), features, "_mean$")
    meansBySubjectActivity <- ddply(dataSet, c("subject_id", "activity"),
                                    function(group) {
                                        sapply(group[,-(1:3)], mean)
                                    })
    write.csv(meansBySubjectActivity, "X_means_by_subject_and_activity.csv",
              row.names=FALSE, quote=FALSE)
    meansBySubjectActivity
}
