#include<math.h>
#include<stdio.h>
#include<stdlib.h>

void distance_measure2(int *pdistance, // index of distance to compute
                        double *x, // data
                        int *pncol, // total number of variables of the dataset
                        int *pnrow, // total number of objects of the dataset
                        // calculating the distance from i to j
                        int *pi, // index of the first object
                        int *pj, // index of the second object
                        int k, // total number of clusters
                        double* cen,
                        double *result) {// array of centers 
  int c;
  double dd = 0.0, tmp =0.0;
  double xi = 0.0, yi = 0.0;
  double sum, max;
  double numerator, denominator;
  double sum1, sum2, sum3, sum4;
  
  int distance = *pdistance,
      ncol = *pncol,
      nrow = *pnrow,
      i = *pi,
      j = *pj;
  
  // printf("Computing the distance using: %d \n", distance);
  
  switch (distance) {
    
    ////////////////////////////////////////////////////////////////////////////////
      // Lp Minkowski distance measures //////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////////
      
      case 1: // Manhattan distance
    for(c = 0; c < ncol; c++) { 
      tmp = x[i+nrow*c] - x[j+nrow*c];
      dd += fabs(tmp); // add the absolute value of the difference
    }
    *result = dd;
    break;
    
    case 2: // Euclidean distance
    for(c = 0; c < ncol; c++) { // for each column
      tmp = x[i+nrow*c] - x[j+nrow*c]; // distance between point and center in that dimension
      //printf("tmp en distances.c: %f\n", tmp);
      dd += tmp * tmp; // square the value
    }
    //dd = pow(dd, 1.0/2.0);
    //printf("Euclidean distance en distances.c= %f \n", dd);
    *result = sqrt(dd);
      break;
    
    case 3: // Chebyshev distance
    max  = 0.0;
    sum1 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 = fabs(xi - yi);
      if(max < sum1) {
        max = sum1;
        //printf("-- Yes\n");
      }
    }
    *result = max;
    break;
    ////////////////////////////////////////////////////////////////////////////////
      // L1 distance measures ////////////////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////////
      
      case 4: // canberra
    
    sum = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      numerator = fabs(xi - yi);
      denominator = fabs(xi) + fabs(yi);
      if(denominator > 0) {
        sum += numerator / denominator;
      }
    }
    *result = sum;
    break;
    
    case 5: // Gower distance or Average Manhattan
    
    sum = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      numerator = fabs(xi - yi);
      sum += numerator;
    }
    *result = sum / ncol;
    break;
    
    ////////////////////////////////////////////////////////////////////////////////
      // Inner product distance measures /////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////////
      
      case 6: // Jaccard distance 
    
    sum1 = 0.0, sum2 = 0.0, sum3 = 0.0, sum4 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 += (xi - yi) * (xi - yi);
      sum2 += xi * xi;
      sum3 += yi * yi;
      sum4 += xi * yi;
    }
    if((sum2 + sum3 - sum4) == 0) {
      *result = 0;
    }
    else{
      *result = (sum1 / (sum2 + sum3 - sum4));
    }
    break;
    
    case 7: // Cosine distance 
    
    sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    double denom = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 += xi * yi;
      sum2 += xi * xi;
      sum3 += yi * yi;
    }
    denom = sqrt(sum2) * sqrt(sum3);
    if(denom == 0) {
      *result = 0;
    }
    else {
      *result = (1 - (sum1 / denom));
    }
    break;
    
    ////////////////////////////////////////////////////////////////////////////////
      // Squared Chord distance measures /////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////////
      
      case 8: // Squared chord distance (SCD)
    
    sum = 0.0, sum1 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 = sqrt(xi) - sqrt(yi); // difference
      sum1 = sum1 * sum1; // square of the differences
      sum += sum1;
    }
    //printf("sum = %f\n", sum);
    *result = sum;
    break;
    
    case 9: // Matusita
    
    sum = 0.0, sum1 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 = sqrt(xi) - sqrt(yi); // difference
      sum1 = sum1 * sum1; // square of the differences
      sum += sum1;
    }
    *result = sqrt(sum);
    break;
    
    ////////////////////////////////////////////////////////////////////////////////
      // Squared L2 distance measures ////////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////////
      
      case 10:  // Clark distance
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 = xi - yi;
      sum2 = fabs(xi) + fabs(yi);
      if(sum2 > 0.0) {
        sum += pow((sum1 / sum2), 2);
      }
    }
    *result = sqrt(sum);
    break;
    
    case 11:  // Neyman
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 = (xi - yi) * (xi - yi);
      if(xi > 0) {
        sum += sum1 / xi;
      }
    }
    *result = sqrt(sum);
    break;
    
    case 12:  // Pearson
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 = (xi - yi) * (xi - yi);
      if(yi > 0) {
        sum += sum1 / yi;
      }
    }
    *result = sqrt(sum);
    break;
    
    case 13: // Squared x2 distance, a.k.a triangular discrimination distance. This distance is a quasi distance
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 = (xi - yi) * (xi - yi);
      sum2 = xi + yi;
      if(sum2 > 0) {
        sum += sum1 / sum2;
      }
    }
    
    *result = sum;
    break;
    
    ////////////////////////////////////////////////////////////////////////////////
      // Vicissitude distance measures ///////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////////
      
      case 14: // Vicis symmetric distance VSD3
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 = (xi - yi) * (xi - yi);
      if(xi > yi) {
        sum2 = xi;
      }
      else {
        sum2 = yi;
      }
      if(sum2 > 0) {
        sum += sum1 / sum2;
      }
    }
    *result = sum;
    break;
    
    case 15: // Max symmetric x2 distane MiSCSD
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = x[j+nrow*c];
      sum1 = (xi - yi) * (xi - yi);
      if(xi > 0) {
        sum2 = sum1 / xi;
      }
      if(xi > 0) {
        sum3 = sum1 / yi;
      }
    }
    
    if(sum2 > sum3) {
      *result = sum2;
    }
    else {
      *result = sum3;
    }
    break;
    
    default:
      //printf("Unknown distance [%d]\n",distance);
    *result = 0.0;
    break;
  }
}

/*
int srr(int dist, 
        double* x, // data
        int ncol, // total number of variables of the dataset
        int nrow, // total number of objects of the dataset
        int i, // calculating the distance from i to cluster j
        //int j, // index of the cluster
        int k, // total number of clusters
        double* cen,
        int ndist,
        int *selected_distances) {// array of centers 
  
  int d = 0, j, pos, iter, updated = 0, maxp = 0, the_cluster, the_d = 0;
  double dd, min, max, newvalue;
  double distance[k];
  int ranking[k];
  double points[k];
  
  for(j = 0; j < k; j++) {
    points[j] = 0.0;
  }
  
  for(d = 0; d < ndist; d++) { // for each distance
    
    the_d = selected_distances[d];
    printf("The d %d", the_d);
    
    for(j = 0; j < k; j++) { // for each cluster
      
      // Calculate the distance from the point to the cluster j
      dd = distance_measure2(the_d, // index of the distance
                            x, // data
                            ncol, // total number of variables of the dataset
                            nrow, // total number of objects of the dataset
                            i, // calculating the distance from i to cluster j
                            j, // index of the cluster
                            k, // total number of clusters
                            cen);
      
      distance[j] = dd;
      printf("[p%d] RANKING -> Distance between p%d (%f,%f) and c%d (%f,%f) = %f \n", i+1, i+1, x[i], x[i+nrow], j+1, cen[j], cen[j+k], dd);
      
    }
    
    // Now distance contains the distance d from the point i to each cluster
    
      for(iter = 0; iter < k; iter++) {
        printf("%f ", distance[iter]);
      }
    printf("\n"); 
      
      // We are going to translate this measures to a ranking
    
    // We need to iterate over the values of the distances stored in the vector distance
    // For each iter, check which is the mim value and then calculate the different
    // so the ones with 0 difference are the closest
    pos = 1;
    
    // Just in case that there is a distance 0 between the point and the center
    // This happens when the centers are picked up randomly from the data
    // for the first iteration
    for(j = 0; j < k; j++) { 
      if(distance[j] == 0.0) {
        ranking[j] = pos;
        updated = 1;
      }
    }
    
    if(updated == 1) {
      pos++;
    }
    
    // k is the total number of clusters
    for(iter = 0; iter < k; iter++) {
      
      min = INFINITY;
      
      // Get the min value in the vector distance at the moment
      for(j = 0; j < k; j++) { 
        // The ones with 0 does not count
        if(distance[j] != 0) {
          if(distance[j] < min) {
            min = distance[j];
          }
        }
      }
      
      //printf("--> min = %f\n", min);
      
      for(j = 0; j < k; j++) { 
        newvalue = distance[j] - min;
        if(newvalue >= 0)
          distance[j] = newvalue;
        if(distance[j] == 0 && newvalue == 0) {
          ranking[j] = pos;
        } 
      }
      
      
      //for(j = 0; j < k; j++) {
        //printf("%f ", distance[j]);
        //}
      //printf("\n"); 
      
      // Increment the position for the next
      pos++; 
      
    } // For each ranking
    
    // ranking for this distance
    // plurality
    if(dist == 101) {
      for(j = 0; j < k; j++) { 
        printf("%d ", ranking[j]);
        if(ranking[j] == 1) {
          points[j] += 1.0;
        }
      }
      printf("\n");
    }
    // borda
    else {
      // For each cluster
      for(j = 0; j < k; j++) { 
        printf("%d ", ranking[j]);
        // Find the position with the biggest value
        if(ranking[j] > maxp){
          maxp = ranking[j];
        }
      }
      printf("\n");
      double max = (double) maxp;
      printf("Max: %f\n", max);
      // Give points to each candidate according to their position
      // These points are stored directly in the vector points, which
      // updates the score of each candidate in each iteration
      for(j = 0; j < k; j++) { 
        points[j] += max - (double) ranking[j];
      }
    }
    
    
    // Print points
    for(j = 0; j < k; j++) { 
      printf("Points: %f ", points[j]);
    }
    printf("\n");
    
  } // end of "for each distance"
  
  maxp = 0;
  the_cluster = 0; // Initial value of the cluster (empty)
  for(j = 0; j < k; j++) { 
    if(points[j] > maxp) { // The cluster with more points is the winner
      maxp = points[j];
      the_cluster = j;
    }
  }
  
  
  return the_cluster+1;
}
*/