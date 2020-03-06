toy_data <- clusterlab(centers = 3,
                        r = 2,
                        numbervec = c(5, 5, 5),
                        sdvec = sample(1:3, 3),
                        alphas = sample(1:3, 3),
                        features = 2,
                        seed = 2020)
toy_data <- as_tibble(t(toy_data$synthetic_data)) %>% 
  mutate(cluster = as.factor(toy_data$identity_matrix$cluster)) %>% 
  mutate_if(is.numeric, normalize)

ggplot(toy_data, aes(V1, V2, color = cluster)) +
  geom_point()

