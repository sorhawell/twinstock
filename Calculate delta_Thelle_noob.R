# Get quantmod
if (!require("quantmod")) {
  install.packages("quantmod")
  library(quantmod)
}

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

#Using for loop to print all deltas: (need to fix CSV to only contain two pairs in same currency)

for(i in seq(from=6, to=255, by=12)){
  print((as.numeric(latestValues[i])-as.numeric(latestValues[i+6]))/as.numeric(latestValues[i]))
}

#Adding names for shares to deltas print
colnames(latestValues)[6]

for(i in seq(from=6, to=255, by=12)){
  print(colnames(latestValues)[i])
  print((as.numeric(latestValues[i])-as.numeric(latestValues[i+6]))/as.numeric(latestValues[i]))
}

#Using for loop to append latest deltas to a vector - LOOP NOT WORKING YET - NOOB NOOB
latestDeltaList = list()
for (j in seq(from=1, to=24, by=1)){
  for(i in seq(from=6, to=255, by=12)){
    dat <- (as.numeric(latestValues[i])-as.numeric(latestValues[i+6]))/as.numeric(latestValues[i])
    latestDeltaList[[j]] <- dat #adding j counter for adding data 
  }
}

latestDeltaList


#Calculating delta in bulk using quantmod package -- pct fucntion in r might also do the job..
Stock.Open <- c(102.25,102.87,102.25,100.87,103.44,103.87,103.00)
Stock.Close <- c(102.12,102.62,100.12,103.00,103.87,103.12,105.12)

Delt(Stock.Open)                    #one period pct. price change
Delt(Stock.Open,k=1)                #same
Delt(Stock.Open,type='arithmetic')  #using arithmetic differences

Delt(Stock.Open,Stock.Close)        #Open to Close pct. change
Delt(Stock.Open,Stock.Close,k=0:2)  #...for 0,1, and 2 periods