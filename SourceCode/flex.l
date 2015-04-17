%{
	#include "global.h"
	enum yytokentype{
		STRING	=258,
		INPUT	=259,
		OUTPUT	=260,
		AND		=261,
		EOL		=262,
		PIPE	=263
	};
	int input_i=-1;
	void copyarray(char a[],char b[]){
		int l=strlen(b);
		int j=0;
		while(j<l){
			a[input_i++]=b[j++];
		}
	}
%}

%%
"<"	{inputBuff[input_i++]=' ';inputBuff[input_i++]='<';return INPUT;}
">"	{inputBuff[input_i++]=' ';inputBuff[input_i++]='>';return OUTPUT;}
"&"	{inputBuff[input_i++]=' ';inputBuff[input_i++]='&';return AND;}
"|"	{inputBuff[input_i++]=' ';inputBuff[input_i++]='|';return PIPE;}
[ \t]	{}
\n	{inputBuff[input_i]='\0';input_i=-1;return EOL;}
[^ \t\n&><|]+	{inputBuff[input_i++]=' ';copyarray(inputBuff,yytext);return STRING;}

%%

