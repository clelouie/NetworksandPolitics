library(igraph)

df <- read.csv('vu_psci_coauthors_2022.csv')

nw <- graph_from_data_frame(df, directed = FALSE)

# Which node has the highest degree?
## John Clinton, degree 5

degree(nw)

# Which node has the highest eigenvector centrality?
## Brett Benson, eigenvector centrality 0.8402173
# Which node has the second highest eigenvector centrality?
## John Geer, 0.6888023

eigen_centrality(nw)$vector

# What is the length of the shortest path between Kenkel and Coe?
## 2
# What is the length of the shortest path between Schram and Kam?
## 5

distmat <- distances(nw)

# What do the infs in the distance matrix for the Bisbee and the Larson rows mean?
## There is no path between them.

# How many components are there in this network?
## 2 components

components (nw)

# What is the diameter of the largest component of this network?
## 7

diameter(nw)

# What code would you use if you wanted to add one of the professors who 
# joined Vanderbilt’s faculty after 2022, for instance Jessica Trounstine?
# Add a Jessica Trounstine node and make a visualization of the resulting network.

nw_updated <- add_vertices(nw, 1, name = 'Jessica Trounstine')
plot(nw_updated)