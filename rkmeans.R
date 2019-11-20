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



