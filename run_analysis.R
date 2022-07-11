# This will load the test and train data, combine them and extract all mean
# and std measurements. Some additional cleaning is applied to have explicit
# and meaningful names.

run_analysis <- function() {
    # load the mandatory packages
    library(dplyr)

    # make sure that the data is available
    source("make_data_available.R")
    make_data_available()

    # load the global data
    activity_labels <- read.table("data/activity_labels.txt")
    activity_labels <- setNames(activity_labels, c("id", "activitylabel"))

    features <- read.table("data/features.txt")
    features_tbl <- as_tibble(features)
    features_tbl <- setNames(features_tbl, c("id", "feature_name"))

    # keep only 'mean' and 'std' measurements
    filtered_features <- filter(features_tbl, grepl("mean|std", feature_name))

    # load the train and test data
    subject_train <- read.table("data/train/subject_train.txt")
    X_train <- read.table("data/train/X_train.txt")
    y_train <- read.table("data/train/y_train.txt")
    subject_test <- read.table("data/test/subject_test.txt")
    X_test <- read.table("data/test/X_test.txt")
    y_test <- read.table("data/test/y_test.txt")

    # merge train and test data
    subjects <- rbind(subject_train, subject_test)
    activities <- rbind(y_train, y_test)
    measures_raw <- rbind(X_train, X_test)

    # extract only the 'mean' and 'std' measurements and name them accordingly
    measures_filtered <- measures_raw[,filtered_features$id]
    measures <- setNames(measures_filtered, filtered_features$feature_name)

    # build the data set by starting with the merged subjects
    data <- as_tibble(subjects)

    # add the activities and set meaningful column names
    data <- cbind(data, activities)
    data <- setNames(data, c("subjectid", "activityid"))

    # merge that with the activity labels to get human readable activity labels
    data <- merge(data, activity_labels, by.x = "activityid", by.y = "id")

    # add the measures
    data <- cbind(data, measures)

    # --------------------------------------------------------------------------
    # create the tidy data set
    tidy_data <- group_by(data, activitylabel, subjectid)
    tidy_data_summarized <- summarize_all(tidy_data, mean)

    write.table(tidy_data_summarized, "data/tidy_dataset.txt", row.names = FALSE)

    tidy_data_summarized
}
