library(tidyverse)
normalize <- function(x){((x-min(x))/(max(x)-min(x)))}

train_rkmeans <- function(points, cen) {
  points <- as_tibble(apply(points, 2, normalize))
  print(head(points))
  
  pb <- txtProgressBar(min = 0, max = 15)
  
  desired_length <- 15 # 13+2
  results <- vector(mode = "list", length = desired_length)
  for(i in 1:13) {
    setTxtProgressBar(pb, i)
    set.seed(2020)
    out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1, 
                           trace = FALSE, distances = 1:13, dist = i) 
    results[[i]] <- out_rkmeans
  }
  setTxtProgressBar(pb, 14)
  set.seed(2020)
  out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1, 
                         trace = FALSE, distances = 1:13, dist = 101) 
  results[[14]] <- out_rkmeans
  
  setTxtProgressBar(pb, 15)
  set.seed(2020)
  out_rkmeans <- rkmeans(x = points, centers = cen, iter.max = 100, nstart = 1, 
                         trace = FALSE, distances = 1:13, dist = 102) 
  results[[15]] <- out_rkmeans
  close(pb)
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

dr <- vector(mode = "list", length = 6)
for(i in 1:6) {
  resultsd1 <- train_rkmeans(datasets[[i]], i+2)
  dr[[i]] <- resultsd1
}

calculate_errors <- function(resultsd1) {
  errorsd1 <- sapply(resultsd1, function(x) x$tot.withinss)
  colnames(errorsd1) <- c(paste0("train_d", 1:13), "train_plurality", "train_borda")
  rownames(errorsd1) <- c(paste0("error_d", 1:13))
  colSums(errorsd1)
}

errors <- lapply(dr, calculate_errors)


resultsd2 <- train_rkmeans(datasets[[2]], 4)
sapply(resultsd2, function(x) sum(x$tot.withinss))
resultsd3 <- train_rkmeans(datasets[[3]], 5)
sapply(resultsd2, function(x) sum(x$tot.withinss))

save(dr, errors, file = "results.RData")
load("results.RData")
