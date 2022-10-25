%{
#include "practice.tab.h" // change this line adapt to your yacc file
char *tname;
%}

%option noyywrap

symbol      [+\-*/();,.]
digit       [0-9]
letter      [a-zA-Z]

%%
{symbol}		{ return yytext[0];	}
":="			{ return COLOEQ;}   // print as string
"="			{ return EQ; }
"<>"			{ return NOTEQ;}
"<"			{ return LT;	}
">"			{ return GT; }
"<="			{ return LE;  }
">="			{ return GE;  }
"const"		{ return CONST; }
"var"			{ return VAR;  }
"function"		{ return FUNCTION; }
"begin"		{ return BEGINN;}
"end"			{ return END;}
"if"			{ return IF;  }
"then"			{ return THEN; }
"while"		{ return WHILE;	}
"do"			{ return DO;}
"return"		{ return RETURN; }
"write"		{ return WRITE; }
"writeln"		{ return WRITELN; }
"odd"			{ return ODD; }
{letter}({letter}|{digit})*	{ tname = (char*)malloc(strlen(yytext)+1); strcpy(tname, yytext); yylval.name = tname; return IDENT; }
{digit}+		{ yylval.val = atoi(yytext); return NUMBER; }
[ \t\n\r]			
.			{ printf("Unknown token[%s]\n",yytext);}
%%
/*
*/
