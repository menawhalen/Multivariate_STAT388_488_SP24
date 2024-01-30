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
map(receipt, ~sum(.)/length(.))
## covariance and variance
x <- c(sum(receipt$dollars)/length(receipt$dollars),
       sum(receipt$books)/length(receipt$books))

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
  
#############
### addition multiplication

x <- c(1,3,2)
y <- c(-2,1,-1)

3*x
x+y
## inner product ??
x*x
## not right

## best way
x%*%x
# cursed way
sum(x*x)

x %*% y
### length
sqrt(sum(x^2))
sqrt(sum(y^2))


## finding theta ??
#cos(theta) = x*y/lx*ly
x%*%y/(sqrt(sum(x^2))*sqrt(sum(y^2)))

acos(x%*%y/(sqrt(sum(x^2))*sqrt(sum(y^2))))
## this is in radians
## need to multiply by 180/pi to be degrees
acos(x%*%y/(sqrt(sum(x^2))*sqrt(sum(y^2))))*180/pi



############### notes for week of 1/30-2/1
?matrix
as.matrix(receipt)

##best cheatsheet
# https://www.statmethods.net/advstats/matrix.html

a <- matrix(c(3,1,-1,5,2,4), nrow = 2)
b <- matrix(c(-2,7,9), ncol = 1)
## wont work here
a*b
a%*%b

## transpose
?t()
t(a)


## square matrix finding inverse
A <- matrix(c(1,-5,-5,1), ncol = 2)

solve(A)

A %*% solve(A) ## basically identity matrix
round(A %*% solve(A), digits = 1)

## another way to get the identity matrix
diag(2) ## creates I by number put in

diag(A) ## gives you the diagnol of a matrix

#########################
## eigen value/vector

x1 <- c(1/sqrt(2), -1/sqrt(2))
A %*% x1
6 %*% x1
## x1 eigen vector and 6 eigen value
x2 <- c(1/sqrt(2), 1/sqrt(2))
A %*% x2
-4 %*% x2
## x2 eigen vector and -4 eigen value

## easier
eigen(A)


## spectral decomp
A <- matrix(c(13,-4,2,-4,13,-2,2,-2,10), ncol = 3)
E <- eigen(A)
L <- E$values
V <- E$vectors
A1 <- L[1] * V[,1] %*% t(V[,1])
A2 <- L[2] * V[,2] %*% t(V[,2])
A3 <- L[3] * V[,3] %*% t(V[,3])
A1 + A2 +A3
## can be used also but ehhhh
svd(A)


