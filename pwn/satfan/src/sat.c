#include<stdio.h>
#include<string.h>

#define max(a,b) ((a)>(b)?(a):(b))

char flag[30] = {};
int L, N;
char assign[26] = {};
char formula[105] = {};

int sat(int d){
	if(d >= N){
		char s = ~0;
		char e = 0;
		for(int i = 0; i <= L; i++){
			char c = formula[i];
			if(i == L || c == '*'){
				s &= e;
				e = 0;
			}
			else if(c >= 'a'){
				e |= ~assign[c-'a'];
			}
			else{
				e |= assign[c-'A'];
			}
		}
		return s;
	}
	else{
		assign[d] = 0;
		if(sat(d+1))return 1;
		assign[d] = ~0;
		if(sat(d+1))return 1;
		return 0;
	}
}

int main(void){
	setbuf(stdin,NULL);
	setbuf(stdout,NULL);
	setbuf(stderr,NULL);

	FILE* fp = fopen("flag","r");
	if(fp == NULL)return 0;
	fgets(flag,25,fp);
	fclose(fp);
	for(;;){
		printf("> ");
		if(fgets(formula,100,stdin) == NULL)break;
		L = strlen(formula);
		if(formula[L-1] == '\n'){
			formula[L-1] = '\0';
			L--;
		}
		N = 0;
		for(int i = 0; i < L; i++){
			char c = formula[i];
			if(c == '*')continue;
			else if(c >= 'a'){
				N = max(N,c-'a'+1);
			}
			else{
				N = max(N,c-'A'+1);
			}
		}
		puts(sat(0) ? "SAT" : "UNSAT");
	}
}
