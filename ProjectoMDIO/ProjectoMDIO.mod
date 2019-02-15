/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Ricardo
 * Creation Date: 18/11/2018 at 18:59:49
 *********************************************/

 int n = ...;
 int Norte[1..n][1..n] = ...;
 int Sul[1..n][1..n] = ...;
 int Este[1..n][1..n] = ...;
 int Oeste[1..n][1..n] = ...;
 int Custos[1..(n*n)][1..(n*n)];
 
 dvar int x[1..(n*n)][1..(n*n)];
 
execute{
 	for(var a = 1; a <= n*n; a++) {
 		for(var b = 1; b <= n*n; b++) {
 			Custos[a][b] = 10000;
 			if(a>b){
 				if(a-b==1 && (a%n) != 0 && (a%n) != 1) Custos[a][b] = Oeste[Opl.ceil(a/n)][(a%n)];
 				if(a-b==1 && (a%n) == 0) Custos[a][b] = Oeste[Opl.ceil(a/n)][(a%n)+n];
 				if(a-b==n && (a%n) != 0  && (a%n) != 1) Custos[a][b] = Norte[Opl.ceil(a/n)][(a%n)];
 				if(a-b==n && (a%n) == 0) Custos[a][b] = Norte[Opl.ceil(a/n)][(a%n)+n];
 				if(a-b==n && (a%n) == 1) Custos[a][b] = Norte[Opl.ceil(a/n)][(a%n)];			
 			}
 			if(b>a){
 				if(b-a==1 && (a%n) != 0 && (a%n) != 1) Custos[a][b] = Este[Opl.ceil(a/n)][(a%n)];
 				if(b-a==1 && (a%n) == 1) Custos[a][b] = Este[Opl.ceil(a/n)][(a%n)];
 				if(b-a==n && (a%n) != 0 && (a%n) != 1) Custos[a][b] = Sul[Opl.ceil(a/n)][(a%n)];
 				if(b-a==n && (a%n) == 0) Custos[a][b] = Sul[Opl.ceil(a/n)][(a%n)+n];
 				if(b-a==n && (a%n) == 1) Custos[a][b] = Sul[Opl.ceil(a/n)][(a%n)];			
  			}	 			
 		}
	}
 }
 
 minimize sum (i in 1..(n*n), j in 1..(n*n)) Custos[i][j]*x[i][j];
 
 subject to{
 	r1: forall(i in 1..(n*n)) x[i][i] == 0;
 	r2: sum(j in 1..(n*n))(x[1][j]-x[j][1]) == (n*n)-1;
 	r3: forall (i in 2..(n*n)) sum(j in 1..(n*n)) (x[i][j]-x[j][i]) == -1; 
 	r4: forall (i in 1..(n*n), j in 1..(n*n)) x[i][j] >= 0;
 }
 
 
 execute {
 	if (cplex.getCplexStatus() == 1) { 	
 		writeln("dual of r1: ", r1.dual); 
 		writeln("dual of r2: ", r2.dual); 
 		writeln("dual of r3: ", r3.dual); 
 		writeln("dual of r4: ", r4.dual); 	
 	} 
 }