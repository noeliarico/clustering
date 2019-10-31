#include <R.h> 
#include <Rdefines.h> 
#include <stdio.h>

// double *x
// int nr
// int nc
// i1
// i2
// p - value of the p for the formula

#define both_FINITE(a,b) (R_FINITE(a) && R_FINITE(b))
#ifdef R_160_and_older
#define both_non_NA both_FINITE
#else
#define both_non_NA(a,b) (!ISNAN(a) && !ISNAN(b))
#endif

static double minkowski(double *x, int nr, int nc, int i1, int i2, double p)
{
  double dev, dist;
  int count, j;
  
  count= 0;
  dist = 0;
  for(j = 0 ; j < nc ; j++) {
    if(both_non_NA(x[i1], x[i2])) {
      dev = (x[i1] - x[i2]);
      if(!ISNAN(dev)) {
        dist += R_pow(fabs(dev), p);
        count++;
      }
    }
    i1 += nr;
    i2 += nr;
  }
  if(count == 0) return NA_REAL;
  if(count != nc) dist /= ((double)count/nc);
  return R_pow(dist, 1.0/p);
}