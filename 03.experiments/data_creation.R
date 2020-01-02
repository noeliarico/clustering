library(clusterlab)
set.seed(1)
random_generator <- function(mink = 2, maxk = 5, maxnfeatures = 5, the_seed = 2020) {
  #featu <- seq(2, 55, 10)
  desired_length <- length(mink:maxk) * (maxnfeatures-1) #* length(featu)
  print(paste0("Desired length: ", desired_length))
  datasets <- vector(mode = "list", length = desired_length)
  #ies <- rep(mink:maxk, each = maxnfeatures) # descomentar para las repeticiones
  ies <- mink:maxk
  seed <- the_seed
  print(ies)
  index <- 1
  for(i in ies) {
    for(f in 2:maxnfeatures) {
      data <- clusterlab(centers = i, # the number of clusters to simulate
                        # the number of units of the radius of the circle on which the clusters are generated
                        r = 2,
                        # the number of samples in each cluster
                        numbervec = sample(100:200, i),
                        # standard deviation of each cluster
                        sdvec = sample(1:i, i),
                        # how many units to push each cluster away from the initial placement
                        alphas = sample(1:i, i),
                        # the number of features for the data
                        features = f,
                        seed = seed)
      seed <- seed + 1
      datac <- as_tibble(t(data$synthetic_data)) %>% mutate(cluster = as.factor(data$identity_matrix$cluster))

      datasets[[index]] <- datac
      index <- index + 1
      print(paste0("k = ",i,"; f = ",f))
    }
  }
  # names(datasets) <- paste0(paste0("data_k", ies, "r", rep(1 maxnfeatures, maxnfeatures)), paste0("f", 2:10))
  ies <- rep(mink:maxk, each = maxnfeatures-1) 
  nm <- paste0("data_k", ies, "f", rep(2:maxnfeatures, length(ies)/(maxnfeatures-1)))
  print(nm)
  names(datasets) <- nm
  datasets
}

datasets <- random_generator(mink = 2, maxk = 10, maxnfeatures = 10)
saveRDS(datasets, "clustering_web/datasets.rds")
