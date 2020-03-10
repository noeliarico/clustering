#' Given a dataset of n objects and a set of d distance functions,
#' this function computes the distance between all the points for
#' each distance function, returning a matrix of distances for each distance
#' function in a list of length d
create_distance_matrices <- function(data) {
  matrices <- lapply(distances[selected_distances], function(x) distance_to_all(data, x))
  names(matrices) <- distances[selected_distances]
  matrices <- lapply(matrices, function(x) as_tibble(x) %>% rownames_to_column())
  return(matrices)
}

#' Given a dataset with variables and the column "cluster" that contains
#' the real value of the cluster of the object. Given a 
#' @param distance The distance function identified by three letters
#' 
#' @return The function returns a matrix giving the distance between each
#' pair of points of the dataset
distance_to_all <- function(data, distance) {
  # TODO cambiar a outer
  sapply(1:nrow(data), function(x) {
    sapply(1:nrow(data), function(y) {
      distance(data %>% select(-cluster), distance = distance, from = x, to = y)
    })
  })
}

#' 




ukmeans <- function(data, k) {
  
  
 
  # Asignation --------------------------------------------------------------


  # Update center -----------------------------------------------------------

  
  # Asignation
  
  
  return(rankings_of_objects)
}



