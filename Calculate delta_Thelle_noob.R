# Read CSV into R
MyData <- read.csv(file="/Users/thelle/Google Drive/Projects/Stock Analysis_Dual share class/twinstock_github/data/allTwins.csv", header=TRUE, sep=",")

#Getting last column for Maersk B Open value:

#Getting last row
latestValues <- tail(MyData, 1)
# Last Maersk B Open value (Column 3 = Maersk B Open):
nonNumeric = latestValues [3]
#Getting value as numeric value:
as.numeric(nonNumeric)