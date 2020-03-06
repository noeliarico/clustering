# Library all the necessary packages
library(consensus)
library(clusterlab)
library(tidyverse)
library(testthat)

# Load the benchmark datasets. The names of the datasets are stored in benchmark_data
load("01.datasets/downloaded_data/objects/benchmarkdata.RData")
benchmark_data <- c("a1", "a2", "a3", "data2", "dim0064", "dim0128", "dim0256", 
           "dim0512", "dim1024", "s1", "s2", "s3", "s4", "unbalance")
# Load the data generated with random_data_generation
load("01.datasets/generated_data/datasets1.RData")

# Load the methods developed in c
dyn.load("02.method/distances/distances.so")
dyn.load("02.method/rkmeans/rkmeans.so")