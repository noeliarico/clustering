normalize <- function(x){((x-min(x))/(max(x)-min(x)))}

train_rkmeans <- function(points, cen, iter.max = 100) {
  points <- points %>% select(-cluster)
  points <- as_tibble(apply(points, 2, normalize))
  #print(head(points))
  
  #pb <- txtProgressBar(min = 0, max = 15)
  
  desired_length <- 14 # 13+2
  results <- vector(mode = "list", length = desired_length)
  
  for(i in 1:13) {
    #setTxtProgressBar(pb, i)
    set.seed(2020)
    out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = iter.max, nstart = 1, 
                           trace = FALSE, distances = 1:13, dist = i) 
    results[[i]] <- out_rkmeans
  }
  # 
  # setTxtProgressBar(pb, 14)
  # set.seed(2020)
  # out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1, 
  #                        trace = FALSE, distances = 1:13, dist = 101) 
  # results[[14]] <- out_rkmeans
  # 
  #setTxtProgressBar(pb, 15)
  set.seed(2020) # Borda count
  out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1, 
                         trace = FALSE, distances = 1:13, dist = 102) 
  results[[14]] <- out_rkmeans
  #close(pb)
  
  names(results) <- distances
  return(results)
}

distances <- c(
  # Lp Minkowski distance measures //////////////////////////////////////////////
  "manhattan", # 1
  "euclidean", # 2
  "chebyshev", # 3
  # L1 distance measures ////////////////////////////////////////////////////////
  "canberra", # 4
  "gower", # 5
  # Inner product distance measures /////////////////////////////////////////////
  "jaccard", # 6
  "cosine", # 7
  # Squared Chord distance measures /////////////////////////////////////////////
  "SqrdChrd", # 8
  "matusita", # 9
  # Squared L2 distance measures ////////////////////////////////////////////////
  "clark", # 10
  "trngDiscr", # 11
  # Vicissitude distance measures ///////////////////////////////////////////////
  "VSD3", # 12
  "maxSymmSq", # 13
  
  # Scoring distance functions
  #"plurality", # 101
  "bordaCount" # 102
)

distances <- c(
  # Lp Minkowski distance measures //////////////////////////////////////////////
  "manhattan", # 1
  "euclidean", # 2
  "chebyshev", # 3
  # L1 distance measures ////////////////////////////////////////////////////////
  "canberra", # 4
  "gower", # 5
  # Inner product distance measures /////////////////////////////////////////////
  "jaccard", # 6
  "cosine", # 7
  # Squared Chord distance measures /////////////////////////////////////////////
  "SqrdChrd", # 8
  "matusita", # 9
  # Squared L2 distance measures ////////////////////////////////////////////////
  "clark", # 10
  "trngDiscr", # 11
  # Vicissitude distance measures ///////////////////////////////////////////////
  "VSD3", # 12
  "maxSymmSq", # 13
  
  # Scoring distance functions
  #"plurality", # 101
  "bordaCount" # 102
)
