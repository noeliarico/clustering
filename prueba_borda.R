library(clusterlab)
data <- clusterlab(centers = 5, # the number of clusters to simulate 
                   # the number of units of the radius of the circle on which the clusters are generated
                   r = 2, 
                   # the number of samples in each cluster
                   numbervec = c(3, 3, 3, 3, 3),
                   # standard deviation of each cluster
                   sdvec = c(1, 3, 2, 1, 1),
                   # how many units to push each cluster away from the initial placement
                   alphas = c(3, 5, 1, 4, 2),
                   # the number of features for the data
                   features = 2,
                   seed = 1234)
(points <- as.tibble(t(data$synthetic_data)) %>% rename(x = 1, y = 2))
normalize <- function(x){((x-min(x))/(max(x)-min(x)))}
points <- as_tibble(apply(points, 2, normalize))
ggplot(points, aes(x, y)) + geom_point()


dyn.load("02.method/distances/distances.so")
dyn.load("02.method/rkmeans/rkmeans.so")

set.seed(2020)
out <- rkmeans(x = points, centers = 5, iter.max = 1, nstart = 1, trace = FALSE, distances = 1:13, dist = 102) 
