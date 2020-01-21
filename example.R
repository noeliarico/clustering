# Import the necessary libraries
library(clusterlab)
library(tidyverse)

# Some illustrative seeds after a manual exploration
# 1830 With this seed the distance with the worst performance is Euclidean dsitance
# 2456
# 1617
# Set the seed
the_seed <- 2456
# Create a dataset of 2 varibles with 5 clustes of three points each
data <- clusterlab(centers = 5, # the number of clusters to simulate 
                   # the number of units of the radius of the circle on which the clusters are generated
                   r = 2, 
                   # the number of samples in each cluster
                   numbervec = c(3, 3, 3, 3, 3),
                   # standard deviation of each cluster
                   sdvec = c(1, 3, 2, 1, 1),
                   alphas = c(3, 5, 1, 4, 2),
                   # the number of features for the data
                   features = 2,
                   seed = the_seed, showplots = FALSE)
(points <- as_tibble(t(data$synthetic_data)) %>% rename(x = 1, y = 2))

# Add column with the real cluster
points <- points %>% mutate(cluster = data$identity_matrix$cluster)
# The data is not normalized because this is already done in train_rkmeans

# Load the c methods that implements the distances and rkmeans
dyn.load("02.method/distances/distances.so")
dyn.load("02.method/rkmeans/rkmeans.so")

# Clustering with rkmeans
set.seed(the_seed)
out_points <- train_rkmeans(points, 5, iter.max = 5)
errors <- calculate_errors(out_points)
errors <- sorted_errors_by_dataset(errors)
rankingsOfErrors <- lapply(errors, ranking)
rankingsOfErrors <- profile_of_rankings(Reduce(bind_rows, rankingsOfErrors))
rankingsOfErrors_borda <- borda_count(rankingsOfErrors)



