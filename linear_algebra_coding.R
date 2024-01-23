### class notes 1/23
library(tidyverse)
## CH1 simple example

receipt <- data.frame(dollars = c(42,52,48,58),
                      books = c(4,5,4,3))
## find x bar

### most "by hand"
sum(receipt$dollars)/length(receipt$dollars)
sum(receipt$books)/length(receipt$books)
## still "by hand-ish"
mean(receipt$dollars)
mean(receipt$books)
# nontidyverse way to get col means
colMeans(receipt)
# tidyverse way
map(receipt, mean)

## covariance and variance

### most by hand
## s_11 (variance in dollars)
sum((receipt$dollars - mean(receipt$dollars))^2)/4
## s_22 variance of books
sum((receipt$books - mean(receipt$books))^2)/4
## s_12 covariance
sum((receipt$dollars - mean(receipt$dollars))*(receipt$books - mean(receipt$books)))/4

## in matrix form s11, s12, s21, s22
matrix(c(sum((receipt$dollars - mean(receipt$dollars))^2)/4,
         sum((receipt$dollars - mean(receipt$dollars))*(receipt$books - mean(receipt$books)))/4,
         sum((receipt$dollars - mean(receipt$dollars))*(receipt$books - mean(receipt$books)))/4,
         sum((receipt$books - mean(receipt$books))^2)/4),
       nrow = 2)

## what about an easier way using cov??
cov(receipt)
## ??????????
?cov()
### difference between sample and population covariance!
## The denominator n−1 is used which gives an unbiased estimator of the (co)variance for i.i.d. observations.
## so if you want population level
## need to multiply by (n-1)/n
cov(receipt)*(4-1)/4

## lots of other ways to do this
##  but this is the easiest I think
  
