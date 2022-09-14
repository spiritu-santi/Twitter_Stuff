library(ape)
library(tidyverse)
library(magrittr)
library(ggtreeExtra)
library(ggtree)
library(phyloseq)

 data  <- read.table("toy_data.csv",sep=",",header=T)
 ape::read.tree("random_tree.tree")
  data %<>% group_by(family) %>% mutate(median_age=mean(age))
  p <- ggtree(tree, layout="fan", open.angle=10) + 
    geom_cladelab(node= 146,offset=100,label="A",barsize=1, 
                  barcolor=MetBrewer::met.brewer("Kandinsky")[1],
                  textcolor="white",
                  fill=MetBrewer::met.brewer("Kandinsky")[1],offset.text=10,geom='label') +
    geom_cladelab(node=145,label="B",offset=100,barsize=1, 
                  barcolor=MetBrewer::met.brewer("Kandinsky")[3],
                  fill=MetBrewer::met.brewer("Kandinsky")[3],
                  textcolor="white",offset.text=10,geom='label') +
    geom_cladelab(node=141,label="C",offset=100,barsize=1, 
                  barcolor=MetBrewer::met.brewer("Kandinsky")[2],
                  fill=MetBrewer::met.brewer("Kandinsky")[2],
                  textcolor="white",
                  offset.text=10,geom='label') +
    geom_cladelab(node=79,label="D",offset=100,barsize=1, 
                  barcolor=MetBrewer::met.brewer("Kandinsky")[4],
                  fill=MetBrewer::met.brewer("Kandinsky")[4],
                  textcolor="white",
                  offset.text=55,geom='label') 
  p + geom_fruit(data=data,geom=geom_point,
      mapping = aes(y=family,x=age,color=age,fill=age),alpha=0.7,size=2,
      outlier.size=0.1,outlier.stroke=0.08,outlier.shape=21,
      axis.params=list(axis = "x",text.size = 1.8,hjust = 1,vjust = 0.5, nbreak = 3,),
      show.legend=TRUE,
      grid.params=list()) + 
    scale_fill_stepsn(colors=MetBrewer::met.brewer("Demuth"),n.breaks=20,
                          guide=guide_legend(label.position = "bottom", title.hjust = 0, nrow=1,
                          title.position = "top"),name="Age in years") +
    scale_color_stepsn(colors=MetBrewer::met.brewer("Demuth"),n.breaks=20,
                       guide=guide_legend(label.position = "bottom", title.hjust = 0,nrow=1,
                       title.position = "top"),name="Age in years") + 
    theme(legend.position=c(0.5,0.06),
          legend.margin=margin(0,0,0,0),
          legend.box.margin=margin(0,0,0,0),
          plot.margin = unit(c(0,0,0,0), "cm"),
          text = element_text(family="EB Garamond"),
          legend.title=element_text(size=10,family="EB Garamond"), 
          legend.text=element_text(size=7,family="EB Garamond"),
          plot.title=element_text(family="EB Garamond",face="bold",hjust = 0,size=18,vjust = -2),
          plot.caption = element_text(family="EB Garamond",face="italic",hjust = 0,size=8,vjust=5)) +
    NULL
