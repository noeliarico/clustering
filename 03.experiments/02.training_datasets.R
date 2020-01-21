# Ejemplo, cojo el dataset 22 (aleatoriamente) con 5 clusters que son los que tiene
# train_rkmeans(datasets[[22]], 5)

# For other datasets
# results_a2 <- train_rkmeans(a2, 35)
# results_a3 <- train_rkmeans(a3, 50)
# 
# results_s1 <- train_rkmeans(s1, 15)
# results_s2 <- train_rkmeans(s2, 15)
# results_s3 <- train_rkmeans(s3, 10)
# results_s4 <- train_rkmeans(s4, 10)
# 
# sapply(results_a1, function(x) sum(x$tot.withinss))
# sapply(results_a2, function(x) sum(x$tot.withinss))



# Number of clusters of each dataset
number_of_clusters <- unlist(lapply(datasets, function(x) x %>% distinct(cluster) %>% nrow())) 
# Empty list to store the results for each dataset in the list "datasets"
datasets_results <- vector(mode = "list", length = length(datasets))
for(i in 1:length(datasets)) {
#for(i in 1:10) {
  results <- train_rkmeans(datasets[[i]], number_of_clusters[i])
  datasets_results[[i]] <- results
}
saveRDS(datasets_results, "clustering_web/datasets_results_v2.rds")
