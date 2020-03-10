rkmeans <- function(data, assignation = "kmeans", update = "kmeans", distance, rankingRule) {
  
  if(!assignation %in% c("kmeans", "rkmeans")) {
    stop('Valid values for the assignation argument are "kmeans" or "rkmeans"')
  }
  
  if(!update %in% c("kmeans", "rkmeans")) {
    stop('Valid values for the update argument are "kmeans" or "rkmeans"')
  }
  
}