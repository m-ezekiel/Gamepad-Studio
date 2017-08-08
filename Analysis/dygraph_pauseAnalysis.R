# Gamepad-Studio - Dygraph Pause Analysis

#setwd("~/Documents/Gamepad-Studio-Analysis/")
#source("dataParser.R")

# Display interactive time series chart
library(dygraphs)
dygraph(gpg_pauses, xlab = "Keypress index", ylab = "Pause length", 
        main = paste0(ID, " ", file_index, " ", txt_files[file_index], " ", n)) %>%
  dySeries("V1", label = "Seconds") %>%
  dyLegend(show = "always", hideOnMouseOut = FALSE) %>%
  dyRangeSelector()


p_threshold <- 8
which(pause > p_threshold)

