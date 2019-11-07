#include<math.h>
#include<stdio.h>

void minkoski_distance(double *x, double *y, int *pn, int *pr, double result) {
  int n = *pn;
  int r = *pr;
  double sum = 0;
  for (int i = 0; i < n; i ++) {
    sum += pow(x[i] - y[i], r);
    printf("sum: %f\n", sum);
  }
  
  result = pow(sum, 1.0 / r);
  printf("%f", result);
}