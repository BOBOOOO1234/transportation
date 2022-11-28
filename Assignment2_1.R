install.packages("tidyverse")
library(tidyverse)
acc<-read.csv("/Users/llb/Documents/Assignment2/data-assignment/CRSS/ACCIDENT.csv")
per<-read.csv("/Users/llb/Documents/Assignment2/data-assignment/CRSS/PERSON.csv")
inter<-
  inner_join(x=acc,y=per,by=c("CASENUM","PSU"))

total<-inter|>
  group_by(INJ_SEV)|>
  summarise(
    observation=n(),
  )|>
  ungroup()

merge<-left_join(x=acc,y=per,by=c("CASENUM","PSU"))
sum(is.na(merge$VEH_NO))
