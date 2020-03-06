# Number of clusters of each dataset
number_of_clusters <- unlist(lapply(datasets, function(x) x %>% distinct(cluster) %>% nrow())) 

# Empty list to store the results for each dataset in the list "datasets"
datasets_results <- vector(mode = "list", length = length(datasets))
for(i in 1:length(datasets)) {
#for(i in 1:10) {
  results <- train_rkmeans(datasets[[i]], number_of_clusters[i])
  datasets_results[[i]] <- results
}

rm(number_of_clusters)

saveRDS(datasets_results, "clustering_web/datasets_results_v2.rds")
