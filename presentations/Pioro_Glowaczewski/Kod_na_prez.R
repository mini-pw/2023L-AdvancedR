#install.packages("fitdistrplus")
library(fitdistrplus)
library(ggplot2)
library(dplyr)
n <- 10000
w1 <- rcauchy(n,1)

?fitdistrplus
fitg <- fitdist(w1, "norm")
summary(fitg)
plot(fitg)
descdist(w1)
?rgamma
?rtstud
x <- rpois(n,1)
descdist(w1, discrete = FALSE, boot = 500)

# Rozkład gamma
gamma <- rgamma(1000, 10, 200)
gammadf <- data.frame(gamma)
ggplot(gammadf, aes(gamma)) + 
  geom_histogram(color = "dark green", bins = 1000) +
  labs(title = "Histogram naszej próbki z rozkładu Gamma(10,200)",
       x = "Wartość",
       y = "Liczba obserwacji") +
  theme(plot.title = element_text(size = 20, hjust = 0.5), 
        axis.title = element_text(size = 15),
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(color = "grey",
                                        size = 0.1))
descdist(gamma, discrete = FALSE, boot = 100)
norm <- rnorm(1000,3,10)
mixed <- c(gamma,norm)
descdist(mixed, boot = 100)
# Rozkład Cauchy'ego
cauchy <- rcauchy(n, 10)
cauchydf <- data.frame(cauchy)
ggplot(cauchydf, aes(cauchy)) + 
  geom_histogram(color = "yellow", bins = 1000) +
  labs(title = "Histogram naszej próbki z rozkładu Cauchy'ego 10",
       x = "Wartość",
       y = "Liczba obserwacji") +
  theme(plot.title = element_text(size = 20, hjust = 0.5), 
        axis.title = element_text(size = 15),
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(color = "grey",
                                        size = 0.1))
descdist(cauchy, discrete = FALSE, boot = 1000)

# Rozkład poissona
pois <- rpois(n, 10)
poisdf <- data.frame(pois)
ggplot(poisdf, aes(pois)) + 
  geom_histogram(color = "blue", bins = 1000) +
  labs(title = "Histogram naszej próbki z rozkładu Poissona(10)",
       x = "Wartość",
       y = "Liczba obserwacji") +
  theme(plot.title = element_text(size = 20, hjust = 0.5), 
        axis.title = element_text(size = 15),
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(color = "grey",
                                        size = 0.1))
descdist(pois, discrete = TRUE, boot = 100)
descdist(pois, discrete = FALSE, boot = 100)

# Pokazywanie dla Weibulla
gamma1 <- rgamma(n, 10,1) + runif(n,-3,3)
gdf <- data.frame(gamma1)
ggplot(gdf, aes(gamma1)) + 
  geom_histogram(color = "blue", bins = 1000) +
  labs(title = "Histogram naszej próbki",
       x = "Wartość",
       y = "Liczba obserwacji") +
  theme(plot.title = element_text(size = 20, hjust = 0.5), 
        axis.title = element_text(size = 15),
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(color = "grey",
                                        size = 0.1))
gamma2 <- gamma1[gamma1 >= 0]
descdist(gamma2, discrete = FALSE, boot = 100)
fitdist(gamma2, "gamma", method = c("mme"))
plotdist(gamma2, "gamma", para = list(shape = 10, rate = 1))

