%{
    #include "global.h"

    int yylex ();
    void yyerror ();
      
    int offset, len, commandDone;
%}

%token STRING

%%
line            :   /* empty */
                    |command                        {   execute();  commandDone = 1;   }
;

command         :   fgCommand
                    |fgCommand '&'
;

fgCommand       :   simpleCmd
;

simpleCmd       :   progInvocation inputRedirect outputRedirect
;

progInvocation  :   STRING args
;

inputRedirect   :   /* empty */
                    |'<' STRING
;

outputRedirect  :   /* empty */
                    |'>' STRING
;

args            :   /* empty */
                    |args STRING
;

%%

/****************************************************************
                  �ʷ���������
****************************************************************/
int yylex(){
    //��������������inputBuff�Ƿ�����lex�Ķ��壬ʵ���ϲ��������κβ��������ڿ��Թ�����
    int flag;
    char c;
    
	//�����ո��������Ϣ
    while(offset < len && (inputBuff[offset] == ' ' || inputBuff[offset] == '\t')){ 
        offset++;
    }
    
    flag = 0;
    while(offset < len){ //ѭ�����дʷ������������ս��
        c = inputBuff[offset];
        
        if(c == ' ' || c == '\t'){
            offset++;
            return STRING;
        }
        
        if(c == '<' || c == '>' || c == '&'){
            if(flag == 1){
                flag = 0;
                return STRING;
            }
            offset++;
            return c;
        }
        
        flag = 1;
        offset++;
    }
    
    if(flag == 1){
        return STRING;
    }else{
        return 0;
    }
}

/****************************************************************
                  ������Ϣִ�к���
****************************************************************/
void yyerror()
{
    printf("������������ȷ�����������룡\n");
}

/****************************************************************
                  main������
****************************************************************/
int main(int argc, char** argv) {
    int i;
    char c;

    init(); //��ʼ������
    commandDone = 0;
    
    printf("chilu@Ubuntu:%s$ ", get_current_dir_name()); //��ӡ��ʾ����Ϣ

    while(1){
        i = 0;
        while((c = getchar()) != '\n'){ //����һ������
            inputBuff[i++] = c;
        }
        inputBuff[i] = '\0';

        len = i;
        offset = 0;
        
        yyparse(); //�����﷨�����������ú�����yylex()�ṩ��ǰ����ĵ��ʷ���

        if(commandDone == 1){ //�����Ѿ�ִ����ɺ������ʷ��¼��Ϣ
            commandDone = 0;
            addHistory(inputBuff);
        }
        
        printf("chilu@Ubuntu:%s$ ", get_current_dir_name()); //��ӡ��ʾ����Ϣ
     }

    return (EXIT_SUCCESS);
}
