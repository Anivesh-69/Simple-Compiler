
%{

#include<stdio.h>
extern void yyerror(char *);
#define YYSTYPE
#include "y.tab.h"
extern YYSTYPE yylval;
#define sym_type(identifier) IDENTIFIER 

#define RET_TYPE(x)				{ yylval.type = x; return(x); }
%}
%option yylineno
%%

"int"    { printf("DATA TYPE: %s\n", yytext); }{ RET_TYPE(INT); }
"char *" { printf("DATA TYPE: %s\n", yytext); }{ RET_TYPE(CHAR); }

"="       { printf("ASSIGN: %s\n", yytext); }{ return '='; }
"=="      { printf("RELATIONAL OPERATOR(EQUALS): %s\n", yytext); }{ return EQ_OP; }
"!="      { printf("RELATIONAL OPERATOR(NOT EQUALS): %s\n", yytext); }{ return NE_OP; }
"+"       { printf("PLUS: %s\n", yytext); }{ return '+'; }
"("	  { printf("PARENTHESIS: %s\n", yytext); }{ return '('; }
")"	  { printf("PARENTHESIS: %s\n", yytext); }{ return ')'; }
"-"	  { printf("MINUS: %s\n", yytext); }{ return '-'; }

"*"       { printf("MULTIPLY: %s\n",yytext); }{ return '*'; }

"/"       { printf("DIVIDE: %s\n",yytext); }{ return '/'; } 
";"	  { printf("SEMI: %s\n",yytext); } { return ';'; }

[0-9]+    { printf("NUMBER: %s\n", yytext); }{ yylval.val = makeNum(atoi(yytext)); return I_CONSTANT; }


[ \t\n]                 ;    

[a-zA-Z_][a-zA-Z0-9_]*         { printf("IDENTIFIER: %s\n", yytext); }SAVE_TOKEN; return TIDENTIFIER;
.                       printf("Synatx Error: Unknown token!n"); yyterminate();

%%

int yywrap()

{return 1;}



int main(int argc, char **argv)

{
        yyin=fopen("sample.cu","r");
        yyout=fopen("lexer.txt","w");
        fprintf(yyout,"\tLexeme\t\t\tToken\t\t\tValue\n");
	yylex();
        fclose(yyout);
        fclose(yyin);
        return 0;

}
