# Input: results of one datasets, taken from a single 
# element of the list datasets_results
# Calculates for each distance that was used for training the dataset the 
# errors computed which each of the distance
calculate_errors <- function(results_of_one_dataset) {
  errors_one_dataset <- sapply(results_of_one_dataset, function(x) x$tot.withinss)
  rownames(errors_one_dataset) <- c(paste0("error_d", distances[selected_distances]))
  errors_one_dataset
  #colSums(errorsd1)
}

# Input: matrix of errors obtained after applying "calculate_errors"
# 
sorted_errors_by_dataset <- function(errors_of_one_dataset) {
  ranking_of_errors <- lapply(1:nrow(errors_of_one_dataset), function(x) {
    sort(errors_of_one_dataset[x,])
  })
  names(ranking_of_errors) <- selected_distances
  ranking_of_errors
}


