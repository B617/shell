#include<stdio.h>
#include<string.h>
int main()
{
	char a[1000]={0},b[1000]={0},d[1000]={0},s1[1000]={0},c,s[50]={"zyxwvutsrqponmlkjihgfedcba"};
	int m,n,m1,m2,m3,i=0,x=0,y=0,z,a1,a2=0,a3,a4=0,a5,flag[500]={0};
	FILE *in,*out;
	in=fopen("encrypt.txt","r");
	out=fopen("output.txt","w");
	gets(a);
	z=strlen(a);
	while((c=fgetc(in))!=EOF){
		b[i]=c;
		i++;
	}
	for(m=0;m<z;m++){
		for(n=m+1;n<z;n++){
			if(a[m]==a[n])
				a[n]='*';
		}
	}
	for(m1=0;m1<z;m1++){
		if(a[m1]=='*')
			continue;
		else{
			d[y]=a[m1];
			y++;
		}
	}
	for(m2=0;m2<y;m2++){
		for(m3=1;m3<26;m3++){
			if(d[m2]==s[m3])
				s[m3]='#';
		}
	}
	for(a1=0;a1<m3;a1++){
		if(s[a1]=='#')
			continue;
		else{
			s1[a2]=s[a1];
			a2++;
		}
	}
	strcat(d,s1);
    for(a3=0;a3<i;a3++)
        if(b[a3]>='a'&&b[a3]<='z'){
			flag[a4]=b[a3]-'a';
            fprintf(out,"%c",d[flag[a4]]);
            a4++;
        }
        else{
            fprintf(out,"%c",b[a3]);
        }
	return 0;
}






