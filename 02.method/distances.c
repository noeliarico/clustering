#include<math.h>
#include<stdio.h>

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