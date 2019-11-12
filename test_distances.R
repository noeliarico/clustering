x <- c(1, 2, 3)
y <- c(1, 2, 3)
m <- matrix(c(x, y), byrow = T, ncol = length(x))
as.numeric(dist(m))
minkowski_distance(x, y)

x <- c(3, 5, 8, 1)
test_that(minkoski_distance,
          )