/*
 *  R : A Computer Language for Statistical Data Analysis
 *  Copyright (C) 2004   The R Core Team.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, a copy is available at
 *  https://www.R-project.org/Licenses/
 */

//#include "modreg.h" /* for declarations for registration */
#include <stdio.h>
#include <math.h>
#include "/Library/Frameworks/R.framework/Resources/include/R.h"
#include "/Library/Frameworks/R.framework/Resources/include/Rmath.h"
#include "/Library/Frameworks/R.framework/Resources/include/Rdefines.h"
#include "/Library/Frameworks/R.framework/Resources/include/Rinternals.h"
#include "/Users/noeliarico/Desktop/Github/clustering/02.method/distances/distances.c"

void rkmeans(double *x, int *pn, int *pp, double *cen, int *pk, int *cl,
             int *pmaxiter, int *nc, double *wss)
{
  
  printf("Hola Noelia\n");
  int n = *pn, k = *pk, p = *pp, maxiter = *pmaxiter;
  int iter, i, j, c, it, inew = 0;
  double best, dd, tmp;
  Rboolean updated; // 0 if false 1 if true
  
  /* For each row, initialize the cluster to which the instance belong to -1*/
  for(i = 0; i < n; i++) {
    cl[i] = -1;
  }
  
  /* For a given random set of centers, */
  for(iter = 0; iter < maxiter; iter++) {
    
    printf("-----------------------------------------------------------------------------------------\n");
    printf("----------------------------- Iter: %d ---------------------------------------------------\n", iter);
    printf("-----------------------------------------------------------------------------------------\n");
    updated = FALSE;
    /* for each point */
    for(i = 0; i < n; i++) {
      //best = R_PosInf;
      best = INFINITY;
      /* calculate the distance from the point to the cluster */
      for(j = 0; j < k; j++) {
        //dd = 0.0;
        /* sum the distance between each column of the center and the point*/
        //for(c = 0; c < p; c++) {
          //printf("i: %d\n", i);
          //printf("n: %d\n", n);
          //printf("c: %d\n", c);
          //printf("j: %d\n", j);
          //printf("k: %d\n", k);
          //printf("x[i+n*c]: %f\n", x[i+n*c]);
          //int value = i+n*c;
          //printf("[i+n*c] %d\n", value);
          //value = j+k*c;
          //printf("[j+k*c]: %d\n", value);
          //tmp = x[i+n*c] - cen[j+k*c];
          //printf("tmp: %f\n", tmp);
          //dd += tmp * tmp; // square the value
          //printf("dd: %f\n", dd);
          //printf("dd: %f\n", dd);
          //printf("---------\n");
          
          
        //}
        
        printf("[%d] Distance between p%d (%f,%f) and c%d (%f,%f) = %f \n", i+1, i+1, x[i], x[i+n], j+1, cen[j], cen[j+k], dd);
        dd = distance_measure(2, // index of distance to compute
                         x, // data
                         p, // total number of variables of the dataset
                         n, // total number of objects of the dataset
                         i, // calculating the distance from i to cluster j
                         j, // index of the cluster
                         k, // total number of clusters
                         cen);
        
        
        
        if(dd < best) {
          printf("| Distance %f better than best %f |\n", dd, best);
          best = dd;
          inew = j+1;
        }
        
        
        //printf("---------\n");
        
        //printf("best: %f\n", best);
        //printf("---------\n");
        
      } // end of calculate the distance from the point to the cluster
      
      if(cl[i] != inew) {
        updated = TRUE;
        cl[i] = inew;
        printf("| The cluster has been updated |\n");
        
      } 
      
      printf(".------------------------------.\n");
      printf("| Object assigned to cluster %d |\n", cl[i]);
      printf("--------------------------------\n");
      printf("-----------------------------------------------------------------------------------------\n\n");
      
      
      
    }  // end of the assigning step, at this line all the points have been 
    // assigned to the cluster
    
    
    // If the variable  update has non being modified in any of the points
    
    if(!updated) {
      break;
    }
    // Updating step
    
    // Initialize each center to 0.0
    for(j = 0; j < k*p; j++) cen[j] = 0.0;
    // For each cluster, the number of objects that belong to this cluster is
    // also 0 initially
    for(j = 0; j < k; j++) nc[j] = 0;
    // Count the number of objects which belong to each cluster
    // For eac object in the dataset
    for(i = 0; i < n; i++) {
      it = cl[i] - 1; // Get the cluster where the object belong
      nc[it]++; // Increment the number of objects in that cluster
      for(c = 0; c < p; c++) // For each column
        cen[it+c*k] += x[i+c*n]; // Increment the value so we can compute the mean later
    }
    // Compute the mean of each column so we have the centers of the clusters
    for(j = 0; j < k*p; j++) cen[j] /= nc[j % k];
  }
  
  *pmaxiter = iter + 1;
  for(j = 0; j < k; j++) wss[j] = 0.0;
  for(i = 0; i < n; i++) {
    it = cl[i] - 1;
    for(c = 0; c < p; c++) {
      //tmp = x[i+n*c] - cen[it+k*c];
      wss[it] += tmp * tmp;
    }
  }
  
}






