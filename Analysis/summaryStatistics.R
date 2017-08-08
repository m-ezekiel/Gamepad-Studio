# Gamepad Studio - Analysis - Summary Statistics

#source("dataParser.R")
#source("association_analytics.R")

# Player ID and file index
noquote(paste0(ID, " ", file_index, "; n = ", n))

session_associations

summary(player_data)
summary(gpg_values)

par(mfrow = c(3,2))

# Joystick analog value boxplot
boxplot(gpg_joysticks[ , -1])

# Color distribution boxplot
boxplot(gpg_values[ , 2:5])

# Position coordinates boxplot (potentially misleading due to gaussian randomness in plotting)
boxplot(gpg_values[ , 10:11])

# Focal points (Gaussian centerpoints) boxplot
boxplot(gpg_values[ , 6:7])

# Ellipse diameters boxplot
boxplot(gpg_values[ , 12:13])

# Dispersion boxplot
boxplot(gpg_values[ , 8:9])



# Color value vs AF index
plot(ts(gpg_values$red_val), col = "red")
plot(ts(gpg_values$green_val), col = "green")
plot(ts(gpg_values$blue_val), col = "blue")
