install.packages("tidyverse")
library(tidyverse)
iri_file_0 <- read.csv("/Users/llb/Documents/Assignment2/data-assignment/LTPP/iri.csv")
head(iri_file_0)
iri_file_1<-filter(iri_file_0, STATE_CODE==6)
iri_file_2<-filter(iri_file_1, stringr::str_detect(SHRP_ID, "^050"))
head(iri_file_2)

iri_file_subset<-iri_file_0 |>
  group_by(STATE_CODE, SHRP_ID)|>
  summarise(
    observation=n(),
    iri_max=max(IRI),
    iri_min=min(IRI),
    iri_mean=mean(IRI)
  )|>
  ungroup()

iri_file_subset|>
  slice_sample(n=6)

arrange(iri_file_subset, desc(iri_mean))

iri_file_3<-iri_file_0|>
  separate(VISIT_DATE,c("VISIT_DATE",NULL),sep=",")|>
  mutate(
    DATE=as.Date(VISIT_DATE,"%m/%d/%y"),
  )
iri_t<-iri_file_3|> 
  group_by(DATE,STATE_CODE)|> 
  summarise(
    observation=n(),
    iri_mean_1=mean(IRI) 
  )|>
  ungroup()
p<-ggplot(data=iri_t,aes(DATE,iri_mean_1))+geom_point(aes(colour=STATE_CODE))+theme(axis.text=element_text(size=10), axis.title=element_text(size=10))
p
