
for(the_seed in 1200:1500) {
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
                     #seed = 1234)
                     #seed = 1)
                     #seed = 11234) # VSD3
                     seed = the_seed, showplots = FALSE)
  
  (points <- as_tibble(t(data$synthetic_data)) %>% rename(x = 1, y = 2))
  points <- points %>% mutate(cluster = data$identity_matrix$cluster)
  #normalize <- function(x){((x-min(x))/(max(x)-min(x)))}
  #points <- as_tibble(apply(points, 2, normalize))
  ggplot(points, aes(x, y)) + geom_point(aes(color = cluster), size = 6) + theme_light()
  
  
  
  dyn.load("02.method/distances/distances.so")
  dyn.load("02.method/rkmeans/rkmeans.so")
  
  for(n in 1:5000) {
    out_points <- train_rkmeans(points, 5, 5)
    errors <- sapply(out_points, function(x) x$tot.withinss)
    rownames(errors) <- c(paste0("errord_", distances[1:13]))
    errors <- sorted_errors_by_dataset(errors)
    
    total <- 0
    for(i in 1:length(errors)) {
      print(names(errors[[i]][1]))
      if(names(errors[[i]][1]) == "borda_count") {
        total <- total + 1
      }
    }
    
    if(total == 1) {
      print(paste0(the_seed,";", n))
      break()
    }
  }
  
    
      
  
  
  
}
