library(clusterlab)
library(tidyverse)

dyn.load("02.method/distances/distances.so")
dyn.load("02.method/rkmeans/rkmeans.so")

set.seed(2020)
out_points <- train_rkmeans(a1, 20, 3)
errors <- calculate_errors(out_points)
errors <- sorted_errors_by_dataset(errors)
rankingsOfErrors <- lapply(errors, ranking)
rankingsOfErrors <- profile_of_rankings(Reduce(bind_rows, rankingsOfErrors))
rankingsOfErrors_borda <- borda_count(rankingsOfErrors)



