library(ggtree)
library(tidyverse)
library(magrittr)
library(ggtree)
tt <- treeio::read.beast("~/Desktop/MCC_trees_V1 4/SD_MCC.v_1.tre")
tt@data %>% filter(height > 200) %>% pull(node) -> root_nodes
tt@data %<>% #unnest(height_0.95_HPD) %>% 
  mutate(height_0.95_HPD = ifelse(node %in% root_nodes, height_0.95_HPD,NA))
tt %>% ggtree() + geom_range("height_0.95_HPD",col="red")
