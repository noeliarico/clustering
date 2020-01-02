

# 

# # Create ranking
# (rankingsOfErrors <- lapply(sebd, function(x) lapply(x, ranking)))
# rankingsOfErrors <- lapply(rankingsOfErrors, function(x) Reduce(bind_rows, x))
# rankingsOfErrors <- lapply(rankingsOfErrors, profile_of_rankings)
# lapply(rankingsOfErrors, borda_count)
# 
# 
# # iters
# iters <- lapply(dr, function(x) {unlist(lapply(x, function(y) y$iter))})
# nclusters <- lapply(dr, function(x) {unlist(lapply(x, function(y) table(y$cluster)))})
# lapply(iters, sort)
# 
# pairs_comparison <- as_tibble(t(combn(distances, 2)), .name_repair =  ~ c("d1", "d2")) 
# colnames(pairs_comparison) <- c("d1", "d2")
# pairs_comparison <- pairs_comparison %>% filter(d1 != d2)
# 
# #save(dr, errors, file = "results.RData")
# #load("results.RData")
# print("end")