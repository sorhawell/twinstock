devtools::install_github("tidyverse/tibble")
install.packages("alphavantager")
library(alphavantager)

# Set Alpha Vantage API Key (Do this once)
av_api_key("XGX6A34XQQX6I2YE")

av_get(symbol = "MSFT", av_fun = "TIME_SERIES_INTRADAY", interval = "15min")