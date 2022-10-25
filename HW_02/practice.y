%{
#include <stdio.h>
int yylex();
void yyerror();
%}

%union
{
char *name;
int val;
}

%token COLOEQ EQ NOTEQ
%token LT GT LE GE
%token CONST VAR FUNCTION
%token BEGINN END IF THEN WHILE DO RETURN
%token WRITE WRITELN
%token ODD
%token IDENT NUMBER

%%
program: block '.' { printf("program -> block .\n"); }
;

block: declList statement { printf("block -> declList statement\n"); }
;

declList: declList decl { printf("declList -> declList decl\n"); }
	| // { printf("declList -> EMPTY\n"); } // First EMPTY spot
;

decl: constDecl { printf("decl -> constDecl\n"); }
    | varDecl { printf("decl -> varDecl\n"); }
    | funcDecl { printf("decl -> funcDecl\n"); }
;

constDecl: CONST numberList ';' { printf("constDecl -> CONST numberList ;\n"); }
;

numberList: IDENT EQ NUMBER { printf("numberList -> IDENT EQ NUMBER\n"); }
	  | numberList COMMA IDENT EQ NUMBER { printf("numberList -> numberList COMMA IDENT EQ NUMBER\n"); }
;

varDecl: VAR identList ';' { printf("varDecl -> VAR identList ;\n"); }
;

identList: IDENT { printf("identList -> IDENT\n"); }
	 | identList COMMA IDENT { printf("identList -> identList COMMA IDENT\n"); }
;

optParList: parList { printf("optParList -> parList\n"); }
	  | { printf("ioptParList -> EMPTY\n"); } // Empty
;

parList: IDENT { printf("parList -> IDENT\n"); }
       | parList COMMA IDENT { printf("parList -> parList COMMA IDENT\n"); }
;

funcDecl: FUNCTION IDENT '(' optParList ')' block ';' { printf("funcDecl -> FUNCTION IDENT ( optParList ) block ;\n"); }
;

statement: IDENT COLOEQ expression { printf("statement -> IDENT COLOEQ expression\n"); }
	 | BEGINN statement stateList END { printf("statement -> BEGINN statement stateList END\n"); }
	 | IF condition THEN statement { printf("statement -> IF condition THEN statement\n"); }
	 | WHILE condition DO statement { printf("statement -> WHILE condition DO statement\n"); }
	 | RETURN expression { printf("statement -> RETURN expression\n"); }
	 | WRITE expression { printf("statement -> WRITE expression\n"); }
	 | WRITELN { printf("statement -> WRITELN\n"); }
	 | { printf("statement -> EMPTY\n"); } // Empty
;

stateList: stateList ';' statement { printf("stateList -> stateList ; statement\n"); }
	 | // { printf("stateList -> EMPTY\n"); }  // Empty
;

condition: ODD expression { printf("condition -> ODD expression\n"); }
	 | expression EQ expression { printf("condition -> expression EQ expression\n"); }
	 | expression NOTEQ expression { printf("condition -> expression NOTEQ expression\n"); }
	 | expression LT expression { printf("condition -> expression LT expression\n"); }
 	 | expression GT expression { printf("condition -> expression GT expression\n"); }
	 | expression LE expression { printf("condition -> expression LE expression\n"); }
	 | expression GE { printf("condition -> expression GE\n"); }
;

expression: '-' term termList { printf("expression -> - term termList\n"); }
	  | term termList { printf("expression -> term termList\n"); }
;

termList: termList '+' term { printf("termList -> termList + term\n"); }
	| termList '-' term { printf("termList -> termList - term\n"); }
| { printf("termList -> EMPTY\n"); }  // Empty
;

term: factor factList { printf("term -> factor factList\n"); }
;

factList: factList '*' factor { printf("factList -> factList * factor\n"); }
        | factList '/' factor { printf("factList -> factList / factor\n"); }
        | { printf("factList -> EMPTY\n"); } // Empty
;

factor: IDENT { printf("factor -> IDENT\n"); }
      | NUMBER { printf("factor -> NUMBER\n"); }
      | IDENT '(' expList ')' { printf("factor -> IDENT ( expList )\n"); }
      | '(' expression ')' { printf("(factor -> ( expression )\n"); }
;

expList: expression { printf("expList -> expression\n"); }
       | expList ',' expression { printf("expList -> expList , expression\n"); }
       | { printf("expList -> EMPTY\n"); } // Empty
;

COMMA: ',' { printf("COMMA -> ,\n"); }
;

%%
int main(int argc, char * argv[])
{
	yyparse();
}

void yyerror(char * s)
{
	fprintf(stderr, "erros: %s\n", s);
}


