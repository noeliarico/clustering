selected_distances <- c(1:15)[!(c(1:15) %in% c(5,8,13))]

distances <- c(
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
