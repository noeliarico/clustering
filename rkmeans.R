rkmeans <- function(data, k, ncenters, maxiter) {
  .C("rkmeans",
     x = as.matrix(data),
     pn = as.integer(nrow(data)),
     pp = as.integer(ncol(data)),
     cen = as.integer(ncenters),
     pk = as.integer(k),
     cl = as.integer(ncenters),
     pmaxiter = as.integer(maxiter),
     nc = integer(k),
     wss = double(k) 
     )
}

dyn.load("02.method/rkmeans/rkmeans.so")

si <- iris[c(1,2,3,4,50,51,52,53,100,101,102,103),-5]

out <- rkmeans(si, 3, 3, 5)

set.seed(2020)
out <- rkmeans(x = points, centers = 3, iter.max = 5, nstart = 1, trace = FALSE) 

