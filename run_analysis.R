# Assignment for https://class.coursera.org/getdata-003/human_grading

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "dataset.zip"
dataDir <- "UCI HAR Dataset"

# Check if zip file is present, if not download it. Unzip the file unconditionally.
downloadData <- function() {
    if (!file.exists(filename)) {
        download.file(fileurl, dest=filename, method="curl")
    }
    unzip(filename)
}

# Load features names and return a frame with original name and a sanitized name.
loadFeatures <- function() {
    features <- read.table(file.path(dataDir, "features.txt"),
                           sep=" ", colClasses=c("integer", "character"))
    features$cleanNames <- gsub("\\W+", "_",
                                sub("-(std|mean)\\(\\)(.*)", "\\2-\\1", features$V2))
    features$names <- features$V2 
    features[,c("names", "cleanNames")]
}

# Load activity labels after converting to lowercase and to factor
loadActivityLabels <- function() {
    labels <- read.table(file.path(dataDir, "activity_labels.txt"),
                         sep=" ", colClasses=c("integer", "character"),
                         col.names=c("id", "name"))
    labels$name <- factor(tolower(labels$name), levels=tolower(labels$name))
    labels
}

loadData <- function(dir) {
    features <- loadFeatures()
    data_X <- read.table(file.path(dataDir, dir, "X_train.txt"),
                         col.names=features$cleanNames,
                         colClasses=rep("numeric", length(features$cleanNames)))
    data_X
}