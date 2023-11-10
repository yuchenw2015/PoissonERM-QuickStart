library(tidyverse)
# Data Simulation
set.seed(12345)
data.id <- data.frame(PROT = sample(1:3, 1000, replace = T),
                      ID = 1:1000,
                      SEX = sample(1:2, 1000, replace = T),
                      RACE = sample(1:4, 1000, replace = T, prob = c(0.6,0.1,0.2,0.1)),
                      LOCATION = sample(1:2, 1000, replace = T, prob = c(0.7,0.3)),
                      AGE = ceiling(rnorm(1000)*10+45),
                      BWT = round(rnorm(1000)*10+75),
                      TIME = sample(20:365, 1000, replace = T),
                      CAVE1 = c(rep(0, 50),exp(rnorm(950, mean = log(50),0.5))),
                      CAVE2 = c(rep(0, 50),exp(rnorm(950, mean = log(50),0.5)))
                      )

data.flag1 <- data.id %>%
  mutate(FLAG = 1,
         P = pnorm((SEX-1)*0.2+(LOCATION-1)*0.0001+(RACE==3)*0.2+TIME*0.001+sqrt(CAVE1)*0.002-2),
         DV = as.numeric(rbernoulli(1000,P)),
         SUB = ifelse(DV==1, sample(1:2), 3)) %>%
  dplyr::select(-P)

data.flag2 <- data.id %>%
  mutate(FLAG = 2,
         P = pnorm((SEX-1)*0.0001+(LOCATION-1)*1+(RACE==3)*0+TIME*0.001+CAVE2*0.01-1),
         DV = as.numeric(rbernoulli(1000,P)),
         SUB = ifelse(DV==1, sample(1:4), sample(5:6))) %>%
  dplyr::select(-P)

data.flag3 <- data.id %>%
  mutate(FLAG = 3,
         P = pnorm(TIME*0.001+CAVE1*0.002-1+(SEX-1)*0.5),
         DV = as.numeric(rbernoulli(1000,P)),
         SUB = ifelse(DV==1, sample(1:2), sample(3:4))) %>%
  dplyr::select(-P)

data.flag <- rbind(data.flag1, data.flag2, data.flag3) %>%
  mutate(C = NA,
         DV = ifelse(runif(3000)>0.99, NA, DV))
data.flag %>% group_by(FLAG) %>% summarise(m = mean(DV, na.rm = T), na = sum(is.na(DV)))

write.csv(data.flag, "obsdata.csv", row.names = F, quote = F)

data.pred <- data.frame(GROUP = rep(c("10 mg QD", "30 mg QD", "50 mg QD", "100 mg QD"), each = 2500),
                        CAVE1 = c(exp(rnorm(2500, mean = log(3),0.5)),exp(rnorm(2500, mean = log(25),0.5)),
                                exp(rnorm(2500, mean = log(50),0.5)),exp(rnorm(2500, mean = log(100),0.5))),
                        CAVE2 = c(exp(rnorm(2500, mean = log(3),0.5)),exp(rnorm(2500, mean = log(25),0.5)),
                                exp(rnorm(2500, mean = log(50),0.5)),exp(rnorm(2500, mean = log(100),0.5)))) %>%
  mutate(C = ifelse(GROUP == "100 mg QD", 1, 0))

write.csv(data.pred , "simdata.csv", row.names = F, quote = F)
