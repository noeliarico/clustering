fviz_nbclust(s1, kmeans, method = "wss", nstart = 20, k.max = 20) +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method")

fviz_nbclust(s2, kmeans, method = "wss", nstart = 20, k.max = 20) +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method")

library(amap)
