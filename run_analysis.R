run_analysis <- function() {
    # make sure that the data is available
    source("make_data_available.R")
    make_data_available()

    # load the train and test data
    subject_train <- read.table("data/train/subject_train.txt")
    print(subject_train)
}
