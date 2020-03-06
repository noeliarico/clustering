distance <- function(data, distance = "euc", from = 1, to = 2) {
  available_distances <- c(
    # Lp Minkowski distance measures //////////////////////////////////////////////
    "man", # 1 - manhattan
    "euc", # 2 - euclidean
    "che", # 3 - chebyshev
    # L1 distance measures ////////////////////////////////////////////////////////
    "can", # 4 - canberra
    "gow", # 5 - gower
    # Inner product distance measures /////////////////////////////////////////////
    "jac", # 6 - jaccard
    "cos", # 7 - cosine
    # Squared Chord distance measures /////////////////////////////////////////////
    "sqc", # 8 - SqrdChrd
    "mat", # 9 - matusita
    # Squared L2 distance measures ////////////////////////////////////////////////
    "cla", # 10 - clark
    "ney", # 11 - neyman
    "pea", # 12 - pearson
    "tri", # 13 - trngDiscr
    # Vicissitude distance measures ///////////////////////////////////////////////
    "vsd", # 14 - VSD3
    "msc", # 15 - maxSymmSq
    
    # Scoring distance functions
    #"plurality", # 101
    "bordaCount" # 102
  )
  if(!(distance %in% available_distances)) {
    stop("The distance is not available")
  }
  else {
    if(!is.matrix(data)) {
      data <- as.matrix(data)
    }
    distance <- which(available_distances == distance)
    dist <- .C("distance_measure2",
               distance = as.integer(distance),
               data,
               as.integer(ncol(data)),
               as.integer(nrow(data)),
               as.integer(from),
               as.integer(to),
               as.integer(0),
               numeric(3),
               result = 0);
    return(dist$result)
  }
}

distance(toy_data %>% select(-cluster))


