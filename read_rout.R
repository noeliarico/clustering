lines <- readLines("example.Rout")
iters_info <- tribble(~distance, ~iter, ~point, ~cluster, ~x, ~y)
distance <- 0
iter <- 0
check_centers <- TRUE
for(line in lines) {
  current_distance <- selected_distances[distance]
  if(str_detect(line, "Iter")) {
    new_iter <- as.numeric(str_remove_all(line, "[-Iter: ]"))
    print(new_iter)
    if(new_iter == 1 && iter != 1) {
      distance <- distance + 1
    }
    iter <- new_iter
  }
  if(str_detect(line, "\\[p")) {
    point <- str_remove_all(str_extract(line, "\\[p.*\\]"), "[\\[\\]]")
    if(as.numeric(str_remove(point, "p")) == 1) {
      check_centers <- TRUE
    }
    else {
      check_centers <- FALSE
    }
    # Coordinates of the centers
    if(check_centers) {
      center_name <- str_extract(line, "c[0-9]+")
      c <- str_split(unlist(str_extract_all(line, "[[:digit:]]+\\.[[:digit:]]+,[[:digit:]]+\\.[[:digit:]]+"))[2], ",", simplify = TRUE)
      cx <- c[1]
      cy <- c[2]
      iters_info <- iters_info %>% add_row(distance, iter, point = center_name, cluster = str_remove(center_name, "c"), x = cx, y = cy)
    }
    
  }
  if(str_detect(line, "assigned to cluster")) {
    cluster <- as.numeric(str_extract(line, "[0-9]+"))
    #cat(distance, iter, point, cluster, "\n")
    iters_info <- iters_info %>% add_row(distance, iter, point, cluster, x = 0, y = 0)
  }
}
iters_info <- iters_info %>% mutate_all(as.factor)
names_points <- paste0("p", 1:nrow(points))
points <- points %>% mutate(names = names_points,
                            x = normalize(x), 
                            y = normalize(y))
ps <- iters_info %>% select(-x, -y) %>% filter(str_detect(point, "^c", negate = TRUE))
ps <- left_join(ps, points %>% select(x, y, names), by = c("point" = "names")) %>% mutate(point = as.factor(point))
cs <- anti_join(iters_info, points %>% select(x, y, names), by = c("point" = "names")) %>% mutate(x = as.numeric(as.character(x)), y = as.numeric(as.character(y)))
iters_info <- bind_rows(ps, cs) %>% mutate(point = as.factor(point)) %>% 
  mutate(type = factor(ifelse(str_detect(point, "^c"), "center", "point")),
          distance = as.factor(distances[distance]),
         distance = fct_relevel(distance, distances),
         iter = paste0("Iter: ", iter))
# Real
ggplot(points, aes(x, y)) + geom_point(aes(color = cluster), size = 6) + theme_light()

# Predicted
ggplot(iters_info %>% filter(distance != "gower"), aes(x, y, shape = type)) + 
  geom_point(aes(color = cluster)) + 
  facet_grid(distance ~ iter) +#, ncol = 7) +
  #scale_color_manual(values = c("red", "black"))
  scale_shape_manual(values = c(19, 23)) + 
  theme_light() + 
  theme(axis.text.x = element_text(angle = 90), 
        panel.border=element_rect(fill=NA, colour="grey40"),
        legend.position="bottom", legend.box = "horizontal",
        #panel.spacing = unit(0.02, "lines"),
        strip.text.y = element_text(size = 7, colour = "white")) +
  scale_color_jcolors("pal3") +
  scale_x_continuous(expand = c(0.1, 0.1), breaks = c(0, 0.5, 1)) +
  scale_y_continuous(expand = c(0.1, 0.1), breaks = c(0, 0.5, 1)) +
  labs(x = NULL, y = NULL)

