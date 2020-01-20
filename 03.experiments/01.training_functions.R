normalize <- function(x){((x-min(x))/(max(x)-min(x)))}

train_rkmeans <- function(points, cen, iter.max = 100) {
  points <- points %>% select(-cluster)
  points <- as_tibble(apply(points, 2, normalize))
  #print(head(points))
  
  #pb <- txtProgressBar(min = 0, max = 15)
  
  desired_length <- length(selected_distances) + 1 # selected distances + social choice function
  results <- vector(mode = "list", length = desired_length)
  
  # Calculate the values with the individuals distances
  for(i in 1:length(selected_distances)) {
    #setTxtProgressBar(pb, i)
    set.seed(2020)
    out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = iter.max, nstart = 1, 
                           trace = FALSE, selected_distances, dist = selected_distances[i]) 
    results[[i]] <- out_rkmeans
  }
  
  # 
  # setTxtProgressBar(pb, 14)
  # set.seed(2020)
  # out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1, 
  #                        trace = FALSE, distances = 1:13, dist = 101) 
  # results[[14]] <- out_rkmeans
  # 
  #setTxtProgressBar(pb, 15)
  
  set.seed(2020) # Borda count
  out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1,
                         trace = FALSE, selected_distances, dist = 102)
  results[[length(selected_distances)+1]] <- out_rkmeans
  #close(pb)
  
  # results[[length(selected_distances)+1]] <- NULL
  
  names(results) <- c(distances[selected_distances], "bordaCount")
  return(results)
}

