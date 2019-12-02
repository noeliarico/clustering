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


dyn.load("02.method/rkmeans/rkmeans.so")
set.seed(2020)
out_rkmeans1 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = c(1, 2, 3, 4, 5), dist = 1) 

set.seed(2020)
out_rkmeans2 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = c(1, 2, 3, 4, 5), dist = 2) 

set.seed(2020)
out_rkmeans4 <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE, distances = c(1, 2, 3, 4, 5), dist = 4) 
