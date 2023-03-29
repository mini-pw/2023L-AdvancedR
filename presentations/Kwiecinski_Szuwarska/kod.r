## ----libs---------------------------------------------------------------------
library("tidyverse") 
library("broom")
library("gridExtra")
library("grid")
library("ggthemes")
library("png")
library("scales")
library("simputation")
library("naniar") 
library("lubridate")
library("magick")
library("rpart")
library("visdat")
library("patchwork")
library("withr")
library("targets")
library("tidyverse") 
library("janitor")
library("knitr")
library("cowplot")
library("rpart.plot")

df <- read.csv("train.csv")


colnames(df) # calkiem sporo kolumn tutaj jest


df = df %>% 
  select("Occupation", "Payment_Behaviour", "Credit_Score", 'Age', 
         'Monthly_Balance', "Amount_invested_monthly")


# przykladowa ramka danych z przykladu
dat_ms <- tibble::tribble(~x,  ~y,    ~z,
                          1,   "A",   -100,
                          3,   "N/A", -99,
                          NA,  NA,    -98,
                          -99, "E",   -101,
                          -98, "F",   -1)

?miss_scan_count


miss_scan_count(dat_ms, search = "N/A")
miss_scan_count(dat_ms, search = -99)
miss_scan_count(dat_ms, search = common_na_numbers)


common_na_numbers
common_na_strings


str(df)

numeric_columns = c('Age', 'Monthly_Balance', "Amount_invested_monthly")

df[, numeric_columns] <- df %>% 
  select(numeric_columns) %>% 
  mutate_if(is.character, as.numeric)

str(df)


head(df)

miss_scan_count(df, search=c("__", "!@9#%8", -500))


# REPLACE -----------------------------------------------------------------



replace_with_na(dat_ms, replace = list(x = -99))
# tutaj po prostu zamieniamy ten cos na NA


df <- df %>% replace_with_na(replace = list(Occupation = "____", 
                                            Payment_Behaviour = "!@9#%8",
                                            Age = -500))

# tutaj dokładnie zamienia




replace_with_na_if(data = dat_ms,
                   .predicate = is.character,
                   condition = ~.x == "N/A")



miss_scan_count(df, search=c("____", "!@9#%8", -500))


df <- df %>% replace_with_na(replace = list(Occupation = "_______"))


miss_scan_count(df, search=c("____", "!@9#%8", -500))

# wiek poniżej 0 - bez sensu
df %>% filter(Age > 0) %>%  nrow()
df %>% filter(Age < 0) %>%  nrow()



df <- df %>% replace_with_na_at(
  .vars = "Age",
  condition = ~.x < 0)



df <- df %>% replace_with_na_at(
  .vars = "Age",
  condition = ~.x > 130)



df %>% filter(Age > 0) %>%  nrow()
df %>% filter(Age < 0) %>%  nrow()

# ADDDD -------------------------------------------------------------------

# teraz dodajemy kolumny z podsumowaniem



df_summarised <- df %>% add_any_miss() %>% 
  add_n_miss() %>% 
  add_label_missings()


head(df_summarised)




# SHADOW ------------------------------------------------------------------



dat_ms %>% nabular()


# FLAG --------------------------------------------------------------------

df_nabular <- df %>% nabular() %>% 
  recode_shadow(Age = .where(Age > 90 ~ "ktos_super_stary"))


df_nabular %>% filter(Age_NA == "NA_ktos_super_stary")



# impute ------------------------------------------------------------------


after_imputation_df <- df_nabular %>% impute_median_all() %>% 
  add_n_miss() 

after_imputation_df %>% group_by() %>% summarize(sum(n_miss_all))



after_imputation_df  %>% 
  add_label_shadow() %>% 
  group_by(any_missing) %>%
  summarise_at(.vars = vars(Age), .funs = lst(min, mean, median, max))




df_nabular %>% impute_median_at(.vars=vars(Age)) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Age, fill=any_missing)) +
  geom_density(alpha=0.5) + 
  labs(title = "results of imputing with median")



df_nabular %>% simputation::impute_lm(Age ~ Monthly_Balance) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Age, fill=any_missing)) +
  geom_density(alpha=0.5) + 
  labs(title = "results of linear imputing")
  

df_nabular[1:10000, ] %>% simputation::impute_rf(Age ~ Monthly_Balance) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Age, fill=any_missing)) +
  geom_density(alpha=0.5) + 
  labs(title = "results of random forest imputing")


df_nabular %>% 
  simputation::impute_lm(Age ~ Monthly_Balance + Occupation +
                           Credit_Score + Payment_Behaviour) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Age, fill=any_missing)) +
  geom_density(alpha=0.5) + 
  labs(title = "results of linear model imputing with more dependent variables")

# tutaj pojawiaja sie nowe braki wiec 


# to raczej nie potrzebne
## ----bind-impute-label-example, echo = TRUE-----------------------------------
aq_imputed <- nabular(airquality) %>%
  as.data.frame() %>% 
  simputation::impute_lm(Ozone ~ Temp + Wind) %>%
  simputation::impute_lm(Solar.R ~ Temp + Wind) %>%
  add_label_shadow()

head(aq_imputed)


## ----track-impute-example, fig.show = "hold", fig.cap = "Scatterplot (A) and density plots (B and C) of ozone and solar radiation from the airquality dataset containing imputed values from a linear model. Imputed values are colored green, and data values orange. Imputed values are similar, but slightly trended to the mean.", fig.height = 4, fig.width = 12, out.width = "100%", echo = FALSE----
p1 <- 
  ggplot(aq_imputed,
         aes(x = Ozone,
             y = Solar.R,
             color = any_missing)) + 
  geom_point() +
  scale_color_brewer(palette = "Dark2") +
  theme(legend.position = "none") + 
  labs(tag = "A")

p2 <- 
  ggplot(aq_imputed,
         aes(x = Ozone,
             fill = any_missing)) + 
  geom_density(alpha = 0.3) + 
  scale_fill_brewer(palette = "Dark2") +
  theme(legend.position = "none") + 
  labs(tag = "B")

p3 <- 
  ggplot(aq_imputed,
         aes(x = Solar.R,
             fill = any_missing)) + 
  geom_density(alpha = 0.3) + 
  scale_fill_brewer(palette = "Dark2") + 
  theme(legend.position = "none") + 
  labs(tag = "C")

grid.arrange(p1, p2, p3, nrow = 1)





# WYKRESY

# wykresy -----------------------------------------------------------------


gg_miss_var(df)
gg_miss_case(df)
vis_miss(df[1:10000,], cluster = TRUE, sort_miss = TRUE)
gg_miss_upset(df)

# Univariate

df %>%
  nabular() %>%
  impute_below_all() %>%
  ggplot(aes(x = Amount_invested_monthly,
             fill = Amount_invested_monthly_NA)) + 
  geom_histogram() + 
  scale_fill_brewer(palette = "Dark2") + 
  theme(legend.position = "bottom")

df %>%
  nabular() %>%
  ggplot(aes(x = Monthly_Balance)) + 
  geom_histogram(na.rm = TRUE) + 
  facet_wrap(~Amount_invested_monthly_NA)

df %>%
  nabular() %>%
  ggplot(aes(x = Monthly_Balance,
             colour = Amount_invested_monthly_NA)) + 
  geom_density(na.rm = TRUE) +
  scale_colour_brewer(palette = "Dark2")  + 
  theme(legend.position = "bottom")

# Bivariate

df %>%
  nabular() %>%
  impute_below_all() %>%
  add_label_shadow(Monthly_Balance,Amount_invested_monthly) %>%
  ggplot(aes(x = Amount_invested_monthly,
             y = Monthly_Balance,
             colour = any_missing)) + 
  geom_point() + 
  scale_colour_brewer(palette = "Dark2") + 
  theme(legend.position = "bottom")

# Parallel Coordinate Plot

range_01 <- function(x, ...){(x - min(x, ...)) / (max(x, ...) - min(x, ...))}

new_df <- read.csv("train.csv")[1:10000, ] %>% 
  select("Num_Credit_Card","Num_Bank_Accounts", 'Age', 
         'Monthly_Balance', "Amount_invested_monthly") %>% 
  mutate(Age = as.integer(Age),
         Monthly_Balance = as.numeric(Monthly_Balance),
         Amount_invested_monthly = as.numeric(Amount_invested_monthly)) %>%
replace_with_na_at(
  .vars = "Age",
  condition = ~.x < 0) %>% replace_with_na_at(
  .vars = "Age",
  condition = ~.x > 130)


as_tibble(new_df)


dat_paral <-  new_df[1:10000,] %>%
  mutate(ID = 1:n(),
         ID = as.factor(ID)) %>%
  nabular() %>%
  impute_below_all() %>%
  add_label_shadow() %>%
  mutate_if(is.numeric, range_01) %>% 
  gather(key, value, -c(6:13)) %>%
  select(ID, key, value, everything())

ggplot(dat_paral,
       aes(x = key,
           y = value,
           group = ID,
           colour = Amount_invested_monthly_NA)) + 
  geom_line(alpha = 0.3) + 
  theme(legend.position = "bottom") + 
  scale_colour_brewer(palette = "Dark2")


# Klasteryzacja


df_cls <- add_miss_cluster(df[1:10000,], n_clusters = 2)


miss_cls_fit_rpart <- rpart(factor(miss_cluster) ~ ., 
                            data = df_cls)


prp(miss_cls_fit_rpart,
    type = 4,
    extra = 2,
    fallen.leaves = TRUE,
    prefix = "cluster = ",
    suffix = " \nObservations",
    box.col = "lightgrey",
    border.col = "grey",
    branch.col = "grey40")



# summary -----------------------------------------------------------------


miss_var_table(df)
miss_var_summary(df)

miss_case_summary(df)



df %>% arrange(Credit_Score) %>% 
  group_by(Credit_Score) %>% miss_var_summary() %>% ggplot() + 
  aes(x = variable, y=pct_miss) +
  geom_bar(aes(fill = factor(Credit_Score, levels = c("Poor", "Standard", "Good"))), 
           stat = "identity", position = "dodge") +
  labs(title = "percent of missing data by variable", fill="Credit Score") 




df %>% add_shadow(Amount_invested_monthly) %>% 
  simputation::impute_lm(Amount_invested_monthly ~ Monthly_Balance) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Amount_invested_monthly, fill=any_missing)) +
  geom_density(alpha=0.5)  +
  labs(title = "results of linear model imputing")


df %>% add_shadow(Amount_invested_monthly) %>% 
  simputation::impute_proxy(Amount_invested_monthly ~ Monthly_Balance) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Amount_invested_monthly, fill=any_missing)) +
  geom_density(alpha=0.5)  +
  labs(title = "results of proxy imputing")


df[1:1000, ] %>% add_shadow(Amount_invested_monthly) %>% 
  simputation::impute_rf(Amount_invested_monthly ~ Monthly_Balance) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Amount_invested_monthly, fill=any_missing)) +
  geom_density(alpha=0.5)  +
  labs(title = "results of random forest imputing")





# to nie działa z niezrozumiałych przyczyn
df_imputed <- df %>% add_shadow(Occupation) %>% 
  simputation::impute_knn(Occupation  ~ Monthly_Balance)



df_shadow <- df %>% add_shadow(Occupation)

df_imputed <- df  %>% 
  simputation::impute_knn(Occupation  ~ Monthly_Balance)

df_imputed %>% 
  ggplot(aes(x = Occupation)) +
  geom_bar(stat="count")





# gowno - tego nie ruszamy ale w ramach przestrogi zostawiam -------------------------------------------------------------------












df %>% add_shadow(Occupation) %>% 
  as.data.frame() %>% 
  simputation::impute_cart(Occupation ~ Monthly_Balance) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Monthly_Balance, fill=any_missing)) +
  geom_density(alpha=0.5)  +
  facet_wrap(~Occupation) +
  labs(title = "results of cart imputing")
# tutaj wszedzie gdzie byl brak poszedl lawyer


# to nie działa
df[1:1000, ] %>% 
  add_shadow(Occupation) %>%
  as.data.frame() %>% 
  simputation::impute_knn(Occupation ~ Monthly_Balance + Age) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Monthly_Balance, fill=any_missing)) +
  geom_density(alpha=0.5)  +
  facet_wrap(~Occupation) +
  labs(title = "results of k nearest neighbors imputing")

# to nie działa
df[1:1000, ] %>% 
  add_shadow(Occupation) %>%
  as.data.frame() %>% 
  simputation::impute_lm(Occupation ~ Payment_Behaviour) %>% 
  add_label_shadow() %>% 
  ggplot(aes(x=Monthly_Balance, fill=any_missing)) +
  geom_density(alpha=0.5)  +
  facet_wrap(~Occupation) +
  labs(title = "results of k nearest neighbors imputing")
