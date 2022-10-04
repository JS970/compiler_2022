%{
#include <stdio.h>
#include <stdlib.h>
unsigned symbolCount=0, digitCount=0, identCount=0, lineCount=0;
%}

eol \n
letter [A-Za-z]
digit [0-9]

%%
"+"		{ printf("Symbol : +\n"); symbolCount++; }
"-"		{ printf("Symbol : -\n"); symbolCount++; }
"*"		{ printf("Symbol : *\n"); symbolCount++; }
"/"		{ printf("Symbol : /\n"); symbolCount++; }
"("		{ printf("Symbol : (\n"); symbolCount++; }
")"		{ printf("Symbol : )\n"); symbolCount++; }
";"		{ printf("Symbol : ;\n"); symbolCount++; }
","		{ printf("Symbol : ,\n"); symbolCount++; }
"."		{ printf("Symbol : .\n"); symbolCount++; }

"="		{ printf("EQ : = \n"); }
"<>"		{ printf("NOTEQ : <>\n"); }
"<"		{ printf("LT : <\n"); }
">"		{ printf("GT : >\n"); }
"<="		{ printf("LE : <=\n"); }
">="		{ printf("GE : >=\n"); }
":="		{ printf("COLOEQ : :=\n"); }

"const"		{ printf("CONST : const\n"); }
"var"		{ printf("VAR : var\n"); }
"function"	{ printf("FUNCTION : function\n"); }
"begin"		{ printf("BEGIN : begin\n"); }
"end"		{ printf("END : end\n"); }
"if"		{ printf("IF : if\n"); }
"then"		{ printf("THEN : then\n"); }
"while"		{ printf("WHILE : while\n"); }
"do"		{ printf("DO : do\n"); }
"return"	{ printf("RETURN : return\n"); }
"write"		{ printf("WRITE : write\n"); }
"writeln"	{ printf("WRITELN : writeln\n"); }
"odd"		{ printf("ODD : odd\n"); }
 
{digit}				{ printf("Number : %s\n", yytext); digitCount++; }
{letter}+({letter}|{digit})* 	{ printf("Identifier : %s\n", yytext); identCount++; }
{eol} 				{ lineCount++; }
[ \t\n]				;

%%

int main()
{


yylex();
printf("symbolCount : %d\n", symbolCount);
printf("digitCount :  %d\n", digitCount);
printf("identCount : %d\n" , identCount);
printf("lineCount : %d\n", lineCount);

return 0;
}
