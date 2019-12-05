library(clusterlab)
set.seed(1)
random_generator <- function(centers, features) {
  desired_length <- length(2:8)*5 # 
  datasets <- vector(mode = "list", length = desired_length)
  ies <- rep(2:8, 5)
  seed <- 2020
  for (i in 1:length(ies)) {
    data <- clusterlab(centers = ies[i], # the number of clusters to simulate 
                      # the number of units of the radius of the circle on which the clusters are generated
                      r = 2, 
                      # the number of samples in each cluster
                      numbervec = sample(100:200, ies[i]),
                      # standard deviation of each cluster
                      sdvec = sample(1:ies[i], ies[i]),
                      # how many units to push each cluster away from the initial placement
                      alphas = sample(1:ies[i], ies[i]),
                      # the number of features for the data
                      features = ies[i],
                      seed = seed)
    seed <- seed + 1
    data <- t(data$synthetic_data)
    datasets[[i]] <- data
  }
  datasets
}

datasets <- random_generator()
