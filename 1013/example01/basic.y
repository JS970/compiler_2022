%{
#include <stdio.h>
%}

%token c d
%token EOL
%%
S: C C EOL { printf("S -> C C EOL\nAccepted\n"); }
;
C: c C { printf("C -> c C\n"); }
 | d {printf("C -> d\n"); }
;
%%

int main (int argc, char *argv[])
{
	#ifdef YYDEBUG
	yydebug = 1;
	#endif
	yyparse();
}
yyerror (char *s)
{
	fprintf(stderr, "erros: %s\n", s);
}

