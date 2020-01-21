# For each dataset, creates a matrix where the rows represent the 
# distance measure use for the clustering process
# The row shows the error calculated with each of the distance measures for
# every version of the clustering
results_dataset_errors <- lapply(datasets_results, calculate_errors)
names(results_dataset_errors) <- names(datasets)

results_dataset_errors_sorted <- lapply(results_dataset_errors, sorted_errors_by_dataset)

# Create ranking
(rankingsOfErrors <- lapply(results_dataset_errors_sorted, function(x) lapply(x, ranking)))
rankingsOfErrors <- lapply(rankingsOfErrors, function(x) Reduce(bind_rows, x))
rankingsOfErrors <- lapply(rankingsOfErrors, profile_of_rankings)
rankingsOfErrors_borda <- lapply(rankingsOfErrors, borda_count)

# Visualize the results for each ranking

#' Steps:
#' 1. For each datasets, the clustering process is made with t different 
#'    distance measures. For each of those clusters achieved, the error is 
#'    calculated with the t different distance measures.
#' 2. For each of the errors: rank the different methods with rkmeans_d1, rkmeans_d2...
#' 3. For each of the methods

rankingsOfErrors_toplot <- as.data.frame(rankingsOfErrors_borda)
rankingsOfErrors_toplot <- rankingsOfErrors_toplot %>% rownames_to_column(var = "method")
rankingsOfErrors_toplot <- rankingsOfErrors_toplot %>% pivot_longer(-method, names_to = "dataset", values_to = "position") 
ks <- as.numeric(str_match(rankingsOfErrors_toplot$dataset, "data_k(.*?)f.")[,2])
fs <- as.numeric(str_remove(rankingsOfErrors_toplot$dataset, "data_k.+f"))
rankingsOfErrors_toplot <- rankingsOfErrors_toplot %>% mutate(k = ks, nfeatures = fs)
rankingsOfErrors_toplot <- rankingsOfErrors_toplot %>% transmute_all(as.factor)

# Compare the results by k
ggplot(rankingsOfErrors_toplot, aes(position, dataset)) + 
  geom_tile(fill = "white", color = "black") +
  #geom_jitter(aes(color = method, shape = method), height = 0) +
  geom_point(aes(color = method, shape = method)) +
  scale_color_manual(values = c("red", rep("black", 13))) +
  scale_shape_manual(values = 0:14)  +
  facet_grid(k ~ ., scales = "free", space = "free")

# Compare the results by number of features
ggplot(rankingsOfErrors_toplot, aes(position, dataset)) + 
  geom_tile(fill = "white", color = "black") +
  geom_jitter(aes(color = method, shape = method), height = 0) +
  
  scale_color_manual(values = c("red", rep("black", 13))) +
  scale_shape_manual(values = 0:14)  +
  facet_grid(nfeatures ~ ., scales = "free", space = "free")


# Iters -------------------------------------------------------------------


# Number of iters before converge
results_dataset_iters <- lapply(datasets_results, get_num_iter)
get_num_iter <- function(results_of_one_dataset) {
  sapply(results_of_one_dataset, function(x) x$iter)
}
lapply(results_dataset_iters, sort)
# results_dataset_iters

names(results_dataset_iters) <- names(datasets)

# 
# # Create ranking
# (rankingsOfIters <- lapply(results_dataset_iters, ranking))
# rankingsOfErrors <- lapply(rankingsOfErrors, function(x) Reduce(bind_rows, x))
# rankingsOfErrors <- lapply(rankingsOfErrors, profile_of_rankings)
rankingsOfErrors_borda <- lapply(rankingsOfErrors, borda_count)
