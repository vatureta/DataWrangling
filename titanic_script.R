#set working directory
setwd("~/R/DataWranglingTracked/Titanic")

#load packages: dplyr, tidyr, stringr
library(tidyr)
library(dplyr)
library(stringr)
titanic_new <- read.csv("titanic_original.csv", na.strings = 'NA')

#p <- function(x) {sum(is.na(x))/length(x)*100}
#apply(titanic_new,2,p)

#titanic_new %>%
 # mutate(embarked = ifelse(is.na(embarked)=TRUE),'S')

#port of embarkation
titanic_new$embarked[which(is.na(titanic_new$embarked))] <- 'S'
#age
titanic_new$age[which(is.na(titanic_new$age))] <- mean(titanic_new$age, na.rm = TRUE)
#Lifeboat
