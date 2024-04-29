library(igraph)
library(dplyr)

setwd("~/Documents/GitHub/NetworksandPolitics/finalProject")

fig1 <- read.csv("fig1edges.csv")
fig1nw <- graph_from_data_frame(fig1, directed = FALSE)

master <- read.csv("fig1nodes.csv")
cluster <- as.data.frame(transitivity(fig1nw, "local"))
closeness <- as.data.frame(closeness(fig1nw))
eigen <- as.data.frame(eigen_centrality(fig1nw)$vector)
degree <- as.data.frame(degree(fig1nw, normalized = TRUE))

cluster$Id <- as.numeric(rownames(cluster))
closeness$Id <- as.numeric(rownames(closeness))
eigen$Id <- as.numeric(rownames(eigen))
degree$Id <- as.numeric(rownames(degree))

master <- left_join(master, cluster, by=join_by(Id==Id))
master <- left_join(master, closeness, by=join_by(Id==Id))
master <- left_join(master, eigen, by=join_by(Id==Id))
master <- left_join(master, degree, by=join_by(Id==Id))

write.csv(master, file="fig1nw_measures.csv")

fig2 <- read.csv("fig2edges.csv")
fig2nw <- graph_from_data_frame(fig2, directed = FALSE)

transitivity(fig1nw)
transitivity(fig2nw)

vertex_connectivity(fig1nw)
vertex_connectivity(fig2nw)



