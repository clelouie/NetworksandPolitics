## EXAMPLE CODE from professor (aka not mine)
## Created by Professor Jennifer Larson
## Orginal document begins below

#################################################################################

## Intro to network data in R, Part I
## Networks and Politics
## Professor Larson
## March 18, 2024
## Updated:

#################################################################################
## This is a file of R code.  Everything written on a line that follows the pound
## sign, aka number symbol, "#", is "commented out."  That means these are 
## notes that will not be confused for commends by R.

## The first thing we need to do is to tell R where on our computer to look when
## we tell it to import things like datasets.  This is called setting the working directory.

## You can do this manually, but looking up the path to the folder where you want
## to work and entering it inside quotation marks in the setwd() command.  
## For my computer, that will be:


setwd("~/Documents/GitHub/NetworksandPolitics")


## If you are using R within RStudio, there's an easier way.  In the window on the lower
## right, choose the Files tab, then click through the linked file names until you see the
## contents inside the folder you want to use as your working directory.  Click More, then
## Set as Working Directory.  The same line of code will appear on the console below.

## Next we need to install and load any packages that we want R to use.  For networks work,
## we'll want the package igraph.  First we install it.  We only have to do this step once per
## computer, so the first time, uncomment (delete the "#") the install.packages command and run
## it.  Then each time we start a new R session, we simply load it with the library(igraph) 
## command.



#install.packages("igraph")
library(igraph)









######################################################################################
## Getting started in R

## Some preliminary work in R

## R is an object-oriented language, which means you can create and store objects
## in R's working memory.  These objects can be single numbers, such as

num <- 6

## We've assigned the number 6 to the label "num".  To see what "num" represents,
## we can simply call it:

num

## And to see what type of object it is, we can explore with the function class()
class(num)

## We can also create a vector using the concatenation script c()

vec <- c(4,6,-7, 2.1, 18, 1001)

## Now vec is a vector.  How many elements are in vec?

length(vec)

## Yep, 6.  





## We can also create a multidimensional object such as a matrix.  We can make a 
## matrix by calling the matrix() function:

mat <- matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), byrow = TRUE, nrow = 3)

mat



## We can learn the dimensions of bear, the number of rows and columns
## it has, with the function dim()

dim(mat)

## Notice what changes if we tell R NOT to fill the matrix by the row:


mat <- matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), byrow = FALSE, nrow = 3)

mat

dim(mat)

## Or if we change the number of rows:

mat <- matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), byrow = FALSE, nrow = 4)

mat

dim(mat)




## Another way to create a matrix is to bind vectors together either side
## by side or stacked on top of one another.  Let's keep vec and make another
## vector the same length:

vec2 <- c(4,44,1,0,3,3)

## Now we can either bind the vectors together as columns:

newmat1 <- cbind(vec,vec2)
newmat1
dim(newmat1)

## Or we can bind them together as rows:

newmat2 <- rbind(vec, vec2)
newmat2
dim(newmat2)




## One of the most useful features in R, especially when working with data of any
## kind, including network data, is the ability to subset.  We can pull out
## a subset of an object by telling R which entries we want to keep in the case of a
## vector, or which rows and columns worth of entries we want to keep in the case of
## a multidimensional object such as a matrix or data frame.

## We use the square brackets to subset an object.  When that object has only
## one dimension, like a vector, we can indicate the subset with a one-dimensional
## request.  Positive numbers indicate entries to keep, negative numbers indicate 
## entries to omit.  


vec
vec[1]
vec[4]
vec[-1]
vec[-4]

vec3 <- vec[-4]

## We can grab or omit more than one entry by specifying a vector of entries:

vec[c(1,4)]

vec[-c(1,4)]


## These functions don't alter the underlying object, so 
## if you want their effect to be permanent, you need to save the result as a
## new object:

vec

newvec <- vec[-c(1,4)]

newvec

## When the object has two dimensions, such as a matrix or a dataframe, we
## need to specify our request in two dimensions: the row and the column.

mat[1,3]

## We can also grab more than one thing in each dimension by specifying the subset
## with a vector:

mat[c(1,3), 3]

mat[3, c(1,3)]

mat[c(1,3), c(1,3)]

mat[-c(1,3),3]

## If we leave one of the dimensions blank, we include everything in that dimension:

mat[,3]

mat[3,]







#################################################################################

## Now, let's work with networks.  

## First we'll cover the case where we want to enter all the netowrk
## information natively into R (as opposed to importing the information 
## from a file external to R).




## Let's create a matrix that represents the edgelist for figure 8.1 (book Ch 8).

## We will create a 2 column matrix where each row indicates a link.
## We can enter all the link information separated by commas and then indicate
## that we mean for there to be two columns and for the data to be filled in
## across each row (as opposed to down each column).

## It can be helpful to use line breaks to keep track of our links, like this:


el <- matrix(c(1,2,
               2,3,
               2,4,
               2,6,
               4,5,
               4,6,
               6,7,
               6,5,
               5,8,
               8,9,
               8,10,
               9,10,
               9,11),
             byrow = TRUE, ncol = 2)

## though we could have entered the links all on one line, like this:

el <- matrix(c(1,2, 2,3, 2,4, 2,6, 4,5, 4,6, 6,7, 6,5, 5,8, 8,9, 8,10, 9,10, 9,11),
             byrow = TRUE, ncol = 2)

## Now we have a matrix that contains our link information in edgelist form.


## Next, we can use a function from the igraph package that will turn this
## into an object that R understands to be a network.


## It takes an argument that we can set to TRUE or FALSE that indicates whether
## our links have direction.

nw <- graph_from_edgelist(el, directed = FALSE)  


## Let's see what class this object is:

class(nw)

## igraph means this is an igraph object, which means it's a network.  



## We can take a quick look at the network by calling R's plot function:

plot(nw) 

## We can see how many nodes and links it has with:

vcount(nw)

ecount(nw)


## Now, we can use additional igraph functions to calculate some of the 
## structural features we learned in the first problem set (and covered in 
## the Larson book, Ch2):

## For example, let's calculate the degree of every node:


degree(nw)


## And the degree centrality of every node:

degree(nw, normalized = TRUE)



## If we just want the degree centrality of a particular node, for instance node 4, 
## we can use:

degree(nw, v = 4, normalized = TRUE)



## And the same for betweenness centrality

betweenness(nw, normalized = TRUE)

## These values can be easier to compare if we round them to fewer decimal
## places.  Let's round to two:

round(betweenness(nw, normalized = TRUE),2)



## And now, the elusive eigenvector centrality:

eigen_centrality(nw)$vector

round(eigen_centrality(nw)$vector, 2)


## And the closeness centrality

round(closeness(nw, normalized = TRUE),2)





## And distances between nodes

## To find the shortest path lengths between any two nodes:

## Let's save the output as an object called "distmat" for distances matrix.

distmat <- distances(nw, mode = "all")


distmat

## If I had more than 11 nodes, this would get cumbersome to look at all at
## once.  I could look at a piece, for instance just the first 5 rows and columns,
## with 

distmat[1:5, 1:5]

## And we could either use this information to determine the diameter,
## or we could calculate it directly with:

diameter(nw)

## And we can learn information about the components in this network with:

components(nw)





## Lastly, what if we want to add a node to the network after the fact?
## This could be either because we have new information now, or because
## the node was an isoalte and, having no links, did not appear in the 
## edgelist.

## We can do this with the function add_vertices()

## Let's add 1 node ("vertex")

nw_updated <- add_vertices(nw, 1)

## Let's add 3 nodes, overwriting our nw_updated with this one:

nw_updated <- add_vertices(nw, 3)
plot(nw_updated)

## Now let's add a link ("edge") between nodes 13 and 14:

nw_updated_again <- add_edges(nw_updated, edges = c(13, 14))
plot(nw_updated_again)


## What do the shortest paths look like in this new network?

distances(nw_updated_again, mode = "all")

## Notice the Inf, which stands for infinity







## What if we want these nodes to have names?

V(nw_updated_again)

vcount(nw_updated_again)

## Names are one example of a vertex attribute that we can store in our 
## network object.  We can call our attribute whatever we'd like, but 
## the one called "name" is understood as the label of the nodes and will
## show up in plots.

V(nw_updated_again)$name <- c("Lu", "Seth", "Mary", "Chae",
                              "Agnes", "Hike", "Anand", "Mick",
                              "Victor", "Karen", "Ayeh", "Jesus",
                              "Sidharth", "Bob")


plot(nw_updated_again)

## The attribute called "name" can also be used as the indicator for which
## node something should be calculated for

degree(nw_updated_again, v = "Hike")


V(nw_updated_again)








#############
## Looking ahead:


## What if instead we want to create a network that has its links added at random
## e.g. we want an Erdos-Renyi random network?

## igraph has a function for that.  It's called erdos.renyi.game()

## There are two ways to use it.  One specifies the total number of nodes, and
## the (single, common) probability of a link forming between every pair of nodes.

nw_rnd1 <- erdos.renyi.game(50, .2)

vcount(nw_rnd1)
ecount(nw_rnd1) 

plot(nw_rnd1)


## Here's one with a higher probability of link formation:
nw_rnd2 <- erdos.renyi.game(50, .4)

vcount(nw_rnd2)
ecount(nw_rnd2) 

plot(nw_rnd2)


## The second way again specifies the number of nodes, but also the exact number
## of links to be added at random.  To use the function in this way, the type
## argument must be used and set to "gnm"

nw_rnd3 <- erdos.renyi.game(50, 275, type = "gnm")

vcount(nw_rnd3)
ecount(nw_rnd3) 

plot(nw_rnd3)





