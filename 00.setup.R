# Library all the necessary packages
library(tidyverse)
library(testthat)

# Load all the objects containing the datasets
objects <- list.files("01.datasets/objects", full.names = TRUE)
lapply(objects, load, .GlobalEnv)
rm(objects)