%{
#include <stdio.h>
%}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%%

calclist: // Empty
	| calclist exp EOL { printf("=%d\n", $2); }
;

exp: factor
   | exp ADD factor { $$ = $1 + $3; }
   | exp SUB factor { $$ = $1 - $3; }
;

factor: term
      | factor MUL term { $$ = $1 * $3; }
      | factor DIV term { $$ = $1 / $3; }
;

term: NUMBER
    | ABS term { $$ = $2 >= 0 ? $2 : -$2; }
;

%%
int main (int argc, char *argv[])
{
	#ifdef YYDEBUG
	yydebug = 1;
	#endif
	yyparse();
}
yyerror(char *s)
{
	fprintf(stderr, "erros: %s\n", s);
}

