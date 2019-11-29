#  File src/library/stats/R/kmeans.R
#  Part of the R package, https://www.R-project.org
#
#  Copyright (C) 1995-2015 The R Core Team
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  https://www.R-project.org/Licenses/

rkmeans <-
  function(x, centers, iter.max = 10L, nstart = 1L, trace = FALSE)
  {
    #.Mimax <- .Machine$integer.max
    Crkmeans <- function() {
      Z <- .C("rkmeans", x, nobjects, nvariables,
                   centers = centers, k,
                   c1 = integer(nobjects), iter = iter.max,
                   nc = integer(k), wss = double(k))
      if(any(Z$nc == 0)) {
        warning("empty cluster: try a better set of initial centers",
                call. = FALSE)
        Z$ifault <- 2L
      }
      if(Z$iter > iter.max) {
        warning(sprintf(ngettext(iter.max,
                                 "did not converge in %d iteration",
                                 "did not converge in %d iterations"),
                        iter.max), call. = FALSE, domain = NA)
      }
      Z
    }
    
    x <- as.matrix(x) # data to matrix so it can be used in C
    
    ## as.integer(<too large>) gives NA ==> not allowing too large nrow() / ncol():
    nobjects <- as.integer(nrow(x)); if(is.na(nobjects)) stop("Too much objects")
    nvariables <- as.integer(ncol(x)); if(is.na(nvariables)) stop("Too much variables")
    
    # Check if the parameter centers is valid
    if(missing(centers))
      stop("'centers' must be a number or a matrix")
    
    storage.mode(x) <- "double"
    if(length(centers) == 1L) { # If the center is a number then we create random centers
      k <- centers
      
      ## we need to avoid duplicates here
      if(nstart == 1L)
        centers <- x[sample.int(nobjects, k), , drop = FALSE]
      if(nstart >= 2L || any(duplicated(centers))) {
        cn <- unique(x)
        mm <- nrow(cn)
        if(mm < k)
          stop("more cluster centers than distinct data points.")
        centers <- cn[sample.int(mm, k), , drop=FALSE]
      }
    } else {
      centers <- as.matrix(centers)
      if(any(duplicated(centers)))
        stop("initial centers are not distinct")
      cn <- NULL
      k <- nrow(centers)
      if(nobjects < k)
        stop("more cluster centers than data points")
    }
    
    print("The centers:")
    print(centers)
    
    k <- as.integer(k)
    if(is.na(k)) stop("'invalid value of 'k'")
    
    #if (k == 1L) nmeth <- 3L # Hartigan-Wong, (Fortran) needs k > 1
    iter.max <- as.integer(iter.max)
    if(is.na(iter.max) || iter.max < 1L) stop("'iter.max' must be positive")
    if(ncol(x) != ncol(centers))
      stop("must have same number of columns in 'x' and 'centers'")
    storage.mode(centers) <- "double"
    
    
    Z <- Crkmeans()
    
    #Z$iter <- Z$iter -1 # noelia
    
    best <- sum(Z$wss)
    if(nstart >= 2L && !is.null(cn))
      for(i in 2:nstart) {
        centers <- cn[sample.int(mm, k), , drop=FALSE]
        ZZ <- Crkmeans()
        if((z <- sum(ZZ$wss)) < best) {
          Z <- ZZ
          best <- z
        }
      }
    centers <- matrix(Z$centers, k)
    dimnames(centers) <- list(1L:k, dimnames(x)[[2L]])
    cluster <- Z$c1
    if(!is.null(rn <- rownames(x)))
      names(cluster) <- rn
    totss <- sum(scale(x, scale = FALSE)^2)
    structure(list(cluster = cluster, centers = centers, totss = totss,
                   withinss = Z$wss, tot.withinss = best,
                   betweenss = totss - best, size = Z$nc,
                   iter = Z$iter, ifault = Z$ifault),
              class = "kmeans")
  }

## modelled on print methods in the cluster package
print.rkmeans <- function(x, ...)
{
  cat("K-means clustering with ", length(x$size), " clusters of sizes ",
      paste(x$size, collapse = ", "), "\n", sep = "")
  cat("\nCluster means:\n")
  print(x$centers, ...)
  cat("\nClustering vector:\n")
  print(x$cluster, ...)
  cat("\nWithin cluster sum of squares by cluster:\n")
  print(x$withinss, ...)
  ratio <- sprintf(" (between_SS / total_SS = %5.1f %%)\n",
                   100 * x$betweenss/x$totss)
  cat(sub(".", getOption("OutDec"), ratio, fixed = TRUE),
      "Available components:\n", sep = "\n")
  print(names(x))
  if(!is.null(x$ifault) && x$ifault == 2L)
    cat("Warning: did *not* converge in specified number of iterations\n")
  invisible(x)
}

fitted.kmeans <- function(object, method = c("centers", "classes"), ...)
{
  method <- match.arg(method)
  if (method == "centers") object$centers[object$cl, , drop = FALSE]
  else object$cl
}