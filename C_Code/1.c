#include<stdio.h>
int a[100]={0};
void adjust(int a[],int i,int n)
{
	int j;
	int temp;
	temp=a[i];
	j=2*i;
	while(j<=n) 
	{
		if(j<n&&a[j]<a[j+1])
			j++;
		if(temp>=a[j]) 
			break;
		a[j/2]=a[j];
		j=2*j;
	}
	a[j/2]=temp;
}
void duipaixu(int a,int n)
{
	int i;
	int temp;
	for(i=n/2;i>=1;i--)
		adjust(a,i,n);
	for(i=n-1;i>=1;i--) 
	{
		temp=a[i+1];
		a[i+1]=a[1];
		a[1]=temp;
		adjust(a,1,i);
	}
}
int main()
{
	int z,p,n;
	scanf("%d",&n);
	for(z=0;z<n;z++)
	{
		scanf("%d",&p);
		a[z]=p;
	}
	duipaixu(a,n);
	for(z=0;z<n;z++)
	{
		printf("%d",a[z]);
	}
	return 0;
}
