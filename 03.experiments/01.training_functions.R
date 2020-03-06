# Given a numeric vector, this function normalizes the vector
normalize <- function(x){((x-min(x))/(max(x)-min(x)))}

train_rkmeans <- function(dataset, cen, iter.max = 100) {
  # Given a dataset of the format V1, V2, ..., VN and an extra variable CLUSTER
  # Keep only the points that define the data and not the value which stores
  # the original cluster to which the points belong
  points <- dataset %>% select(-cluster)
  # Normalize the data
  points <- as_tibble(apply(points, 2, normalize))
  
  
  #pb <- txtProgressBar(min = 0, max = 15)
  
  # For each dataset, the method will be trained for each single distance 
  # function and later for the social choice function. 
  # So the list to store the results must have a length = 
  # = number of selected distances + 1 (social choice function)
  desired_length <- length(selected_distances) + 1 
  results <- vector(mode = "list", length = desired_length)
  
  # Calculate the values for the method using sole distances
  for(i in 1:length(selected_distances)) {
    
    #setTxtProgressBar(pb, i)
    
    set.seed(2020)
    out_rkmeans <- rkmeans(x = points, centers = cen, 
                           iter.max = iter.max, nstart = 1, 
                           trace = FALSE, selected_distances, 
                           dist = selected_distances[i]) 
    results[[i]] <- out_rkmeans # store the results in the list
  }
  
  #setTxtProgressBar(pb, 15)
  
  set.seed(2020) # Borda count
  out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1,
                         trace = FALSE, selected_distances, dist = 102)
  results[[desired_length]] <- out_rkmeans
  
  #close(pb)
  
  names(results) <- c(distances[selected_distances], "bordaCount")
  return(results)
}

