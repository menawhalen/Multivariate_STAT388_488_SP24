sweat <- read.table("johnson_wichern_data/T5-1.dat", 
           col.names = c("sweat", "sodium", "potassium"))
mo <- c(4, 50, 10)
xbar <- colMeans(sweat)
n <- dim(sweat)[1]
p <- dim(sweat)[2]
n %*% t(xbar - mo) %*% solve(cov(sweat)) %*% (xbar - mo)
(n-1)*p/(n-p)* qf(.1, 3, 17, lower.tail = F)
### example 5.3 
library(tidyverse)
ex5_3 <- read.table("johnson_wichern_data/T4-1.dat", col.names = "closed") %>% 
  bind_cols(read.table("johnson_wichern_data/T4-5.dat", col.names = "open")) %>% 
  mutate(closed = closed ^(1/4), 
         open = open^(1/4))

xbar <- colMeans(ex5_3)
cov(ex5_3)
solve(cov(ex5_3))
eigen(cov(ex5_3))


42 *  t(xbar - c(0.562, 0.589)) %*% solve(cov(ex5_3)) %*% (xbar - c(0.562, 0.589))
qf(0.95, 2, 40)


ggplot(ex5_3, aes(closed, open)) +
  geom_point() +
  stat_ellipse(level = 0.95)

(sqrt(eigen(cov(ex5_3))$values[1]) * sqrt(2*41)/(42*40)*qf(0.95, 2, 40)) %*% eigen(cov(ex5_3))$vectors[,1]
(sqrt(eigen(cov(ex5_3))$values[1]) * sqrt(2*41)/(42*40)*qf(0.95, 2, 40)) %*% eigen(cov(ex5_3))$vectors[,1]



### download data
test_scores <- read.table("johnson_wichern_data/T5-2.dat", 
                          col.names = c("ss", "verbal", "science"))

colMeans(test_scores)
cov(test_scores)

### I really only need to variances of each variables
## and the individual means of each variable
## calculate F distribution
n <- dim(test_scores)[1]
p <- dim(test_scores)[2]

f_dist <- p*(n-1)/(n-p)* qf(0.95, p, (n-p))
### bar{x_1} - sqrt(F)*sqrt(var{x_1}/n)
mean(test_scores$ss) - sqrt(f_dist)*sqrt(var(test_scores$ss)/n)
### bar{x_1} + sqrt(F)*sqrt(var{x_1}/n)
mean(test_scores$ss) + sqrt(f_dist)*sqrt(var(test_scores$ss)/n)

# test_scores %>% 
#   summarise(across(everything()), list(mean = mean, var = var))






