#include<stdio.h>
int b[100]={0};
int l=0;
void quick(int k[],int s,int t);
int main()
{
	int n,i,k[100],x,s;
	s=1;
	scanf("%d",&n);
	for(i=1;i<=n;i++)
	{
		scanf("%d",&x);
		k[i]=x;
	}
	if(n==1)
	{
		printf("1 ");
		printf("%d",k[1]);
	}
	else
	{
		quick(k,s,n);
		printf("%d ",b[0]);
		for(i=1;i<=n-1;i++)
		{
			printf("%d ",k[i]);
		}
		printf("%d\n",k[n]);
	}
	return 0;
}
void quick(int k[],int s,int t)
{
	int i,j,m,a;
	int tmp;
	if(s<t) 
	{
		i=s;
		j=t+1;
		while(1){ 
			do
			i++;
			while(!((k[s]<=k[i])||(i==t)));
			do
			j--;
			while(!((k[s]>=k[j])||(j==s)));
			if(i<j)
			{
				tmp=k[i];
				k[i]=k[j];
				k[j]=tmp;
			}
			else
				break;
		}
		a=k[s];
		tmp=k[s];
        k[s]=k[j];
		k[j]=tmp;
		for(m=0;m<=t;m++)
		{
			if(a==k[m])
			{
				b[l]=m;
				l++;
                break;
			}
		}
		quick(k,s,j-1);
		quick(k,j+1,t);
	}
}
