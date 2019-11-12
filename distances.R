dyn.load("method/distances.so")
minkowski_distance <- function(x, y) {
  .C("minkoski_distance", x = as.double(x), 
                          y = as.double(y), 
                          n = as.integer(length(x)), 
                          r = as.integer(length(y)), 
                          result = 0)$result
}
