objects <- list.files("datasets/files", full.names = TRUE)
lapply(objects, load, .GlobalEnv)
rm(objects)