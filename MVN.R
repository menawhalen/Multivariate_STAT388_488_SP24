# lets first simulate a bivariate normal sample
library(MASS)
# Simulate bivariate normal data
mu <- c(0,0)                         # Mean
Sigma <- matrix(c(1, .5, .5, 1), 2)  # Covariance matrix
?mvrnorm()
# Generate sample from N(mu, Sigma)
bivn <- mvrnorm(5000, mu = mu, Sigma = Sigma )  # from Mass package
head(bivn)                                      

## look at plots of contours
library(ellipse)
rho <- cor(bivn)
y_on_x <- lm(bivn[,2] ~ bivn[,1])    # Regressiion Y ~ X
x_on_y <- lm(bivn[,1] ~ bivn[,2])    # Regression X ~ Y
plot_legend <- c("99% CI green", "95% CI red","90% CI blue",
                 "Y on X black", "X on Y brown")

plot(bivn, xlab = "X", ylab = "Y",
     col = "dark blue",
     main = "Bivariate Normal with Confidence Intervals")
lines(ellipse(rho), col="red")       # ellipse() from ellipse package
lines(ellipse(rho, level = .99), col="green")
lines(ellipse(rho, level = .90), col="orange")
abline(y_on_x)
abline(x_on_y, col="brown")
legend(3,1,legend=plot_legend,cex = .5, bty = "n")

## other package mvtnorm
###########################################################################
library(mvtnorm)
set.seed(12345)

## Assign mu, Sigma   
mu <- c(60, 100, 80, 75)
Sigma <- matrix(c(12,2,5,-4, 2,16,3,-2, 5,3,20,-2, -4,-2,-2,18),ncol=4)

## Draw Random sample of Multivariate Normal Distribution
X <- rmvnorm(5000, mu, Sigma)

## Compute sample means, variance-covariance matrix
colMeans(X)
cov(X)


###################### testing normality 
# https://cran.r-project.org/web/packages/MVN/vignettes/MVN.html
# http://www.biosoft.hacettepe.edu.tr/MVN/
library(MVN)
library(tidyverse)
stiff <- read.table("johnson_wichern_data/T4-3.DAT",col.names = c("shock", "vibe", "stat1", 
                                                         "stat2", "d2"))
## look at just two variable for a plot
stiff2 <- stiff %>% 
  select(shock, vibe)
## 3d plots
mvn(stiff2, mvnTest = "mardia", multivariatePlot = "persp")
mvn(stiff2, mvnTest = "hz", multivariatePlot = "persp")
## contours
mvn(stiff2, mvnTest = "mardia", multivariatePlot = "contour")
mvn(stiff2, mvnTest = "hz", multivariatePlot = "contour")
## qq plots
mvn(stiff2, mvnTest = "mardia", multivariatePlot = "qq")
mvn(stiff2, mvnTest = "hz", multivariatePlot = "qq")
## look at the other static ones
stiff_other <- stiff %>% 
  select(stat1, stat2)

mvn(stiff_other, mvnTest = "hz", multivariatePlot = "persp")
mvn(stiff_other, mvnTest = "hz", multivariatePlot = "contour")
mvn(stiff_other, mvnTest = "hz", multivariatePlot = "qq")

### check for outliers using quantile method (removing d2)
mvn(select(stiff, -d2), mvnTest = "hz", multivariateOutlierMethod = "quan")
mvn(select(stiff, -d2), mvnTest = "hz")
mvn(select(stiff, -d2), mvnTest = "mardia")
mvn(select(stiff, -d2), mvnTest = "royston")

