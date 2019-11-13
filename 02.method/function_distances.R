dyn.load("02.method/distances.so")

dist_minkowski <- function(x, y, p = 2) {
  out <- .C("dist_minkowski", x = as.double(x), 
                          y = as.double(y), 
                          n = as.integer(length(x)), 
                          p = as.integer(p), 
                          result = as.double(0))
  return(out$result)
}


dist_canberra <- function(x, y, p = 2) {
  out <- .C("dist_canberra", x = as.double(x), 
            y = as.double(y), 
            n = as.integer(length(x)), 
            result = as.double(0))
  return(out$result)
}

dist_cosine <- function(x, y, p = 2) {
  out <- .C("dist_cosine", x = as.double(x), 
            y = as.double(y), 
            n = as.integer(length(x)), 
            result = as.double(0))
  return(out$result)
}
