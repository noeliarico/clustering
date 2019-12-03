library(clusterlab)
set.seed(1)
random_generator <- function(centers, features) {
  desired_length <- 6 # 13+2
  datasets <- vector(mode = "list", length = desired_length)
  set.seed(2020)
  for (i in 2:8) {
    data <- clusterlab(centers = i+1, # the number of clusters to simulate 
                      # the number of units of the radius of the circle on which the clusters are generated
                      r = 2, 
                      # the number of samples in each cluster
                      numbervec = sample(100:200, 5),
                      # standard deviation of each cluster
                      sdvec = sample(1:5, 5),
                      # how many units to push each cluster away from the initial placement
                      alphas = sample(1:5, 5),
                      # the number of features for the data
                      features = i,
                      seed = 1234)
    data <- t(data1$synthetic_data)
    datasets[[i-1]] <- data
  }
  datasets
}

datasets <- random_generator()
