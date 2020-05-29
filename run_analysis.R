library(tidyverse)

#read label data
features <- read_table("features.txt", col_names = F)
activitylabel <- read_table("activity_labels.txt", col_names = F)
activitylabel[, 2] <-
        c("walk", "upstairs", "downstairs", "sit", "stand", "lie")

#read training data
s_train <- read_table("./train/subject_train.txt", col_names = F)
X_train <- read_table("./train/X_train.txt", col_names = F)
y_train <- read_table("./train/y_train.txt", col_names = F)

#read testing data
s_test <- read_table("./test/subject_test.txt", col_names = F)
X_test <- read_table("./test/X_test.txt", col_names = F)
y_test <- read_table("./test/y_test.txt", col_names = F)

#apply column names to training data
names(X_train) <- features$X1
names(y_train) <- "activitynum"
names(s_train) <- "subject"

#apply column names to testing data
names(X_test) <- features$X1
names(y_test) <- "activitynum"
names(s_test) <- "subject"

#combine  training data into a dataframe
train <- cbind(s_train, X_train, y_train)
test <- cbind(s_test, X_test, y_test)
full <- rbind(train, test)
rm(s_train,
   X_train,
   y_train,
   s_test,
   X_test,
   y_test,
   train,
   test)

#define columns wanted
filter <- grep("-mean..$|-std..$", features$X1, value = TRUE)
full <- full[, c("subject", filter, "activitynum")] %>%
        left_join(activitylabel, by = c("activitynum" = "X1")) %>%
        rename(activity = X2) %>%
        select(-activitynum)
rm(activitylabel, features,filter)

##reformat variable names
names(full)[2:19] <- names(full)[2:19] %>%
        str_replace('^(\\d)*\\s', '') %>%
        str_replace('.{2}$', '') %>%
        str_replace_all('Body|Mag', '') %>%
        str_replace("(.*)-(mean)", "\\2\\1") %>%
        str_replace("(.*)-(std)", "\\2\\1")

##create a list of column names as a string for the summarize function
snames <- list()
for (name in names(full)[2:19]) {
        snames <- c(snames, paste0(name, "=mean(", name, ")"))
}
snames <- toString(snames)

tbl_df(full)
means <-
        eval(parse(
                text = paste("summarize(group_by(full, subject,activity),", snames, ")")
        ))
rm(name, snames)
