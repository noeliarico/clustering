plot_real_clusters <- function(data, clusters, x, y) {
  hulls <- data %>%
    group_by_at(clusters) %>%
    group_modify( ~ find_hull(., x, y)) %>%
    ungroup() %>%
    bind_rows()
  
  ggplot(data, aes_string(
    x = x,
    y = y,
    color = clusters,
    fill = clusters
  )) +
    geom_point() +
    geom_polygon(data = hulls, alpha = 0.1) +
    theme_bw()
}
