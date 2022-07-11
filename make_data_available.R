make_data_available <- function() {
    # check for the 'data' folder
    if (!dir.exists("./data")) {
        dir.create("data")
    }

    # check if the expected content is there
    if (file.exists("./data/test/X_test.txt") &&
        file.exists("./data/test/y_test.txt") &&
        file.exists("./data/test/subject_test.txt") &&
        file.exists("./data/train/X_train.txt") &&
        file.exists("./data/train/y_train.txt") &&
        file.exists("./data/train/subject_train.txt")) {
        return()
    }

    # download the data set
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  "data/dataset.zip")

    # unzip it
    unzip("data/dataset.zip", exdir="./data")

    # remove the zip file
    file.remove("data/dataset.zip")

    # copy the content of the 'UCI HAR Dataset' into the data folder
    file.copy(
        list.files("data/UCI HAR Dataset/", full.names = TRUE),
        "data", recursive = TRUE)

    # delete the empty folder
    unlink("data/UCI HAR Dataset", recursive = TRUE, force = TRUE)
}
