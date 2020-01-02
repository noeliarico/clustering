

sink(file = "plurality.txt", split = TRUE)
set.seed(2020)
out1 <- rkmeans(x = points, centers = 5, iter.max = 50, nstart = 1, trace = FALSE, distances = c(1:13), dist = 2) 
out1
sink()



points <- add_row(points, x = 0, y = 0)
points <- add_row(points, x = 1, y = 1)
set.seed(2020)
out2 <- rkmeans(x = points, centers = 5, iter.max = 50, nstart = 1, trace = FALSE, distances = c(1:13), dist = 101) 

desired_length <- 15 # 13+2
results <- vector(mode = "list", length = desired_length)
for(i in 1:13) {
  set.seed(2020)
  out_rkmeans <- rkmeans(x = points, centers = 5, iter.max = 100, nstart = 1, 
                         trace = FALSE, distances = 1:13, dist = i) 
  results[[i]] <- out_rkmeans
}
set.seed(2020)
out_rkmeans <- rkmeans(x = points, centers = 5, iter.max = 100, nstart = 1, 
                       trace = FALSE, distances = 1:13, dist = 101) 
results[[14]] <- out_rkmeans
set.seed(2020)
out_rkmeans <- rkmeans(x = points, centers = 5, iter.max = 100, nstart = 1, 
                       trace = FALSE, distances = 1:13, dist = 102) 
results[[15]] <- out_rkmeans
for(i in 1:15){
  print(sum(results[[i]]$tot.withinss))
}

set.seed(2020)
out3 <- rkmeans(x = points, centers = 5, iter.max = 50, nstart = 1, trace = FALSE, distances = c(1:13), dist = 3) 

set.seed(2020)
out4 <- rkmeans(x = points, centers = 5, iter.max = 50, nstart = 1, trace = FALSE, distances = c(1:13), dist = 10) 

sum(out1$tot.withinss)
sum(out2$tot.withinss)
sum(out3$tot.withinss)
sum(out4$tot.withinss)



set.seed(2020)
out1 <- rkmeans(x = a1[1:25,], centers = 20, iter.max = 1, nstart = 1, trace = FALSE, distances = c(1:13), dist = 3) 
table(out1$cluster)

set.seed(2020)
out2 <- rkmeans(x = a1[1:25,], centers = 20, iter.max = 1, nstart = 1, trace = FALSE, distances = c(1:13), dist = 7) 
table(out2$cluster)

set.seed(2020)
out3 <- rkmeans(x = a1[1:25,], centers = 20, iter.max = 1, nstart = 1, trace = FALSE, distances = c(1:13), dist = 101) 
table(out3$cluster)

