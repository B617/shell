#include <stdio.h>

int main()
{
    char c;
    char s[10000];
    int i=-1;
    while((c=getchar())!='\n'){
        s[++i]=c;
    }
    puts(s);
    return 0;

}
