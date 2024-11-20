
# Libraries
library(tidyverse)
#library(patchwork)
#library(hrbrthemes)
#library(circlize)
library(networkD3)
library(dplyr) 

par(cex = 0.90, mar = c(0, 0, 0, 0))

#mat <- read.csv(file = 'final.csv',row.names = 1, header= TRUE)



# Define the "data" for the digram is "matrix" from above
data <- read.csv(file = 'cvd-os-ints-docs.csv',row.names = 1, header= TRUE)


# Reshape data to long format 
data_long <- data %>%
  rownames_to_column %>%
  gather(key = 'key', value = 'value', -rowname) %>%
  filter(value > 0)

colnames(data_long) <- c("source", "target", "value")
data_long$target <- paste(data_long$target, " ", sep="")






# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes <- data.frame(name=c(as.character(data_long$source),
                           as.character(data_long$target)) %>%
                      unique()
)


# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
data_long$IDsource=match(data_long$source, nodes$name)-1 
data_long$IDtarget=match(data_long$target, nodes$name)-1


# Prepare colour scale (7-class Blues, 7-class Greens, 7-class YlOrRd)
ColourScal ='d3.scaleOrdinal() .range(["#084594","#2171b5","#4292c6",
"#6baed6","#9ecae1","#c6dbef","#238b45","#41ab5d","#74c476","#b10026", "#fc4e2a","#ffffb2"])'


# Make the Network
##### set "iterations=0" to avoid automatic assignment of the box order
sankeyNetwork(Links = data_long, Nodes = nodes,
              Source = "IDsource", Target = "IDtarget",
              Value = "value", NodeID = "name", 
              sinksRight=FALSE, colourScale=ColourScal, 
              nodeWidth=40, fontSize=13, nodePadding=20,
              iterations=0
)


