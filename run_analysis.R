library("data.table")

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("~UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("~UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("~UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("~UCI HAR Dataset/test/y_test.txt", col.names = "code")



subject_train <- read.table("~UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("~UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt", col.names = "code")

final1 <- cbind(rbind(subject_test, subject_train), rbind(X_test, X_train), rbind(y_test, y_train))

final <- final1[,grep(".*Mean.*|.*Std.*", names(final), ignore.case=TRUE)]

activities <- read.table("~UCI HAR Dataset/train/y_train.txt")
final[, 2] <- activities[final[,2], 2]

finalset <- aggregate(list(final[1], final[2]), mean)

write.table(finalset, "output.txt", row.name=FALSE)