test_that("Euclidean distance - equal vectors", {
  skip("Euclidean distance - equal vectors")
  # Integer
  x <- c(1, 2, 3)
  y <- c(1, 2, 3)
  m <- matrix(c(x, y), byrow = T, ncol = length(x))
  
  expect_equal(as.numeric(dist(m)), dist_minkowski(x, y))
  
  # Float
  x <- c(1.3, 2.1, 3.6)
  y <- c(1.3, 2.1, 3.6)
  
  expect_equal(as.numeric(dist(m)), dist_minkowski(x, y))
  
  # Integer numbers
  for (zeros in 1:10) {
    for(i in 1:1000) { 
      x <- sample(1:10000, 1 * zeros, rep = T)
      m <- matrix(c(x, x), byrow = T, ncol = length(x))
      a <- as.numeric(dist(m))
      b <- dist_minkowski(x, x)
      # cat(a, " - ", b, "\n")
      expect_equal(a, b)
    }
    # cat("\n----- length vector = ", 1 * zeros, "\n")
  }
  
  # Decimal numbers
  for (zeros in 1:10) {
    for(i in 1:1000) { 
      x <- rnorm(1 * zeros)
      m <- matrix(c(x, x), byrow = T, ncol = length(x))
      a <- as.numeric(dist(m))
      b <- dist_minkowski(x, x)
      #cat(a, " - ", b, "\n")
      expect_equal(a, b)
    }
    cat("\n----- length vector = ", 1 * zeros, "\n")
  }
  
 
})

test_that("Euclidean distance - different vectors", {
  skip("Euclidean distance - equal vectors")
  
  # Integer
  x <- c(1, 2, 3)
  y <- c(1, 2, 3)
  m <- matrix(c(x, y), byrow = T, ncol = length(x))
  a <- as.numeric(dist(m))
  b <- dist_minkowski(x, y)
  # cat(a, " - ", b, "\n")
  
  
  expect_equal(a, b)
  
  # Float
  x <- c(1.3, 2.1, 3.6)
  y <- c(1.3, 2.1, 3.6)
  m <- matrix(c(x, y), byrow = T, ncol = length(x))
  
  expect_equal(as.numeric(dist(m)), dist_minkowski(x, y))
  
  # Integer numbers
  for (zeros in 1:10) {
    for(i in 1:1000) { 
      x <- sample(1:10000, 1 * zeros, rep = T)
      y <- sample(1:10000, 1 * zeros, rep = T)
      m <- matrix(c(x, y), byrow = T, ncol = length(x))
      a <- as.numeric(dist(m))
      b <- dist_minkowski(x, y)
      # cat(x, " - ", y, "\n")
      expect_equal(a, b)
    }
    cat("\n----- length vector = ", 1 * zeros, "\n")
  }
  
  # Float numbers
  for (zeros in 1:10) {
    for(i in 1:1000) { 
      x <- rnorm(1 * zeros)
      y <- rnorm(1 * zeros)
      m <- matrix(c(x, y), byrow = T, ncol = length(x))
      a <- as.numeric(dist(m))
      b <- dist_minkowski(x, y)
      if(1*zeros == 1)
        cat(x, " - ", y, "\n")
      expect_equal(a, b)
    }
    cat("\n----- length vector = ", 1 * zeros, "\n")
  }
})

test_that("Canberra distance - different vectors", {
  
  # Integer
  # x <- c(1, 2, 3)
  # y <- c(1, 2, 3)
  # m <- matrix(c(x, y), byrow = T, ncol = length(x))
  # a <- as.numeric(dist(m), method = "canberra")
  # b <- dist_canberra(x, y)
  # expect_equal(a, b)
  
  # Float
  # x <- c(1.3, 2.1, 3.6)
  # y <- c(1.3, 2.1, 3.6)
  # m <- matrix(c(x, y), byrow = T, ncol = length(x))
  # expect_equal(as.numeric(dist(m), method = "canberra"), dist_canberra(x, y))
  
  # Integer numbers
  # for (zeros in 1:1000) {
  #   for(i in 1:10) {
  #     x <- sample(1:10000, 1 * zeros, rep = T)
  #     y <- sample(1:10000, 1 * zeros, rep = T)
  #     m <- matrix(c(x, y), byrow = T, ncol = length(x))
  #     a <- as.numeric(dist(m, method = "canberra"))
  #     b <- dist_canberra(x, y)
  #     # cat(a, " - ", b, "\n")
  #     expect_equal(a, b)
  #   }
  # }
  
  # Float numbers
  for (zeros in 1:1) {
    for(i in 1:10) {
      x <- rnorm(1 * zeros)
      y <- rnorm(1 * zeros)
      cat("\n x and y:", x, " -- ", y, "\n")
      m <- matrix(c(x, y), byrow = T, ncol = length(x))
      a <- as.numeric(dist(m, method = "canberra"))
      b <- dist_canberra(x, y)
      cat("a and b: ", a, " - ", b, "\n")
      expect_equal(a, b)
    }
  }

})



# geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "segment"), data = df)