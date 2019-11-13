dyn.load("prueba.so")

ranking <- as.integer(c(1, 3, 2, 1, 4))
points <- integer(5)

add <- function(a, b) {
  .Call("sumnoelia", 3, 3)
}


add(5, 6)

load("../knnrr/results.RData")
