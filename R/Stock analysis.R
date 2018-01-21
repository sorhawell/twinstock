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

## e-mail experiment

  # Instaling mailR package - it requires rJava which requires Java installed on the machine [LOTS of hickups with MacOS]
  
  # install.packages("rJava")
  # install.packages("devtools", dep = T)
  # library(devtools)
  # install_github("rpremraj/mailR")
  # 
  # library(mailR)

# Installing sendmailR package

install.packages("sendmailR")
library(sendmailR)


# Mærsk
getSymbols(c("MAERSK-A.CO", "MAERSK-B.CO"), src = "av", api.key = "XGX6A34XQQX6I2YE")

plot((Delt(`MAERSK-A.CO`[, "MAERSK-A.CO.Close"], `MAERSK-B.CO`[, "MAERSK-B.CO.Close"], type='arithmetic'))*100, main="Delta (pct) Maersk B vs Maersk A")
#Warning messages from quantmod-package: contains missing values. Some functions will not work if objects contain missing values in the middle of the series. Consider using na.omit(), na.approx(), na.fill(), etc to remove or replace them. 
#na.omit(c("MAERSK-A.CO", "MAERSK-B.CO"))

# Investor AB
getSymbols(c("INVE-A.ST", "INVE-B.ST"), src = "yahoo", from = "2017-01-01")
plot((Delt(`INVE-A.ST`[, "INVE-A.ST.Close"], `INVE-B.ST`[, "INVE-B.ST.Close"], type='arithmetic'))*100, main="Delta (pct) Investor AB B vs Investor AB A")

# Ericsson
getSymbols(c("ERIC-A.ST", "ERIC-B.ST"), src = "yahoo", from = "2010-01-01")
plot((Delt(`ERIC-A.ST`[, "ERIC-A.ST.Close"], `ERIC-B.ST`[, "ERIC-B.ST.Close"], type='arithmetic'))*100, main="Delta (pct) Ericsson B vs Ericsson A")



# Create an xts object (xts is loaded with quantmod) that contains closing
# prices for AAPL, MSFT, and GOOG

#stocks <- as.xts(data.frame(`MAERSK-A.CO` = `MAERSK-A.CO`[, "MAERSK-A.CO.Close"], `MAERSK-B.CO` = `MAERSK-B.CO`[, "MAERSK-B.CO.Close"]))
#head(stocks)