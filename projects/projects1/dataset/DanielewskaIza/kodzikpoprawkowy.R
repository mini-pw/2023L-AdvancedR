library(stringr)
dane2 <- read.csv('Sport car price.csv')
str(dane2)
dane2$Horsepower <- as.numeric(dane2$Horsepower)
dane2$Torque..lb.ft. <- as.numeric(dane2$Torque..lb.ft.)
dane2$X0.60.MPH.Time..seconds. <- as.numeric(dane2$X0.60.MPH.Time..seconds.)
dane2$Price..in.USD.<- str_replace_all(dane2$Price..in.USD., 
                                       pattern = ",", 
                                       replacement = "")
dane2$Engine.Size..L.<- str_replace_all(dane2$Engine.Size..L., 
                                        pattern = "N/A", 
                                        replacement = "NA")
dane2$Engine.Size..L.[str_detect(dane2$Engine.Size..L., pattern = "NA")]<-NA
dane2$Price..in.USD. <- as.numeric(dane2$Price..in.USD.)
write.csv(dane2, "samochody.csv", row.names = FALSE)