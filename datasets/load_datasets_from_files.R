# -------------------------------------------------------------------------
# http://cs.joensuu.fi/sipu/datasets/

# Synthetic 2-d data with N = 5000 vectors and k = 15 
# Gaussian clusters with different degree of cluster overlap

# @article{Ssets,
#   author  = {P. Fr\"anti and O. Virmajoki},
#     title   = {Iterative shrinking method for clustering problems},
#     journal = {Pattern Recognition},
#     year    = {2006},
#     volume  = {39},
#     number  = {5},
#     pages   = {761--765},
#     doi     = {10.1016/j.patcog.2005.09.012},
#     url     = {http://dx.doi.org/10.1016/j.patcog.2005.09.012}
# }

s1 <- read.table("datasets/files/s1.txt")
s2 <- read.table("datasets/files/s2.txt")
s3 <- read.table("datasets/files/s3.txt")
s4 <- read.table("datasets/files/s4.txt")

s1c <- s1 %>% bind_cols(read_csv("datasets/files/s1-label.txt", skip = 5, 
                                 col_names = "real_cluster", 
                                 col_types = cols(real_cluster = col_factor())))
s2c <- s1 %>% bind_cols(read_csv("datasets/files/s2-label.txt", skip = 5, 
                                 col_names = "real_cluster", 
                                 col_types = cols(real_cluster = col_factor())))
s3c <- s1 %>% bind_cols(read_csv("datasets/files/s3-label.txt", skip = 5, 
                                 col_names = "real_cluster", 
                                 col_types = cols(real_cluster = col_factor())))
s4c <- s1 %>% bind_cols(read_csv("datasets/files/s4-label.txt", skip = 5, 
                                 col_names = "real_cluster", 
                                 col_types = cols(real_cluster = col_factor())))

save(s1, s1c, file = "datasets/objects/s1.RData")
save(s2, s2c, file = "datasets/objects/s2.RData")
save(s3, s3c, file = "datasets/objects/s3.RData")
save(s4, s4c, file = "datasets/objects/s4.RData")

# Synthetic 2-d data with increasing number of clusters (k). 
# There are 150 vectors per cluster.

# @TECHREPORT{Asets,
#   author = {I. K\"arkk\"ainen and P. Fr\"anti},
#   title = {Dynamic local search algorithm for the clustering problem},
#   institution = {Department of Computer Science, University of Joensuu},
#   address = {Joensuu, Finland},
#   number = {A-2002-6},
#   year = {2002}
# }

a1 <- read.table("datasets/files/a1.txt")
a2 <- read.table("datasets/files/a2.txt")
a3 <- read.table("datasets/files/a3.txt")

a1c <- a1 %>% 
            bind_cols(read_csv("datasets/files/a1-ga.txt", skip = 4, 
                            col_names = "real_cluster", 
                            col_types = cols(real_cluster = col_factor()))) %>%
            mutate(real_cluster = factor(real_cluster, levels = 1:20))
a2c <- a2 %>% 
  bind_cols(read_csv("datasets/files/a2-ga.txt", skip = 4, 
                     col_names = "real_cluster", 
                     col_types = cols(real_cluster = col_factor()))) %>%
  mutate(real_cluster = factor(real_cluster, levels = 1:35))
a3c <- a3 %>% 
  bind_cols(read_csv("datasets/files/a3-ga.txt", skip = 4, 
                     col_names = "real_cluster", 
                     col_types = cols(real_cluster = col_factor()))) %>%
  mutate(real_cluster = factor(real_cluster, levels = 1:50))

save(a1, a1c, file = "datasets/objects/a1.RData")
save(a2, a2c, file = "datasets/objects/a2.RData")
save(a3, a3c, file = "datasets/objects/a3.RData")



