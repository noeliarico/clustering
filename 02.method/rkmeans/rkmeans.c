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

void rkmeans(double *x, int *pn, int *pp, double *cen, int *pk, int *cl,
                  int *pmaxiter, int *nc, double *wss)
{
  
  printf("Hola Noelia\n");
  int n = *pn, k = *pk, p = *pp, maxiter = *pmaxiter;
  int iter, i, j, c, it, inew = 0;
  double best, dd, tmp;
  Rboolean updated;
  
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
        printf("Distance between p%d (%f,%f) and c%d (%f,%f)", i+1, x[i], x[i+p], j+1, cen[j],cen[j+k]);
        dd = 0.0;
        /* sum the distance between each column of the center and the point*/
        for(c = 0; c < p; c++) {
          //printf("i: %d\n", i);
          //printf("n: %d\n", n);
          //printf("c: %d\n", c);
          //printf("j: %d\n", j);
          //printf("k: %d\n", k);
          //printf("x[i+n*c]: %f\n", x[i+n*c]);
          int value = i+n*c;
          //printf("[i+n*c] %d\n", value);
          value = j+k*c;
          //printf("[j+k*c]: %d\n", value);
          tmp = x[i+n*c] - cen[j+k*c];
          //printf("tmp: %f\n", tmp);
          dd += tmp * tmp;
          //printf("dd: %f\n", dd);
          //printf("dd: %f\n", dd);
          //printf("---------\n");
        }
        
        printf(" = %f \n", dd);
        
        if(dd < best) {
          printf("| Distance %f better than best %f |\n", dd, best);
          best = dd;
          inew = j+1;
        }
        
        
        //printf("---------\n");
      
        //printf("best: %f\n", best);
        //printf("---------\n");
        
//      }
      if(cl[i] != inew) {
        updated = TRUE;
        cl[i] = inew;
        printf("| The cluster has been updated |\n");
        
      }
      
      
    }
      printf(".------------------------------.\n");
      printf("| Object assigned to cluster %d |\n", cl[i]);
      printf(".------------------------------.\n");
      printf("-----------------------------------------------------------------------------------------\n\n");
    }
      if(!updated) break;
      
    /* update each centre */
      for(j = 0; j < k*p; j++) cen[j] = 0.0;
      for(j = 0; j < k; j++) nc[j] = 0;
      for(i = 0; i < n; i++) {
        it = cl[i] - 1; nc[it]++;
      for(c = 0; c < p; c++) cen[it+c*k] += x[i+c*n];
    
    for(j = 0; j < k*p; j++) cen[j] /= nc[j % k];
  }
  
  printf("Bye Noelia\n");
  
//  *pmaxiter = iter + 1;
//  for(j = 0; j < k; j++) wss[j] = 0.0;
//  for(i = 0; i < n; i++) {
//    it = cl[i] - 1;
//    for(c = 0; c < p; c++) {
//      tmp = x[i+n*c] - cen[it+k*c];
//      wss[it] += tmp * tmp;
//    }
//  }
}
