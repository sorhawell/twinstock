rm(list=ls())
library(data.table)
sl = fread("data/tickers.csv",stringsAsFactors = FALSE,encoding = "UTF-8")
sl = as.data.frame(sl)
ind_B = grep("-B",sl$ticker)
ind_B. = grep("-B\\.",sl$ticker)
ind_B = which(substr(sl$ticker,nchar(sl$ticker)-1,nchar(sl$ticker))=="-B")
all = c(ind_B,ind_B.)
#View(sl[all,])
listTwinShares= lapply(sl$name[all],function(x) {
  sl[sl$name==x,]
})
write.csv(do.call(rbind,listTwinShares),file="./data/blop.csv")

## an then we edited the table manually...

ts2 = read.csv("./data/twinx_manual2.csv",encoding = "UTF-8",stringsAsFactors = FALSE)
ts2 = ts2[ts2$twin!="",]

ts2.list = base::split(ts2,f=ts2$name)
ts2.list = lapply(ts2.list,function(x) split(x,f=x$exch))
ts2.list = do.call(c,lapply(ts2.list,function(x) if(class(x)=="data.frame") list(x) else x))
stockPairs.df = do.call(rbind,ts2.list)
stockPairs.df$stockNumber = unlist(lapply(1:length(ts2.list),rep,2))
write.csv(x = stockPairs.df,"./data/stockPairs2.csv",fileEncoding = "UTF-8")

# 
# 
# x = listTwinShares[[2]]
# twinSharesList = lapply(listTwinShares,function(x) {
#   print(x$name[1])
#   if(is.null(x) || nchar(x$name)==0) return("")
#   twinShareNames = unlist(lapply(x$ticker,function(i) {
#     others = x$ticker[x$ticker!=i]
#     index = agrep(i,others,max.distance = list(sub=1,cost=1,all=1,ins=0,del=0))
#     others[index]
#   }))
#   data.frame(
#   sharesJoined = paste(twinShareNames,coll=","),
#   shareName = x$name[1],
#   exch=x$exch [1]
#   )
# })
# 
# View(do.call(rbind,twinSharesList))
# 
# 
# 
# excluded = tickers[ind_B[!ind_B %in% all]]
# 
# agrep
# 
# #View(excluded)
# 
# 
# 
# 
# twinTickers = tickers[all]
# 
# ncharB = regexpr("-B",twinTickers)
# baseNameTicker = substr(twinTickers,1,ncharB-1)
# allNames = lapply(baseNameTicker,function(this.basename) {
#   this.compar = substr(tickers,1,nchar(this.basename))
#   tickers[(this.compar == this.basename)]
# })
# allNames
# 
# twinTickers
