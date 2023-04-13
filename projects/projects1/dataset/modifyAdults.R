### Zmiana tabelki adults.csv
df_new = read.csv2("adult.csv", sep = ",")
set.seed(15072001)
target_na_idx <- sample(dim(df_new)[1], 177)
df_new$income[target_na_idx]  <- NA
target_na_idx <- sample(dim(df_new)[1], 3)
df_new$hours.per.week[target_na_idx]  <- 200
target_na_idx <- sample(dim(df_new)[1], 3)
df_new$age[target_na_idx]  <- 12
df_new["human"] <- "yes"
