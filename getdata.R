# Dependencies ----
library(dplyr)
library(httr)

# Source parameters ----

baseurl <- "https://www.alphavantage.co"

ticker <- "WOW.AX"
func <- "TIME_SERIES_WEEKLY_ADJUSTED"
API_KEY <- "EUDLB81402IK8SIA"

url <- paste0(baseurl, "/query?function=",func, "&symbol=",ticker,"&outputsize=full&apikey=",API_KEY)

# Fetch data ----

temp <- httr::GET(url) %>%
  content()

meta_lastrefresh <- temp$`Meta Data`$`3. Last Refreshed`
meta_comment <- temp$`Meta Data`$`1. Information`
meta_refreshtz <- temp$`Meta Data`$`4. Time Zone`

# Transform ----

df <- do.call(rbind.data.frame, temp[[2]])
df <- tibble::rownames_to_column(df, var = "Date")

df["Ticker"] <- ticker

df <- cleandf(df=df, source = baseurl, meta_lastrefresh, meta_refreshtz, meta_comment)

# Memory clean up ----

rm(baseurl, ticker, func, API_KEY, url, temp, meta_lastrefresh, meta_comment, meta_refreshtz)

suppressMessages(gc())
