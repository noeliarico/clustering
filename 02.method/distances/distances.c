#include<math.h>
#include<stdio.h>
#include<stdlib.h>


/*
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
    //printf("\n-- sum: %f\n", sum);
    
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

*/

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
  double xi = 0.0, yi = 0.0;
  double sum, max, da, db;
  double numerator, denominator;
  double sum1, sum2, sum3, sum4;
  
  switch (distance) {
  
  ////////////////////////////////////////////////////////////////////////////////
  // Lp Minkowski distance measures //////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  
  case 1: // Manhattan distance
    for(c = 0; c < ncol; c++) { 
      tmp = x[i+nrow*c] - cen[j+k*c];
      dd += fabs(tmp); // add the absolute value of the difference
    }
    return dd;
    
  case 2: // Euclidean distance
    for(c = 0; c < ncol; c++) { // for each column
      tmp = x[i+nrow*c] - cen[j+k*c]; // distance between point and center in that dimension
      //printf("tmp en distances.c: %f\n", tmp);
      dd += tmp * tmp; // square the value
    }
    dd = pow(dd, 1.0/2.0);
    //printf("Euclidean distance en distances.c= %f \n", dd);
    return dd;
    
  case 3: // Chebyshex distance
    max  = 0.0;
    sum1 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum1 = fabs(xi - yi);
      if(max < sum1) {
        max = sum1;
        //printf("-- Yes\n");
      }
    }
    return max;
    
  ////////////////////////////////////////////////////////////////////////////////
  // L1 distance measures ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
    
  case 4: // canberra
    
    sum = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      numerator = fabs(xi - yi);
      denominator = fabs(xi) + fabs(yi);
      if(denominator > 0) {
        sum += numerator / denominator;
      }
    }
    return sum;
    
  case 5: // Gower distance or Average Manhattan
    
    sum = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      numerator = fabs(xi - yi);
      sum += numerator;
    }
    return sum / ncol;
    
  ////////////////////////////////////////////////////////////////////////////////
  // Inner product distance measures /////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  
  case 6: // Jaccard distance 
    
    sum1 = 0.0, sum2 = 0.0, sum3 = 0.0, sum4 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum1 += (xi - yi) * (xi - yi);
      sum2 += xi * xi;
      sum3 += yi * yi;
      sum4 += xi * yi;
    }
    if(sum1 == 0 || sum2 == 0 || sum3 == 0) {
      return 0;
    }
    else{
      return (sum1 / (sum2 + sum3 + sum4));
    }
    
    
  case 7: // Cosine distance 
    
    sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum1 += xi * yi;
      sum2 += xi * xi;
      sum3 += yi * yi;
    }
    if(sum1 == 0 || sum2 == 0 || sum3 == 0) {
      return 0;
    }
    else {
      return (1 - (sum1 / (sqrt(sum2) * sqrt(sum3))));
    }
    
  ////////////////////////////////////////////////////////////////////////////////
  // Squared Chord distance measures /////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  
  case 8: // Squared chord distance (SCD)
    
    sum = 0.0, sum1 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum1 = sqrt(xi) - sqrt(yi); // difference
      sum1 = sum1 * sum1; // square of the differences
      sum += sum1;
    }
    //printf("sum = %f\n", sum);
    return sum;
    
    
  case 9: // Matusita
    
    sum = 0.0, sum1 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum1 = sqrt(xi) - sqrt(yi); // difference
      sum1 = sum1 * sum1; // square of the differences
      sum += sum1;
    }
    return sum1;
    
  ////////////////////////////////////////////////////////////////////////////////
  // Squared L2 distance measures ////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
    
  case 10:  // Clark distance
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum1 = xi - yi;
      sum2 = fabs(xi) + fabs(yi);
      if(sum2 > 0.0) {
        sum += pow((sum1 / sum2), 2);
      }
    }
    return sqrt(sum);
    
  case 11: // Squared x2 distance, a.k.a triangular discrimination distance. This distance is a quasi distance
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum1 = (xi - yi) * (xi - yi);
      sum2 = xi + yi;
      if(sum2 > 0) {
        sum += sum1 / sum2;
      }
    }
    
    return sum;
    
  ////////////////////////////////////////////////////////////////////////////////
  // Vicissitude distance measures ///////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
    
  case 12: // Vicis symmetric distance VSD
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum1 = (xi - yi) * (xi - yi);
      if(xi < yi) {
        sum2 = xi;
      }
      else {
        sum2 = yi;
      }
      sum2 = sum2 * sum2;
      if(sum2 > 0) {
        sum += sum1 / sum2;
      }
    }
    return sum;
  
  case 13: // Max symmetric x2 distane MiSCSD
    
    sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0;
    for(c = 0; c < ncol; c++) { 
      xi = x[i+nrow*c];
      yi = cen[j+k*c];
      sum1 = (xi - yi) * (xi - yi);
      if(xi > 0) {
        sum2 = sum1 / xi;
      }
      if(xi > 0) {
        sum3 = sum1 / xi;
      }
    }
    
    if(sum1 > sum2) {
      return sum2;
    }
    else {
      return sum3;
    }
    
    
    
  //////////////////////////////////////////////////////////////////////////////
  // PLURALITY /////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
 
    
  default:
    //printf("Unknown distance [%d]\n",distance);
    return 0.0;
    
  }
}


int srr(int dist, 
        double* x, // data
                 int ncol, // total number of variables of the dataset
                 int nrow, // total number of objects of the dataset
                 int i, // calculating the distance from i to cluster j
                 //int j, // index of the cluster
                 int k, // total number of clusters
                 double* cen) {// array of centers 
  
  int xi, yi, d, j, pos, iter, updated = 0, maxp = 0, the_cluster;
  double dd, min, max, newvalue;
  double distance[k];
  int ranking[k];
  double points[k];
  
  for(d = 1; d <= 13; d++) { // for each distance
    printf("Distance %d\n", d);
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
      printf("[p%d] Distance between p%d (%f,%f) and c%d (%f,%f) = %f \n", i+1, i+1, x[i], x[i+nrow], j+1, cen[j], cen[j+k], dd);
      
    }
    
    // Now distance contains the distance d from the point i to each cluster
    
    
    //for(iter = 0; iter < k; iter++) {
      //printf("%f ", distance[iter]);
    //}
    //printf("\n"); 
      
    // We are going to translate this measures to a ranking
      
    // For each iter, check which is the mim value and then calculate the different
    // so the ones with 0 difference are the closest
    pos = 1;
    
    // Just in case that there is a distance 0 between the point and the center
    // This happens when the centers are picked up randomly from the data
    // for the first iteration
    for(j = 0; j < k; j++) { 
      if(distance[j] == 0) {
        ranking[j] = pos;
        updated = 1;
      }
    }
    
    if(updated == 1) pos++;
    
    for(iter = 0; iter < k; iter++) {
      
      min = INFINITY;
      
      // get the minimum value
      
      
      for(j = 0; j < k; j++) { 
        if(distance[j] != 0 && distance[j] < min) {
          min = distance[j];
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
      
      
      for(j = 0; j < k; j++) {
        //printf("%f ", distance[j]);
      }
      //printf("\n"); 
      
      
      pos++; 
      
    }
    
    // ranking for this distance
    // plurality
    if(dist == 101) {
      for(j = 0; j < k; j++) { 
        printf("%d ", ranking[j]);
        if(ranking[j] == 1){
          points[j] += 1;
        }
      }
      printf("\n");
    }
    // borda
    else {
      max = 0;
      for(j = 0; j < k; j++) { 
        printf("%d ", ranking[j]);
        if(ranking[j] > maxp){
          maxp = ranking[j];
        }
      }
      printf("\n");
      for(j = 0; j < k; j++) { 
        points[j] += maxp - ranking[j];
      }
    }
    
    
    // print points
    for(j = 0; j < k; j++) { 
      //printf("Points: %f ", points[j]);
    }
    //printf("\n");
    
  }
  
  maxp = 0;
  the_cluster = 0;
  for(j = 0; j < k; j++) { 
    if(points[j] > maxp){
      maxp = points[j];
      the_cluster = j;
    }
  }
  
  
  return the_cluster+1;
}
