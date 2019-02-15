/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Ricardo
 * Creation Date: 05/12/2018 at 16:29:11
 *********************************************/
 
 int n= ...;
 int b= ...;
 int delta= ...;
 int Norte[1..n][1..n] = ...;
 int Sul[1..n][1..n] = ...;
 int Este[1..n][1..n] = ...;
 int Oeste[1..n][1..n] = ...;
 int Custos[1..(n*n)][1..(n*n)];
 
 dvar boolean y[1..(n*n)];
 dvar int t[1..(n*n)];
 
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
 
 maximize t[49];
 
 subject to{
 	t[1]==0;
	forall(i in 1..(n*n), j in 1..(n*n)) t[j]-t[i]<=Custos[i][j]+delta*y[i]; 
 	sum (i in 1..(n*n)) y[i] <= b;
 }