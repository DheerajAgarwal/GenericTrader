library(dplyr)
library(httr)

baseurl <- "https://www.alphavantage.co"

ticker <- "WOW.AX"
func <- "TIME_SERIES_WEEKLY_ADJUSTED"
API_KEY <- "EUDLB81402IK8SIA"

url <- paste0(baseurl, "/query?function=",func, "&symbol=",ticker,"&outputsize=full&apikey=",API_KEY)

#url2 = "https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=WOW.AX&outputsize=full&apikey=EUDLB81402IK8SIA"
temp <- httr::GET(url) %>% content()

df <- do.call(rbind.data.frame, temp[[2]])
df <- tibble::rownames_to_column(df, var = "Date")

df["Ticker"] <- ticker

rm(baseurl, ticker, func, API_KEY, url, temp)
