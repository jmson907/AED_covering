/*********************************************
 * OPL 20.1.0.0 Model
 * Author: Jeongmin Son
 * Creation Date: 2023. 6. 12. at ¿ÀÈÄ 6:11:00
 *********************************************/
int isize = ...;
range I = 1..isize;
 
int jsize = ...;
range J = 1..jsize;


float w[I][J] = ...;
float fh[I] = ...;
float sh[I] = ...;
float d[I][J] = ...;
int P = ...;
float S1 = ...;
float S2 = ...;

dvar int x[J];
dvar boolean y[I][J];
dvar boolean u[I][J];
dvar float+ z1[I];
dvar boolean t1[I][J];
dvar boolean t2[I][J];
dvar float+ z2[I];

maximize sum(i in I) (fh[i] * z1[i] + sh[i] * z2[i]) ;

subject to {
  
  forall(i in I, j in J)
      u[i][j] <= y[i][j];

  forall(i in I, j in J)
      y[i][j] + u[i][j] <= x[j];
   
  sum(j in J)
     x[j] == P;
     
  forall(j in J)
    x[j] <= 2;   
     
  forall(i in I, j in J)    
      y[i][j] <= 1 - ((d[i][j] - S1) / 2500); 
    
  forall(i in I, j in J)    
      u[i][j] <= 1 - ((d[i][j] - S2) / 2500); 
    
  forall(i in I, j in J)
      w[i][j] * y[i][j] <= z1[i];  
  
  forall(i in I, j in J)
      w[i][j] * y[i][j] + 100000*(1-t1[i][j]) >= z1[i];

  forall(i in I, j in J)
      w[i][j] * u[i][j] <= z2[i];  
  
  forall(i in I, j in J)
      w[i][j] * u[i][j] + 100000*(1-t2[i][j]) >= z2[i];
         
  forall(i in I)
    sum(j in J) t1[i][j] == 1;   
     
  forall(i in I)
    sum(j in J) t2[i][j] == 1;    
    
            
    }
execute{writeln("optimal gap : " + cplex.getMIPRelativeGap());}
    
