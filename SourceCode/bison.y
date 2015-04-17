%{
    #include "global.h"
    int yylex ();
    void yyerror ();
      
    int offset, len, commandDone;
%}

%token STRING
%token OUTPUT
%token INPUT
%token AND
%token EOL
%token PIPE

%%
line            :	EOL				{printf("1\n");return;}
                    |command EOL	{printf("2\n");printf("%s\n",inputBuff);execute();commandDone=1;return;}
;

command         :   fgCommand		{printf("3\n");}
                    |fgCommand AND	{printf("4\n");}
;

fgCommand       :   simpleCmd		{printf("5\n");}
					|fgCommand	PIPE fgCommand	{printf("6\n");}
;

simpleCmd       :   progInvocation inputRedirect outputRedirect	{printf("7\n");}
;

progInvocation  :   STRING args		{printf("8\n");}
;

inputRedirect   :   /* empty */		{printf("9\n");}
                    |INPUT STRING	{printf("10\n");}
;

outputRedirect  :   /* empty */		{printf("11\n");}
                    |OUTPUT STRING	{printf("12\n");}
;

args            :   /* empty */		{printf("13\n");}
                    |args STRING	{printf("14\n");}
;
%%

/****************************************************************
                  错误信息执行函数
****************************************************************/
void yyerror()
{
    printf("你输入的命令不正确，请重新输入！\n");
}
/****************************************************************
                  main主函数
****************************************************************/
int main(int argc, char** argv) {
    int i;
    char c;
    init(); //初始化环境
    commandDone = 0;
    
    printf("chilu@Ubuntu:%s$ ", get_current_dir_name()); //打印提示符信息
    while(1){
        yyparse(); //调用语法分析函数，该函数由yylex()提供当前输入的单词符号
        if(commandDone == 1){ //命令已经执行完成后，添加历史记录信息
            commandDone = 0;
            addHistory(inputBuff);
			inputBuff[0]='\0';
        }
        
        printf("chilu@Ubuntu:%s$ ", get_current_dir_name()); //打印提示符信息
     }
    return (EXIT_SUCCESS);
}
