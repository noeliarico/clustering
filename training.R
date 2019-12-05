library(tidyverse)
normalize <- function(x){((x-min(x))/(max(x)-min(x)))}

train_rkmeans <- function(points, cen) {
  points <- as_tibble(apply(points, 2, normalize))
  print(head(points))
  
  pb <- txtProgressBar(min = 0, max = 15)
  
  desired_length <- 14 # 13+2
  results <- vector(mode = "list", length = desired_length)
  
  for(i in 1:13) {
    setTxtProgressBar(pb, i)
    set.seed(2020)
    out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1, 
                           trace = FALSE, distances = 1:13, dist = i) 
    results[[i]] <- out_rkmeans
  }
  # 
  # setTxtProgressBar(pb, 14)
  # set.seed(2020)
  # out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1, 
  #                        trace = FALSE, distances = 1:13, dist = 101) 
  # results[[14]] <- out_rkmeans
  # 
  setTxtProgressBar(pb, 15)
  set.seed(2020)
  out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1, 
                         trace = FALSE, distances = 1:13, dist = 102) 
  results[[14]] <- out_rkmeans
  close(pb)
  
  names(results) <- distances
  return(results)
}

results_a1 <- train_rkmeans(a1, 20)
results_a2 <- train_rkmeans(a2, 35)
results_a3 <- train_rkmeans(a3, 50)

results_s1 <- train_rkmeans(s1, 15)
results_s2 <- train_rkmeans(s2, 15)
results_s3 <- train_rkmeans(s3, 10)
results_s4 <- train_rkmeans(s4, 10)

sapply(results_a1, function(x) sum(x$tot.withinss))
sapply(results_a2, function(x) sum(x$tot.withinss))


###### Random datasets

distances <- c(
# Lp Minkowski distance measures //////////////////////////////////////////////
  "manhattan", # 1
  "euclidean", # 2
  "chebyshev", # 3
# L1 distance measures ////////////////////////////////////////////////////////
  "canberra", # 4
  "gower", # 5
# Inner product distance measures /////////////////////////////////////////////
  "jaccard", # 6
  "cosine", # 7
# Squared Chord distance measures /////////////////////////////////////////////
  "SqrdChrd", # 8
  "matusita", # 9
# Squared L2 distance measures ////////////////////////////////////////////////
  "clark", # 10
  "trngDiscr", # 11
# Vicissitude distance measures ///////////////////////////////////////////////
  "VSD3", # 12
  "maxSymmSq", # 13

  # Scoring distance functions
  #"plurality", # 101
  "bordaCount" # 102
)

ies <- rep(2:8, 5)
dr <- vector(mode = "list", length = 35)
for(i in 1:35) {
  resultsd1 <- train_rkmeans(datasets[[i]], ies[i])
  dr[[i]] <- resultsd1
}

calculate_errors <- function(resultsi) {
  errorsi <- sapply(resultsi, function(x) x$tot.withinss)
  rownames(errorsi) <- c(paste0("errord_", distances[1:13]))
  errorsi
  #colSums(errorsd1)
}

errors <- lapply(dr, calculate_errors)

sorted_errors_by_dataset <- function(y) {
  out <- lapply(1:nrow(y), function(x) {
    sort(y[x,])
  })
  names(out) <- distances[1:13]
  out
}

sebd <- lapply(errors, sorted_errors_by_dataset)
# Create ranking
(rankingsOfErrors <- lapply(sebd, function(x) lapply(x, ranking)))
rankingsOfErrors <- lapply(rankingsOfErrors, function(x) Reduce(bind_rows, x))
rankingsOfErrors <- lapply(rankingsOfErrors, profile_of_rankings)
lapply(rankingsOfErrors, borda_count)


# iters
iters <- lapply(dr, function(x) {unlist(lapply(x, function(y) y$iter))})
lapply(iters, sort)

pairs_comparison <- as_tibble(t(combn(distances, 2)), .name_repair =  ~ c("d1", "d2")) 
colnames(pairs_comparison) <- c("d1", "d2")
pairs_comparison <- pairs_comparison %>% filter(d1 != d2)

#save(dr, errors, file = "results.RData")
#load("results.RData")
print("end")