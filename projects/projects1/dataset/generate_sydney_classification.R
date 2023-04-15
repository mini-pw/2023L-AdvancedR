library(dplyr)

path_to_dataset <- 'datasets/sydney_house_prices_regression.csv'
df <- read.csv(path_to_dataset)

# >=1M -> 1
#  <1M -> 0
df <- df %>% mutate(sellPrice = ifelse(sellPrice >= 10^6, 1, 0))

path_out <- 'datasets/sydney_house_prices_classification.csv'
write.csv(df, row.names = FALSE, file = path_out)
