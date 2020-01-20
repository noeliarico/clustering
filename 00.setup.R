# Library all the necessary packages
library(clusterlab)
library(tidyverse)
library(testthat)

# Load the methods developed in c
dyn.load("02.method/distances/distances.so")
dyn.load("02.method/rkmeans/rkmeans.so")

# Load all the objects containing the datasets
objects <- list.files("01.datasets/objects", full.names = TRUE)
lapply(objects, load, .GlobalEnv)
rm(objects)