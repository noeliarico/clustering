//#include "modreg.h" /* for declarations for registration */
#include <stdio.h>
#include <math.h>
#include "/Library/Frameworks/R.framework/Resources/include/R.h"
#include "/Library/Frameworks/R.framework/Resources/include/Rmath.h"
#include "/Library/Frameworks/R.framework/Resources/include/Rdefines.h"
#include "/Library/Frameworks/R.framework/Resources/include/Rinternals.h"
#include "/Users/noeliarico/Desktop/Github/clustering/02.method/distances/distances.c"

void assignation(double *x, int *pn, int *pp, double *cen, int *pk, int *cl,
             int *pmaxiter, int *nc, double *wss, int *pndist, int *pdist,
             int *selected_distances)
{
  
  int n = *pn, // n - number of objects
    k = *pk, // k - number of clusters
    p = *pp, // p - number of variables
    // If the algotihm did not stop in the iteration maxiter the loop breaks
    maxiter = *pmaxiter;
  int ndist = *pndist, // Number of different distance functions considered
    dist = *pdist; // The distance function considered
  int iter, i, j, c, d, it, // Variables for iterate the loops
  inew = 0; // For storing the new cluster of an object
  double best, dd;
  Rboolean updated; // 0 if false 1 if true
  
  /* For each row, initialize the cluster to which the instance belong to -1*/
  for(i = 0; i < n; i++) {
    cl[i] = -1;
  }
  
  /* For a given random set of centers, */
  for(iter = 0; iter < maxiter; iter++) {
    
    //printf("-----------------------------------------------------------------------------------------\n");
    printf("\n----------------------------- Iter: %d ---------------------------------------------------\n", iter+1);
    //printf("-----------------------------------------------------------------------------------------\n");
    updated = FALSE;
    /* for each point */
    for(i = 0; i < n; i++) {
      //best = R_PosInf;
      best = INFINITY;
      
      if(dist < 100) { // for normal distances
        /* calculate the distance from the point to each cluster */
        for(j = 0; j < k; j++) {
          dd = 0.0;
          dd = distance_measure(dist, // index of distance to compute
                                x, // data
                                p, // total number of variables of the dataset
                                n, // total number of objects of the dataset
                                i, // calculating the distance from i to cluster j
                                j, // index of the cluster
                                k, // total number of clusters
                                cen);
          printf("[p%d] DISTANCE -> Distance between p%d (%f,%f) and c%d (%f,%f) = %f \n", i+1, i+1, x[i], x[i+n], j+1, cen[j], cen[j+k], dd);
          
          
          if(dd < best) {
            //printf("| Distance %f better than best %f |\n", dd, best);
            best = dd;
            inew = j+1;
          }
        } // end of calculate the distance from the point to the cluster
      } // end of assign step for normal distances
      
      else { // for ranking rules
        //printf("[p%d] rankings... (%f,%f)\n", i+1, x[i], x[i+n]);
        inew = srr(dist,
                   x, // data
                   p, // total number of variables of the dataset
                   n, // total number of objects of the dataset
                   i, // calculating the distance from i to cluster j
                   //j, // index of the cluster
                   k, // total number of clusters
                   cen,
                   ndist,
                   selected_distances);
      }
      
      if(cl[i] != inew) {
        updated = TRUE;
        cl[i] = inew;
        //printf("| The cluster has been updated |\n");
        
      } 
      
      printf("--> Object assigned to cluster %d |\n", cl[i]);
      //printf("--------------------------------\n");
      //printf("-----------------------------------------------------------------------------------------\n\n");
      
    }  // end of the assigning step, at this line all the points have been 
    // assigned to the cluster
  }
}