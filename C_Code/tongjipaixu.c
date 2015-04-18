#include<stdio.h>
int main()
{
	int i=0,s[500]={0},y,m,n,j=0,q;
	char a[500],c,e[500]={0},temp;
	while((c=getchar())!='\n'){
		a[i]=c;
		s[a[i]]++;
		if(s[a[i]]==1){
			e[j]=c;
			j++;
		}
		i++;
	}
	for(m=0;m<j;m++){
		for(n=m+1;n<j;n++){
			if(s[e[m]]<s[e[n]]){
				temp=e[n];
				for(q=n-1;q>=m;q--){
					e[q+1]=e[q];
				}
				e[m]=temp;
			}
		}
	}
	for(y=0;y<j;y++){
		if(y%4==0)
			printf("\n");
		printf("%c-%d ",e[y],s[e[y]]);
	}
	return 0;
}
