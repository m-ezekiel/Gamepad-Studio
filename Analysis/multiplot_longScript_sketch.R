# Gamepad-Studio - Dygraph Pause Analysis

# setwd("~/Documents/Gamepad-Studio-Analysis/")
# source("multiplot_fxn.R")
# library(arules)
# library(arulesViz)
# library(ggplot2)

# Import data
ID <- "V"
dataSource <- paste0("Data/player_data_", ID)
dataDirectory <- paste0("Data/gameplay_data_", ID, "/")
player_data <- read.table(paste0(dataSource, ".tsv"), sep = "\t")
txt_files <- list.files(dataDirectory, pattern = "txt")
png_files <- list.files(dataDirectory, pattern = "png")

# Choose session log
file_index <- 8
file_path <- paste0(dataDirectory, txt_files[file_index])
gpg_data <- read.table(file_path, sep = "\t", header = TRUE)

attach(gpg_data)

# Row = observation; Column = variable
obs <- dim(gpg_data)[1]
str(gpg_data)


# Convert to pauses
secs <- millis/1000 - millis[1]/1000
pause <- NULL

for (i in 1:length(secs))
  pause[i] <- secs[i+1] - secs[i]

pause.ts <- ts(pause)


# Display interactive time series chart
library(dygraphs)
dygraph(pause.ts, xlab = "Keypress index", ylab = "Pause length",
        main = paste0(ID, " ", file_index, " ", txt_files[file_index], " ", obs)) %>%
  dySeries("V1", label = "Seconds") %>%
  dyLegend(show = "always", hideOnMouseOut = FALSE) %>%
  dyRangeSelector()


# Length of play session before reset (seconds)
# The initial session will have a longer pause due application startup
(millis[dim(gpg_data)[1]] - millis[1]) / 1000

# Number of action frames captured
dim(gpg_data)[1]

# Average pause length during session (seconds)
((millis[dim(gpg_data)[1]] - millis[1]) / 1000) / obs


p_threshold <- 8
which(pause > p_threshold)

# Gamepad-Studio - Boolean Multiplots

#library(ggplot2)
#source("multiplot_fxn.R")

# Import and reshape data to include an index column
# Import data using selection from sourced file
# source("dygraph_pauseAnalysis.R")

leftJoy <- abs(joy1_int) > 0
rightJoy <- abs(joy2_int) > 0

# Convert keypresses to transactions
attach(gpg_data)
n <- dim(gpg_data)[1]
gpgBool <- data.frame(index = 1:n,
                      red = A1, 
                      green = A2, 
                      blue = A3, 
                      opacity = A4,
                      dispersion = L1,
                      position = R2,
                      size = R1,
                      random = L2,
                      reset = S1,
                      saveIMG = S2,
                      up = up,
                      down = down,
                      left = left,
                      right = right,
                      leftJoy = as.numeric(as.logical(joy1_int)),
                      rightJoy = as.numeric(as.logical(joy2_int)))

# Define plots

leftJoy.plt <- ggplot(gpgBool, aes(x=index, y=leftJoy)) + geom_bar(stat = "identity")
rightJoy.plt <- ggplot(gpgBool, aes(x=index, y=rightJoy)) + geom_bar(stat = "identity")

up.plt <- ggplot(gpgBool, aes(x=index, y=up)) + geom_bar(stat = "identity")
down.plt <- ggplot(gpgBool, aes(x=index, y=down)) + geom_bar(stat = "identity")
left.plt <- ggplot(gpgBool, aes(x=index, y=left)) + geom_bar(stat = "identity")
right.plt <- ggplot(gpgBool, aes(x=index, y=right)) + geom_bar(stat = "identity")

red.plt <- ggplot(gpgBool, aes(x=index, y=red)) + geom_bar(stat = "identity", fill = "red")
green.plt <- ggplot(gpgBool, aes(x=index, y=green)) + geom_bar(stat = "identity", fill = "green")
blue.plt <- ggplot(gpgBool, aes(x=index, y=blue)) + geom_bar(stat = "identity", fill = "blue")
opacity.plt <- ggplot(gpgBool, aes(x=index, y=opacity)) + geom_bar(stat = "identity")

size.plt <- ggplot(gpgBool, aes(x=index, y=size)) + geom_bar(stat = "identity")
dispersion.plt <- ggplot(gpgBool, aes(x=index, y=dispersion)) + geom_bar(stat = "identity")
position.plt <- ggplot(gpgBool, aes(x=index, y=position)) + geom_bar(stat = "identity")

random.plt <- ggplot(gpgBool, aes(x=index, y=random)) + geom_bar(stat = "identity")
reset.plt <- ggplot(gpgBool, aes(x=index, y=reset)) + geom_bar(stat = "identity")
saveIMG.plt <- ggplot(gpgBool, aes(x=index, y=saveIMG)) + geom_bar(stat = "identity")


# Plot joysticks and direction pad
#multiplot(leftJoy.plt, rightJoy.plt, up.plt, down.plt, right.plt, left.plt)

# Plot variables
# multiplot(leftJoy.plt, rightJoy.plt, red.plt, green.plt, blue.plt, opacity.plt, size.plt, position.plt, dispersion.plt, random.plt, up.plt, down.plt, left.plt, right.plt)

# multiplot(leftJoy.plt, position.plt, up.plt, down.plt, left.plt, right.plt)

# Global associations
#global_associations
#multiplot(leftJoy.plt, position.plt, random.plt, opacity.plt)
#multiplot(position.plt, rightJoy.plt, left.plt, dispersion.plt, random.plt)

# - - -

sd(gpg_data$red)
sd(gpg_data$x_mean)
sd(gpg_data$y_mean)


