library(clusterlab)
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
                   seed = 1234)
(points <- as.tibble(t(data$synthetic_data)) %>% rename(x = 1, y = 2))
normalize <- function(x){((x-min(x))/(max(x)-min(x)))}
points <- as_tibble(apply(points, 2, normalize))
ggplot(points, aes(x, y)) + geom_point()


dyn.load("02.method/distances/distances.so")
dyn.load("02.method/rkmeans/rkmeans.so")

sink(file = "plurality.txt", split = TRUE)
set.seed(2020)
out1 <- rkmeans(x = points, centers = 5, iter.max = 50, nstart = 1, trace = FALSE, distances = c(1:13), dist = 2) 
out1
sink()

set.seed(2020)
out2 <- rkmeans(x = points, centers = 5, iter.max = 50, nstart = 1, trace = FALSE, distances = c(1:13), dist = 101) 

desired_length <- 15 # 13+2
results <- vector(mode = "list", length = desired_length)
for(i in 1:13) {
  set.seed(2020)
  out_rkmeans <- rkmeans(x = points, centers = 5, iter.max = 100, nstart = 1, 
                         trace = FALSE, distances = 1:13, dist = i) 
  results[[i]] <- out_rkmeans
}
set.seed(2020)
out_rkmeans <- rkmeans(x = points, centers = 5, iter.max = 100, nstart = 1, 
                       trace = FALSE, distances = 1:13, dist = 101) 
results[[14]] <- out_rkmeans
set.seed(2020)
out_rkmeans <- rkmeans(x = points, centers = 5, iter.max = 100, nstart = 1, 
                       trace = FALSE, distances = 1:13, dist = 102) 
results[[15]] <- out_rkmeans
for(i in 1:15){
  print(sum(results[[i]]$tot.withinss))
}

set.seed(2020)
out3 <- rkmeans(x = points, centers = 5, iter.max = 50, nstart = 1, trace = FALSE, distances = c(1:13), dist = 3) 

set.seed(2020)
out4 <- rkmeans(x = points, centers = 5, iter.max = 50, nstart = 1, trace = FALSE, distances = c(1:13), dist = 10) 

sum(out1$tot.withinss)
sum(out2$tot.withinss)
sum(out3$tot.withinss)
sum(out4$tot.withinss)



set.seed(2020)
out1 <- rkmeans(x = a1[1:25,], centers = 20, iter.max = 1, nstart = 1, trace = FALSE, distances = c(1:13), dist = 3) 
table(out1$cluster)

set.seed(2020)
out2 <- rkmeans(x = a1[1:25,], centers = 20, iter.max = 1, nstart = 1, trace = FALSE, distances = c(1:13), dist = 7) 
table(out2$cluster)

set.seed(2020)
out3 <- rkmeans(x = a1[1:25,], centers = 20, iter.max = 1, nstart = 1, trace = FALSE, distances = c(1:13), dist = 101) 
table(out3$cluster)

