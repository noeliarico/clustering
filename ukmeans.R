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
#' @param the_cluster
#' @param clusters
#' @param distance_matrices A list containing matrix of n x n
objects_in_cluster <- function(the_cluster, clusters, distance_matrices) {
  indexes_objects_in_cluster <- which(clusters == the_cluster)
  map(distance_matrices, function(x) { x %>% 
                        select(rowname, indexes_objects_in_cluster+1) %>% 
                        slice(indexes_objects_in_cluster) })
}

#' Ranks the objects nearest
#' 
rankings_of_objects <- function(matrices_k) {
  # For each object, we sum the distance to every other object in the dataset
  # This is, for each row, we sum all the values
  rankings <- lapply(matrices_k, function(x) {
                lapply(x, function(y) {
                  y %>% mutate(sum = rowSums(.[-1])) %>% 
                        select(rowname, sum) %>% deframe()
                }) 
              })
  # Now we have, for each cluster and function, a numeric values for each 
  # object based on a concrete distance function.
  # We want to rank these functions
  rankings <- lapply(rankings, function(x) {
    #lapply(x, function(y) ranking(y))
    lapply(x, function(y) ranking(y))
  })
  
  return(rankings)
}

ukmeans <- function(data, k) {
  
  
  # Calculate the matrice of distances
  distance_matrices <- create_distance_matrices(data)
  
  # The vector clusters contains the cluster to which the object in the position
  # i belongs
  set.seed(2020)
  clusters <- sample(1:3, nrow(toy_data), TRUE)
  
  # We already have a list of distance matrices, which contains one matrix
  # for each considered distance function that stores the distance between 
  # each pair of points. Our aim is to create a ranking of objects in each
  # cluster so we need to filter the matrices in order to keep only the 
  # points to belong to each cluster so we can rank them later.
  matrices_k <- lapply(1:k, objects_in_cluster, clusters, distance_matrices)
  names(matrices_k) <- paste0("cluster", 1:k)
  
  # With the filtered rankings, we need to translate each row to a ranking.
  # By doing this, we get to know which are the nearest object to each
  # object in a concrete cluster
  rankings_of_objects <- rankings_of_objects(matrices_k)
  # All the rankings are aggregated and map into a profile of rankings
  rankings_of_objects <- lapply(rankings_of_objects, function(x) Reduce(bind_rows, x))
  rankings_of_objects <- lapply(rankings_of_objects, profile_of_rankings)
  print(rankings_of_objects)
  # Borda count is applied to the resultant profile of rankings
  rankings_of_objects <- lapply(rankings_of_objects, borda_count)

  # Asignation --------------------------------------------------------------


  # Update center -----------------------------------------------------------

  
  # Asignation
  
  
  return(rankings_of_objects)
}



