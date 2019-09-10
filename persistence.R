source("./getdata.R")

write.table(df, file =  "./data/stocks.csv",
            sep = ",",
            col.names = !file.exists("./data/stocks.csv"),
            append = TRUE,
            row.names = FALSE)

