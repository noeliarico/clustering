# Synthetic 2-d data with N = 5000 vectors and k = 15 
# Gaussian clusters with different degree of cluster overlap

# @article{Ssets,
#   author  = {P. Fr\"anti and O. Virmajoki},
#     title   = {Iterative shrinking method for clustering problems},
#     journal = {Pattern Recognition},
#     year    = {2006},
#     volume  = {39},
#     number  = {5},
#     pages   = {761--765},
#     doi     = {10.1016/j.patcog.2005.09.012},
#     url     = {http://dx.doi.org/10.1016/j.patcog.2005.09.012}
# }

s1 <- read.table("datasets/files/s1.txt")
save(s1, file = "datasets/objects/s1.RData")
s2 <- read.table("datasets/files/s2.txt")
save(s2, file = "datasets/objects/s2.RData")
s3 <- read.table("datasets/files/s3.txt")
save(s3, file = "datasets/objects/s3.RData")
s4 <- read.table("datasets/files/s4.txt")
save(s4, file = "datasets/objects/s4.RData")

# Synthetic 2-d data with increasing number of clusters (k). 
# There are 150 vectors per cluster.

# @TECHREPORT{Asets,
#   author = {I. K\"arkk\"ainen and P. Fr\"anti},
#   title = {Dynamic local search algorithm for the clustering problem},
#   institution = {Department of Computer Science, University of Joensuu},
#   address = {Joensuu, Finland},
#   number = {A-2002-6},
#   year = {2002}
# }

a1 <- read.table("datasets/files/a1.txt")
save(a1, file = "datasets/objects/a1.RData")
a2 <- read.table("datasets/files/a2.txt")
save(a2, file = "datasets/objects/a2.RData")
a3 <- read.table("datasets/files/a3.txt")
save(a3, file = "datasets/objects/a3.RData")

