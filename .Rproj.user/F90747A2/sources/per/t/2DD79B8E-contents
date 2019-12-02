#include<math.h>
#include<stdio.h>
#include<stdlib.h>

////////////////////////////////////////////////////////////////////////////////
// Lp Minkowski distance measures //////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// x -> first vector
// y -> second vector
// pn -> length of the vectors
// pr -> p value of the minkowski distance
// result -> empty (0) vector of length pn to store the results
void dist_minkowski(double *x, double *y, int *pn, int *pp, double *result) {
  
  int n = *pn;
  int p = *pp;
  //printf("p: %d\n", p);
  //printf("p: %f\n", 1.0/p);
  
  double sum = 0;
  for (int i = 0; i < n; i ++) {
    //printf("- x[i] %f y[i] %f \n", x[i], y[i]);
    sum += pow(x[i] - y[i], p);
    //printf("-- sum: %f\n", sum);
  }
  //printf("sum: %f\n", sum);
  *result = pow(sum, (1.0/p));
}

////////////////////////////////////////////////////////////////////////////////
// L1 distance measures ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void dist_canberra(double *x, double *y, int *pn, double *result) {
  
  int n = *pn;
  
  double sum = 0;
  for (int i = 0; i < n; i ++) {
    //printf("- x[i] %f y[i] %f \n", x[i], y[i]);
    if(fabs(x[i] + y[i]) > 0) {
      sum += fabs(x[i] - y[i]) / fabs(x[i] + y[i]);
    }
    printf("\n-- sum: %f\n", sum);
    
  }
  //printf("sum: %f\n", sum);
  *result = sum;
}

// mean character distance (MCD)

void dist_cosine(double *x, double *y, int *pn, double *result) {
  
  int n = *pn;
  double sum = 0;
  double da = 0.0;
  double db = 0.0;
  
  for (int i = 0; i < n; i ++) {
    sum += x[i] * x[i] ;
    da += x[i] * y[i] ;
    db += y[i] * y[i] ;
  }
  
  *result = sum / (sqrt(da) * sqrt(db));
}

////////////////////////////////////////////////////////////////////////////////
// Inner product distance measures /////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Jaccard distance 
// Cosine distance 

////////////////////////////////////////////////////////////////////////////////
// Squared Chord distance measures /////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Bhattacharyya
// Matusita

////////////////////////////////////////////////////////////////////////////////
// Squared L2 distance measures ////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Clark distance
// Squared x2 distance, a.k.a triangular discrimination distance. This distance is a quasi distance

////////////////////////////////////////////////////////////////////////////////
// Vicissitude distance measures ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Vicis symmetric distance VSD
// Max symmetric x2 distane MiSCSD

double distance_measure(int distance, // index of distance to compute
                      double* x, // data
                      int ncol, // total number of variables of the dataset
                      int nrow, // total number of objects of the dataset
                      int i, // calculating the distance from i to cluster j
                      int j, // index of the cluster
                      int k, // total number of clusters
                      double* cen) {// array of centers 
  int c;
  double dd = 0.0, tmp =0.0;
  int xi, yi;
  double sum, da, db;
  
  switch (distance) {
  
  case 1: // manhattan distance
    for(c = 0; c < ncol; c++) { 
      tmp = x[i+nrow*c] - cen[j+k*c];
      dd += fabs(tmp); // add the absolute value of the difference
    }
    return dd;
    
  case 2:
    for(c = 0; c < ncol; c++) { // for each column
      tmp = x[i+nrow*c] - cen[j+k*c]; // distance between point and center in that dimension
      //printf("tmp en distances.c: %f\n", tmp);
      dd += tmp * tmp; // square the value
    }
    dd = pow(dd, 1.0/2.0);
    printf("Euclidean distance en distances.c= %f \n", dd);
    return dd;
    
  case 3:
    return -1;
    
  case 4: // cosine distance
    
    
    
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum += xi * xi;
      da += xi * yi;
      db += yi * yi;
    }
    
    return (sum / (sqrt(da) * sqrt(db)));
    
  default:
    printf("Unknown distance");
    return 0.0;
    
  }
}
