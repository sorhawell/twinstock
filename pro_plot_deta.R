rm(list=ls())

require("quantmod")


# Read CSV into R
allTwins <- read.csv(file="./data/allTwins.csv", header=TRUE, sep=",",encoding = "UTF-8")
twins.df = read.csv("./data/stockPairs2.csv",stringsAsFactors = FALSE,encoding = "UTF-8")
alreadyDownloaded = gsub(".csv","",list.files("./data/symbols/"))
twins.df$hasData = twins.df$ticker%in%alreadyDownloaded

twins.df.list = by(twins.df,INDICES = twins.df$stockNumber,data.frame)
#x = twins.df.list$`16`
# hasAtleastTwo = unlist(lapply(twins.df.list, function(x) sum(x$hasData)>=2))
# twins.valid.df.list = twins.df.list[hasAtleastTwo]
# View(twins.valid.df.list[[1]])

twins.df$dataFile = alreadyDownloaded[match(twins.df$ticker,alreadyDownloaded)]
x = twins.df$dataFile[1]
twins.df$Data = lapply(twins.df$dataFile, function(x) {
  print(x)
  if(is.na(x)) NA else read.table(paste0("./data/symbols/",x),header=T,sep=" ")
  })

nameList = tapply(twins.df$ticker ,twins.df$stockNumber,FUN=c)
hasData = tapply(twins.df$hasData,twins.df$stockNumber,function(x) sum(x)>=2)
nameList = nameList[hasData]
has10Obs = lapply(nameList,function(x) {
  sapply(x, function(xx) {
    nrow(twins.df$Data[[match(xx,twins.df$ticker)]])>=10
  })
})
allHas10Obs = sapply(has10Obs,all)
nameList = nameList[allHas10Obs]

x = nameList[[3]]
allTwins.list = lapply(nameList, function(x) {
  ind1 = match(x[1],twins.df$ticker)
  ind2 = match(x[2],twins.df$ticker)
  print(twins.df$ticker[ind1])
  a.df = twins.df$Data[[ind1]]
  b.df = twins.df$Data[[ind2]]
  nrow(a.df)
  nrow(b.df)
  uni =sort(unique(c(row.names(a.df),row.names(b.df))))
  a.df = a.df[match(uni,row.names(a.df)),]
  b.df = b.df[match(uni,row.names(b.df)),]
  row.names(a.df) = uni
  row.names(b.df) = uni
  #matchrow.ind = matchrow.ind[!is.na(matchrow.ind)]
  nrow(a.df)
  nrow(b.df)
  names(a.df) = c("Open", "High", "Low", "Close", "Volume", "Adjusted")
  names(b.df) = c("Open", "High", "Low", "Close", "Volume", "Adjusted")
  
  out = list(a.df = a.df,b.df = b.df)
  return(out)
})
names(allTwins.list) =  sapply(nameList,function(x) x[1])


## write you own favorite function here
aTwin = allTwins.list[[2]]
allDelts = lapply(allTwins.list, function(aTwin) {
  out = quantmod::Delt(aTwin$a.df$Close,aTwin$b.df$Close)[,1]
  names(out) = row.names(aTwin$a.df)
  out
})


par(mfrow=c(3,3))
for(i in 1:9) {
  j=names(nameList)[i]
  nameAB= paste(nameList[[i]],collapse="_")
  if(i==1) plot(as.POSIXct(names(allDelts[[i]])),allDelts[[i]],
       main=nameAB,ylab="delts",type="l", ylim=c(-.2,.2))
}



