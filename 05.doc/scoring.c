#include <stdio.h>

void pointsToRanking(int *ranking, int *nranking, double *points) {
  // number of different positions in the rankings
  int n_of_candidates = *nranking;
  int pos = 1;
  int i = 0, j = 0;
  for(i = 0; i < n_of_candidates; i++) {
    pos = 1;
    for(j = 0; j < n_of_candidates; j++) {
      if(j != i) {
        if(points[j] > points[i]) {
          pos++;
        }
      }
    }
    ranking[i] = pos;
  }
}

void distanceToRanking(int *ranking, int *nranking, double *points) {
  // number of different positions in the rankings
  int n_of_candidates = *nranking;
  int pos = 1;
  int i = 0, j = 0;
  for(i = 0; i < n_of_candidates; i++) {
    pos = 1;
    for(j = 0; j < n_of_candidates; j++) {
      if(j != i) {
        if(points[j] > points[i]) {
          pos++;
        }
      }
    }
    ranking[i] = pos;
  }
}



double plurality(double* x, // data
                  int ncol, // total number of variables of the dataset
                  int nrow, // total number of objects of the dataset
                  int i, // calculating the distance from i to cluster j
                  int j, // index of the cluster
                  int k, // total number of clusters
                  double* cen) {// array of centers 
  
  int xi, yi, d;
  double dd;
  double distance[k];
  
  for(d = 1; d <= 13; d++) { // for each distance
    for(j = 0; j < k; j++) { // for each cluster
      // calculate the distance from the point to the cluster
      dd = distance_measure(d, // index of the distance
                            x, // data
                            ncol, // total number of variables of the dataset
                            nrow, // total number of objects of the dataset
                            i, // calculating the distance from i to cluster j
                            j, // index of the cluster
                            k, // total number of clusters
                            cen);
      distance[j] = dd;
    }
    
  }
}