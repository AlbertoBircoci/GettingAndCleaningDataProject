# 0) Packages ------------------------------------------------------------------
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr", repos = "https://cloud.r-project.org")
}
library(dplyr)

# 1) Paths and basic checks ----------------------------------------------------
data_dir <- "UCI HAR Dataset"

required_files <- c(
  file.path(data_dir, "features.txt"),
  file.path(data_dir, "activity_labels.txt"),
  file.path(data_dir, "train", "X_train.txt"),
  file.path(data_dir, "train", "y_train.txt"),
  file.path(data_dir, "train", "subject_train.txt"),
  file.path(data_dir, "test",  "X_test.txt"),
  file.path(data_dir, "test",  "y_test.txt"),
  file.path(data_dir, "test",  "subject_test.txt")
)
missing <- required_files[!file.exists(required_files)]
if (length(missing) > 0) {
  stop("Some required files are missing:\n", paste(missing, collapse = "\n"))
}

# 2) Read metadata (features + activity labels) --------------------------------
features <- read.table(file.path(data_dir, "features.txt"),
                       col.names = c("index", "feature"),
                       stringsAsFactors = FALSE)

activity_labels <- read.table(file.path(data_dir, "activity_labels.txt"),
                              col.names = c("code", "activity"),
                              stringsAsFactors = FALSE)

# 3) Helper to read a split (train/test) ---------------------------------------
read_split <- function(split = c("train", "test")) {
  split <- match.arg(split)
  
  # X_* contains 561 features (columns)
  X <- read.table(file.path(data_dir, split, paste0("X_", split, ".txt")),
                  check.names = FALSE, stringsAsFactors = FALSE)
  # Use the exact feature names as provided (avoid R's syntactic renaming)
  colnames(X) <- features$feature
  
  # y_* contains the activity code per row
  y <- read.table(file.path(data_dir, split, paste0("y_", split, ".txt")),
                  col.names = "activity_code", stringsAsFactors = FALSE)
  
  # subject_* contains the subject ID per row
  s <- read.table(file.path(data_dir, split, paste0("subject_", split, ".txt")),
                  col.names = "subject", stringsAsFactors = FALSE)
  
  list(X = X, y = y, subject = s)
}

tr <- read_split("train")
te <- read_split("test")

# 4) Merge training and test sets ----------------------------------------------
X_all        <- rbind(tr$X, te$X)
subjects_all <- rbind(tr$subject, te$subject)
y_all        <- rbind(tr$y, te$y)

# 5) Keep ONLY mean() and std() measurements (exclude meanFreq(), etc.) --------
sel_idx <- grepl("-(mean|std)\\(\\)", features$feature)  # exact mean()/std()
X_keep  <- X_all[, sel_idx]

# Sanity check: UCI HAR has 66 mean()/std() features
if (ncol(X_keep) != 66) {
  warning("Expected 66 mean()/std() variables, found ", ncol(X_keep),
          ". Please verify the selection/feature names.")
}

# 6) Combine subject + activity + selected features ----------------------------
data <- cbind(subjects_all, y_all, X_keep)

# Map activity codes to descriptive names
data <- merge(data, activity_labels, by.x = "activity_code", by.y = "code", all.x = TRUE)

# Reorder columns: subject, activity, then measurements; drop activity_code
data <- data %>%
  select(subject, activity, everything(), -activity_code)

# 7) Clean up variable names (descriptive, human-readable) ---------------------
clean_names <- function(nms) {
  nms %>%
    gsub("\\(\\)", "", ., perl = TRUE) %>%      # remove parentheses
    gsub("-", "", ., perl = TRUE) %>%         # remove dashes
    gsub("^t", "Time", ., perl = TRUE) %>%    # t -> Time
    gsub("^f", "Frequency", ., perl = TRUE) %>%
    gsub("Acc", "Accelerometer", ., perl = TRUE) %>%
    gsub("Gyro", "Gyroscope", ., perl = TRUE) %>%
    gsub("Mag", "Magnitude", ., perl = TRUE) %>%
    gsub("BodyBody", "Body", ., perl = TRUE) %>%
    gsub("mean", "Mean", ., fixed = TRUE) %>%
    gsub("std", "STD",  ., fixed = TRUE)
}
names(data) <- c("subject", "activity", clean_names(names(data)[-(1:2)]))

# Ensure unique names in case any duplicates arise after cleaning
names(data) <- make.unique(names(data))

# 8) Create the tidy dataset: average for each (subject, activity) -------------
tidy <- data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")


# Sanity check: 30 subjects x 6 activities = 180 rows expected
if (nrow(tidy) != 30 * 6) {
  warning("Expected 180 rows in the tidy dataset, found ", nrow(tidy),
          ". Check merges/grouping.")
}

# 9) Write final output ---------------------------------------------------------
out_path <- "tidy_data.txt"
write.table(tidy, file = out_path, row.names = FALSE)
message(">> Done! Wrote: ", normalizePath(out_path))




            