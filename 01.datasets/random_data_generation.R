random_data_generator <- function(mink = 2, maxk = 5, 
                                  maxnfeatures = 5, 
                                  the_seed = 2020) {
  
  # For each value of k, datasets with all the posible number of features from
  # 2 to maxnfeatures are generated. That is a total of desired_length datasets
  desired_length <- length(mink:maxk) * (maxnfeatures-1) #* length(featu)
  print(paste("A total of", desired_length, "datasets will be generated."))
  datasets <- vector(mode = "list", length = desired_length)
  
  # 
  ies <- mink:maxk
  seed <- the_seed # the seed is fixed in the clusterlab method
  
  index <- 1 # index of the position in the list "datasets" where the
  # new dataset must be stored
  
  for(i in ies) {
    # For this k generate datasets with different number of features
    for(f in 2:maxnfeatures) {
      data <- clusterlab(centers = i, # the number of clusters to simulate
                        # the number of units of the radius of the circle on 
                        # which the clusters are generated
                        r = 2,
                        # the number of samples in each cluster
                        # take a random value between 100 and 200 for each
                        # of the cluster (k times)
                        numbervec = sample(100:200, i),
                        # standard deviation of each cluster
                        sdvec = sample(1:i, i),
                        # how many units to push each cluster away from the initial placement
                        alphas = sample(1:i, i),
                        # the number of features for the data
                        features = f,
                        seed = seed)
      seed <- seed + 1 # increase the value of the seed
      
      # Add to the data the real cluster and generate a tibble
      datac <- as_tibble(t(data$synthetic_data)) %>% 
        mutate(cluster = as.factor(data$identity_matrix$cluster))

      # Store the data in the list and setup for the next iteration
      datasets[[index]] <- datac
      index <- index + 1
      print(paste0("k = ",i,"; f = ",f))
    }
  }
  
  ies <- rep(mink:maxk, each = maxnfeatures-1) 
  # Store in the variable nm the names of the datasets which have the structure
  # data_kNUMBEROFCLUSTERSfNUMBEROFFEATURES
  nm <- paste0("data_k", ies, "f", 
               rep(2:maxnfeatures, length(ies)/(maxnfeatures-1)))
  names(datasets) <- nm
  
  return(datasets)
}

# Generate dataset from k = 2 to k = 10 (both included) . For each value of k, dataset with
# different number of features will be generated, concretely, from nfeatures = 2
# to nfeatures = 10 both included. This makes a total of 81 datasets.
datasets <- random_data_generator(mink = 2, maxk = 10, maxnfeatures = 10)
saveRDS(datasets, "01.datasets/generated_data/datasets.RData")
