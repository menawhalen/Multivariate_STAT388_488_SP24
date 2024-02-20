library(tidyverse)
waste <- read.table("johnson_wichern_data/T6-1.dat",
                    col.names = c("bod_1", "ss_1", "bod_2", "ss_2"))
diff <- waste %>% 
  mutate(bod = bod_1-bod_2,
         ss = ss_1 - ss_2) %>% 
  select(bod, ss)
colMeans(diff)
cov(diff)

n <- dim(diff)[1]
p <- dim(diff)[2]
test_stat <- n %*% t(colMeans(diff)) %*% solve(cov(diff)) %*% colMeans(diff)
test_stat

crit_value <- p*(n-1)/(n-p)*qf(0.05,2, 9, lower.tail = F)
crit_value
test_stat > crit_value


#####################################################
?manova
## lets use penguins dataset
library(palmerpenguins)
library(gridExtra)
data("penguins")
head(penguins)

box_bl <- ggplot(penguins, aes(x = species, y = bill_length_mm)) +
  geom_boxplot() 
box_bd <- ggplot(penguins, aes(x = species, y = bill_depth_mm)) +
  geom_boxplot() 
box_fl <- ggplot(penguins, aes(x = species, y = flipper_length_mm)) +
  geom_boxplot() 
box_bm <- ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot() 
grid.arrange(box_bl, box_bd, box_fl, box_bm, ncol = 2, nrow = 2)

mano <- manova(cbind(bill_depth_mm, bill_length_mm, flipper_length_mm, body_mass_g) ~ species, data = penguins)
summary(mano)

mano <- manova(cbind(bill_depth_mm, bill_length_mm, flipper_length_mm, body_mass_g) ~ species, data = penguins)
summary(mano, test = "Wilks")

