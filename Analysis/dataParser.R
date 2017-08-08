# Gamepad Studio - Analysis - Data Parser
# Seperate raw data into pauses, keypresses, joystick quadrants, and drawing values

# setwd("~/Documents/Gamepad-Studio-Analysis/")
# library(arules)

## Import data
ID <- "V"
dataSource <- paste0("Data/player_data_", ID)
dataDirectory <- paste0("Data/gameplay_data_", ID, "/")
player_data <- read.table(paste0(dataSource, ".tsv"), sep = "\t")
txt_files <- list.files(dataDirectory, pattern = "txt")
png_files <- list.files(dataDirectory, pattern = "png")


## Choose session log
file_index <- 8
file_path <- paste0(dataDirectory, txt_files[file_index])
gpg_data <- read.table(file_path, sep = "\t", header = TRUE)

attach(gpg_data)

# n = number of observations
n <- dim(gpg_data)[1]


## Create pause time series
secs <- (millis - millis[1]) / 1000
pause <- NULL

for (i in 1:n)
  pause[i] <- secs[i+1] - secs[i]

gpg_pauses <- ts(pause)
rm(list = c('pause', 'secs', 'i'))


## Create keypress data frame
leftJoyX <- abs(anlgX) > 0
leftJoyY <- abs(anlgY) > 0
rightJoyX <- abs(anlgU) > 0
rightJoyY <- abs(anlgV) > 0

# BOTH axes (absVal) must be > 0 in order to draw on screen, however, variable values CAN be modified as a result of a single non-zero axis. It's a built-in feature for advanced players. Few players will knowingly use this feature, but if data discrepancies arise, this may be the cause.
leftJoy <- leftJoyX & leftJoyY
rightJoy <- rightJoyX & rightJoyY

gpg_keypresses <-  data.frame(index = 1:n,
                              red = as.logical(A1), 
                              green = as.logical(A2), 
                              blue = as.logical(A3), 
                              opacity = as.logical(A4),
                              dispersion = as.logical(L1),
                              position = as.logical(R2),
                              size = as.logical(R1),
                              random = as.logical(L2),
                              reset = as.logical(S1),
                              saveIMG = as.logical(S2),
                              up = as.logical(up),
                              down = as.logical(down),
                              left = as.logical(left),
                              right = as.logical(right),
                              leftJoy = leftJoy,
                              rightJoy = rightJoy)



## Create keypress transactions for association analysis
keypress_transactions <- as(gpg_keypresses[ , -1], "transactions")



## Create joystick values data frame
# leftJoy = {X,Y}; rightJoy = {U,V}
gpg_joysticks <- data.frame(index = 1:n, anlgX, anlgY, anlgU, anlgV)



## Create joystick quadrants data frame
left_Q1 <- anlgX > 0 & anlgY > 0
left_Q2 <- anlgX < 0 & anlgY > 0
left_Q3 <- anlgX < 0 & anlgY < 0
left_Q4 <- anlgX > 0 & anlgY < 0
right_Q1 <- anlgU > 0 & anlgV > 0
right_Q2 <- anlgU < 0 & anlgV > 0
right_Q3 <- anlgU < 0 & anlgV < 0
right_Q4 <- anlgU > 0 & anlgV < 0

gpg_quadrants <- data.frame(index = 1:n, left_Q1, left_Q2, left_Q3, left_Q4, 
                            right_Q1, right_Q2, right_Q3, right_Q4)


## Create quadrant transactions for association analysis
quadrant_transactions <- as(gpg_quadrants[ , -1], "transactions")



## Create drawing parameter data frame
# focalPoint refers to the gaussian centers; diameters refer to the ellipse dimensions
gpg_values <- data.frame(index = 1:n,
                         red_val = red,
                         green_val = green,
                         blue_val = blue,
                         opacity_val = opacity,
                         focalPointX_val = x_mean,
                         focalPointY_val = y_mean,
                         dispersionX_val = dpX,
                         dispersionY_val = dpY,
                         positionX_val = xpos,
                         positionY_val = ypos,
                         verticalDiameter_val = sX,
                         horizontalDiameter_val = sY)

# Clean-up
rm(list = c('leftJoy', 'rightJoy', 'leftJoyX', 'leftJoyY', 'rightJoyX', 'rightJoyY', 'left_Q4', 'left_Q3', 'left_Q2', 'left_Q1', 'right_Q4', 'right_Q3', 'right_Q2', 'right_Q1'))

detach(gpg_data)
