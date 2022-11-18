library(ggtree)
library(tidyverse)
library(magrittr)
library(ggtree)
tt <- treeio::read.beast("~/Desktop/MCC_trees_V1 4/SD_MCC.v_1.tre")
# Here I am selecting nodes with an age (height) geater than 200 Mya.
# More complex sampling of nodes can be performed.
tt@data %>% filter(height > 200) %>% pull(node) -> root_nodes
tt@data %<>% #unnest(height_0.95_HPD) %>% 
  mutate(height_0.95_HPD = ifelse(node %in% root_nodes, height_0.95_HPD,NA))
tt %>% ggtree() + geom_range("height_0.95_HPD",col="red")
