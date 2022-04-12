library(tidyverse)
library(ggplot2)
library(viridis)
load("example.Rdata")
example %>% arrange(year) %>% distinct(CellID,AcceptedName,.keep_all = T) -> una
example %>% arrange(-year) %>% distinct(CellID,AcceptedName,.keep_all = T) -> dos
example %>% distinct(CellID,AcceptedName,.keep_all = T) -> tres
ggplot() +
geom_histogram(data=una ,aes(x=year,y = ..density..), fill=viridis::rocket(10)[6],binwidth = 10) +
  geom_label(aes(x=1880, y=0.01, label="Ascending order"), color=viridis::rocket(10)[7]) +
  geom_histogram(data=dos,aes(x = year, y =..density..),alpha=0.5, fill= viridis::mako(10)[6],binwidth = 10) +
  geom_label(aes(x=1880, y=0.015, label="Descending order"), color=viridis::mako(10)[6])+
  geom_histogram(data=tres ,aes(x=year,y = ..density..),alpha=0.5, fill=viridis::mako(10)[1],binwidth = 10) +
  geom_label(aes(x=1880, y=0.0125, label="Original order"), color=viridis::mako(10)[1])
