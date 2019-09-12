
alpha <- function(){
  cat("function definition pending")
}

beta <- function(){
  cat("function definition pending")
}


rsquared <- function(){
  cat("function definition pending")
}

cleandf <- function(df=NULL, source = NA, ...){
  col_names <- c("Date", "Open", "High", "Low", "Close", "AdjClose", "Volume", "Dividend", "Ticker", "SplitCoeff")
  colnames(df) <- col_names
  col_order <- c("Ticker", "Date", "Open", "High", "Low", "Close", "AdjClose", "Volume", "Dividend", "SplitCoeff")
  df <- df[, col_order]
  df <- data.frame(df,
                   "LastFetched" = Sys.Date(),
                   "Source" = source,
                   "LastSourceRefresh" = meta_lastrefresh,
                   "SourceTimeZone" = meta_refreshtz,
                   "Comments" = meta_comment
                   )
  df$Date <- as.Date(df$Date)
  # df <- data.frame(df, "Source" = source)
  return(df)
}
