# Dependencies ----
library(dplyr)
library(httr)

# Source parameters ----

baseurl <- "https://www.alphavantage.co"

ticker <- "WOW.AX"
func <- "TIME_SERIES_DAILY_ADJUSTED"
API_KEY <- "EUDLB81402IK8SIA"



if(file.exists("./data/stocks.csv")){
  existing_data <- read.csv("./data/stocks.csv", colClasses = c("Date"= "Date"))
  stocks <- unique(existing_data$Ticker)
  if(ticker %in% stocks){
    source_url <- paste0(baseurl, "/query?function=",func, "&symbol=",ticker,"&outputsize=compact&apikey=",API_KEY)
  }
} else {
  source_url <- paste0(baseurl, "/query?function=",func, "&symbol=",ticker,"&outputsize=full&apikey=",API_KEY)
}



# Fetch data ----

temp <- httr::GET(source_url) %>%
  content()

meta_lastrefresh <- temp$`Meta Data`$`3. Last Refreshed`
meta_comment <- temp$`Meta Data`$`1. Information`
meta_refreshtz <- temp$`Meta Data`$`5. Time Zone`

# Transform ----

df <- do.call(rbind.data.frame, temp[[2]])
df <- tibble::rownames_to_column(df, var = "Date")

df["Ticker"] <- ticker

df <- cleandf(df=df, source = baseurl, meta_lastrefresh, meta_refreshtz, meta_comment)

if(file.exists("./data/stocks.csv")){
  existing_data <- read.csv("./data/stocks.csv", colClasses = c("Date"= "Date"))
  max_date <- max(existing_data$Date)
  df <- df[df$Date > max_date, ]
}

# Memory clean up ----

rm(baseurl, ticker, func, API_KEY, source_url, temp, meta_lastrefresh, meta_comment, meta_refreshtz)

suppressMessages(gc())
