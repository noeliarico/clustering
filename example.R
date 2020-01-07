library(clusterlab)
library(tidyverse)

# 1830 la peor es Euclídea!!!!
#2456
#1617
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

#normalize <- function(x){((x-min(x))/(max(x)-min(x)))} # ya se hace en el train_rkmeans
#points <- as_tibble(apply(points, 2, normalize))
points <- points %>% mutate(cluster = data$identity_matrix$cluster)
#ggplot(points, aes(x, y)) + geom_point(aes(color = cluster), size = 6) + theme_light()

dyn.load("02.method/distances/distances.so")
dyn.load("02.method/rkmeans/rkmeans.so")

#for(n in 1:5000) {
# Clustering with rkmeans
set.seed(the_seed)
out_points <- train_rkmeans(points, 5, 5)
errors <- calculate_errors(out_points)
errors <- sorted_errors_by_dataset(errors)
rankingsOfErrors <- lapply(errors, ranking)
rankingsOfErrors <- profile_of_rankings(Reduce(bind_rows, rankingsOfErrors))
rankingsOfErrors_borda <- borda_count(rankingsOfErrors)



