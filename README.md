## Introduction

This code does download and read the 'Human Activity Recognition Using Smartphones Data Set'. As stated in the exercise description, there is a file called 'run_analysis.R' that needs to be sourced and executed.

## Data management

The data is supposed to be in a 'data' sub folder of the project. If that is not the case, it will get downloaded and unzipped automatically. I decided to copy all files inside the 'UCI HAR Dataset' folder directly into the 'data' folder. This just removes a folder level for shorter file paths in the code.

## Details

Once the data is available, the script will load the data and merge everything as requested in the exercise. Meaningful names will be set on the merged data set. Only mean and standard deviation measurements are considered. Finally, a tidy data set with the means of all measurements by activity and by subject is generated.
