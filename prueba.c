#include <R.h>
#include <Rinternals.h>

SEXP sumnoelia(SEXP a, SEXP b) {
  SEXP result = PROTECT(allocVector(REALSXP, 1));
  REAL(result)[0] = asReal(a) + asReal(b);
  UNPROTECTED(1);
  return(result);
}

//void calculate_points(int *ranking, int *points, int *pn_objects) 
//{
    //int i, total = 0;
    //int n_objects = *pn_objects;
    
    //printf("Total: %d\n",total);
    //printf("n_objects: %d\n",n_objects);
     
    //for(i = 0; i < n_objects; i=i+1) {
        
        //if(ranking[i] == 1) {
          //printf("i=: %d\n",i);
          //total = total + 1;
        //}
    //}
    
    //printf("Total: %d\n",total);
    
    //for(i = 0; i < n_objects; i=i+1) {
      //  if(ranking[i] == 1) {
        //    printf("i=: %d\n",i);
        //  points[i] = 2;
        //  printf("%f\n", ((double) 1)/((double)total));
        //}
    //}
    //*pn_objects = 3;
//    printf("End\n");
   
//}
