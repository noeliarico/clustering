# rkmeans <- function(data, k, ncenters, maxiter) {
#   .C("rkmeans",
#      x = as.matrix(data),
#      pn = as.integer(nrow(data)),
#      pp = as.integer(ncol(data)),
#      cen = as.integer(ncenters),
#      pk = as.integer(k),
#      cl = as.integer(ncenters),
#      pmaxiter = as.integer(maxiter),
#      nc = integer(k),
#      wss = double(k) 
#      )
# }

dyn.load("02.method/distances/distances.so")
dyn.load("02.method/rkmeans/rkmeans.so")



#si <- iris[c(1,2,3,4,50,51,52,53,100,101,102,103),-5]

#out <- rkmeans(si, 3, 3, 5)

set.seed(2020)
out_rkmeans <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 10, trace = FALSE) 

set.seed(2020)
out_kmeans <- kmeans(x = points, centers = 3, iter.max = 5, nstart = 1, algorithm = "Lloyd", trace = FALSE)

# con la inicializacion aleatoria de los clusters da distinto orden
expect_identical(out_rkmeans$cluster, out_kmeans$cluster)
expect_identical(out_rkmeans$centers, out_kmeans$centers)
expect_identical(out_rkmeans$totss, out_kmeans$totss)
expect_identical(out_rkmeans$withinss, out_kmeans$withinss)
expect_identical(out_rkmeans$tot.withinss, out_kmeans$tot.withinss)
expect_identical(out_rkmeans$betweenss, out_kmeans$betweenss)
expect_identical(out_rkmeans$size, out_kmeans$size)
expect_identical(out_rkmeans$iter, out_kmeans$iter)
expect_identical(out_rkmeans$ifault, out_kmeans$ifault)

library(clusterlab)
data <- clusterlab(centers = 3, # the number of clusters to simulate 
                   # the number of units of the radius of the circle on which the clusters are generated
                   r = 2, 
                   # the number of samples in each cluster
                   numbervec = c(4, 4, 4),
                   # standard deviation of each cluster
                   sdvec = c(1, 3, 2),
                   # how many units to push each cluster away from the initial placement
                   alphas = c(3, 5, 1),
                   # the number of features for the data
                   features = 2,
                   seed = 1234)
(points <- as.tibble(t(data$synthetic_data)) %>% rename(x = 1, y = 2))
normalize <- function(x){((x-min(x))/(max(x)-min(x)))}
points <- as_tibble(apply(points, 2, normalize))

centers <- c(0, 0.120, 1, 0.694, 0.342, 1)
centers <- matrix(centers, byrow = TRUE, ncol = 2)

dyn.load("02.method/rkmeans/rkmeans.so")
savehistory(file = ".Rhistory")
set.seed(2020)
out_rkmeans1 <- rkmeans(x = points, centers = 2, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 101) 

set.seed(2020)
out_rkmeans2 <- rkmeans(x = points, centers = centers, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 2) 

set.seed(2020)
out_rkmeans3 <- rkmeans(x = points, centers = centers, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 3) 

set.seed(2020)
out_rkmeans4 <- rkmeans(x = points, centers = centers, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 4) 

set.seed(2020)
out_rkmeans4 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 5) 

set.seed(2020)
out_rkmeans4 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 6) 

set.seed(2020)
out_rkmeans4 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 7)

set.seed(2020)
out_rkmeans4 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 8) 

set.seed(2020)
out_rkmeans4 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 9) 

set.seed(2020)
out_rkmeans4 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 10)

set.seed(2020)
out_rkmeans4 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = 1:13, dist = 11) 

