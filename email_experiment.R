# Get quantmod
if (!require("quantmod")) {
  install.packages("quantmod")
  library(quantmod)
}
# jsonlite is need for Alpha Vantage data
install.packages("jsonlite")

# Let's get stock data. We use the quantmod function getSymbols, and pass a string as a first argument to
# identify the desired ticker symbol, pass 'yahoo' to src for Yahoo!Finance (and from and to specify date ranges)

# The default behavior for getSymbols is to load data directly into the global environment

# Data source: src = "av" is Alpha Vantage data: https://www.alphavantage.co/
# Data source: src = "yahoo" is Yahoo Finance 

# Carlsberg
getSymbols(c("CARL-A.CO", "CARL-B.CO"), src = "av", api.key = "XGX6A34XQQX6I2YE")
#Plot Delta between A & B shares:
plot((Delt(`CARL-A.CO`[, "CARL-A.CO.Close"], `CARL-B.CO`[, "CARL-B.CO.Close"], type='arithmetic'))*100, main="Delta (pct) Carlsberg B vs Carlsberg A")



# Finding close value for last row (newest data) of Carlsberg A:
LatestCloseValueCarlbergA = as.numeric(tail(`CARL-A.CO`[, "CARL-A.CO.Close"], n=1))

LatestCloseValueCarlbergB = as.numeric(tail(`CARL-B.CO`[, "CARL-B.CO.Close"], n=1))

#Finding delta between Carlsberg A & Carlsberg B
LatestDeltaCarlsberg = as.numeric((LatestCloseValueCarlbergB - LatestCloseValueCarlbergA) / LatestCloseValueCarlbergB)
LatestDeltaCarlsberg

png('Carlsberg.png')
# make plot
plot((Delt(`CARL-A.CO`[, "CARL-A.CO.Close"], `CARL-B.CO`[, "CARL-B.CO.Close"], type='arithmetic'))*100, main="Delta (pct) Carlsberg B vs Carlsberg A")
dev.off()

## e-mail experiment

# Instaling mailR package - it requires rJava which requires Java installed on the machine [LOTS of hickups with MacOS]

install.packages("rJava")
install.packages("devtools", dep = T)
library(devtools)
install_github("rpremraj/mailR")

library(mailR)

if(LatestDeltaCarlsberg > 0.04){
  send.mail(from = "stockbotanalysis@gmail.com",
            to = c("thelle.k@gmail.com"),
            subject = "Calrsberg over 4% delta",
            body = "Køb, køb, køb",
            attach.files = c("/Users/thelle/Google Drive/Projects/Stock Analysis_Dual share class/twinstock_github/Carlsberg.png"),
            smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "stockbotanalysis@gmail.com", passwd = "canihasstocks", ssl = TRUE),
            authenticate = TRUE,
            send = TRUE)
}