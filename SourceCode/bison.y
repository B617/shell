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
line            :	EOL				{return;}
                    |command EOL	{execute();commandDone=1;return;}
;

command         :   fgCommand		
                    |fgCommand AND	
;

fgCommand       :   simpleCmd		
					|fgCommand	PIPE fgCommand	
;

simpleCmd       :   progInvocation inputRedirect outputRedirect	
;

progInvocation  :   STRING args		
;

inputRedirect   :   /* empty */		
                    |INPUT STRING	
;

outputRedirect  :   /* empty */		
                    |OUTPUT STRING	
;

args            :   /* empty */		
                    |args STRING	
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
		c=getchar();
		if(c>0){
			ungetc(c,stdin);
		}
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
