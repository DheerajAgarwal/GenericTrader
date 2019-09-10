list.of.packages <- c("shiny",
                      "DT",
                      "PerformanceAnalytics",
                      "ggplot2",
                      "rusquant",
                      "plotly",
                      "curl",
                      "rgdax")

cat("Checking if all necessary packages are available..................\n")

missing.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]

if (length(missing.packages)){
  cat("Installing Missing libraries..................\n")
  install.packages(missing.packages)
} else {
  cat("all needed packages are already installed..................\n")
}

# rm(list.of.packages)
rm(missing.packages)



