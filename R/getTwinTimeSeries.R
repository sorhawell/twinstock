twins.df = read.csv("./data/stockPairs2.csv",stringsAsFactors = FALSE)

require("quantmod")
getSymbols(c("CARL-A.CO", "CARL-B.CO"), src = "av", api.key = "XGX6A34XQQX6I2YE")
out = with(list(), {
  getSymbols(twins.df$ticker[1:2],src="av",api.key="XGX6A34XQQX6I2YE")
  mget(ls())
})


alreadyDownloaded = gsub(".csv","",list.files("./data/symbols/"))
tickersToDownload = twins.df$ticker[!twins.df$ticker%in%alreadyDownloaded]


out = lapply(tickersToDownload, function(this.ticker) {
  print(this.ticker)
  blop = tryCatch({
    out = with(list(), {
      getSymbols(this.ticker,src="yahoo")
      mget(ls())
    })
  }, error = function(e) NULL )
  df = as.data.frame(blop[[1]])
  if(!is.null(blop)) write.table(df,file=paste0("./data/symbols/",names(blop)[1]),col.names=TRUE)
  print(length(blop))
  Sys.sleep(.5)
  blop
})

alreadyDownloaded = gsub(".csv","",list.files("./data/symbols/"))
twins.df$hasData = twins.df$ticker%in%alreadyDownloaded
sum(twins.df$hasData)

splitTwin = split(twins.df[twins.df$hasData,],twins.df$stockNumber[twins.df$hasData])
hasTwoRows = sapply(splitTwin,nrow)==2
splitTwin=splitTwin[hasTwoRows]
splitTwin.df = do.call(rbind,splitTwin)


data.list = lapply(paste0("./data/symbols/",splitTwin.df$ticker),read.table,stringsAsFactors=FALSE)
row.names(data.list[[1]])
allObservedDates = sort(unique(unlist(lapply(data.list,row.names))))

out = lapply(data.list, function(df) {
  m = matrix(NA,nrow=length(allObservedDates),ncol=ncol(df))
  dfm = data.frame(m)
  dfm[allObservedDates%in%rownames(df),] = df
  names(dfm) = names(df)
  dfm$X=NULL
  dfm
})
#names(out) = splitTwin.df$ticker
out[[1]]
all = do.call(cbind,c(list(time=allObservedDates),out))
write.csv(all,"data/allTwins.csv")
View(all)


quantmod::Delt(
  out[[1]]$MAERSK.B.CO.Open,
  out[[1]]$MAERSK.B.CO.Close)


               
