# Read CSV into R
MyData <- read.csv(file="/Users/thelle/Google Drive/Projects/Stock Analysis_Dual share class/twinstock_github/data/allTwins.csv", header=TRUE, sep=",")

#Getting last column for Maersk B Open value:

#Getting last row
latestValues <- tail(MyData, 1)

# Last Maersk B Open value (Column 3 = Maersk B Open):
nonNumeric = latestValues [3]

#GettingMaersk B Open value as numeric value:
as.numeric(nonNumeric)

#Calulating delta (close value) for latest Maersk A & B

delta <- (as.numeric(latestValues[6])-as.numeric(latestValues[12]))/as.numeric(latestValues[6])
delta

#Using for loop to print all deltas:

for(i in seq(from=6, to=255, by=12)){
  print((as.numeric(latestValues[i])-as.numeric(latestValues[i+6]))/as.numeric(latestValues[i]))
}