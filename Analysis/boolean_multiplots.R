# Gamepad-Studio - Boolean Multiplots

library(ggplot2)
source("multiplot_fxn.R")

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
multiplot(leftJoy.plt, rightJoy.plt, up.plt, down.plt, right.plt, left.plt)

# Plot variables
multiplot(red.plt, green.plt, blue.plt, opacity.plt, size.plt, position.plt, dispersion.plt)

# Global associations
global_associations
multiplot(leftJoy.plt, position.plt, green.plt, size.plt, red.plt, blue.plt)
