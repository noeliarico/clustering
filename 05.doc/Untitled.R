kmeans_and_plot <- function(data, nclusters) {
  #kmeans(data, nclusters, iter.max = 10, nstart = 10)
  fviz_nbclust(data, kmeans, wss)
}
