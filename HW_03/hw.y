%union{
  char *name;
  int val;
}

%{
#include <stdio.h>
#include "hw_table.h"
#define FIRSTADDR 0
#define DEFAULT 1

%}

%token		COLOEQ EQ NOTEQ LT GT LE GE
%token		CONST VAR FUNCTION BEGINN END IF THEN WHILE
%token		DO RETURN WRITE WRITELN ODD IDENT NUMBER

%token  <name> IDENT
%token  <val>  NUMBER

%%
program	:  			{ blockBegin(FIRSTADDR); } 
		  block '.'
		;

block		: 			{  }
                declList		{ 		    			  }
                statement		{ blockEnd(); }
		;

declList	: /* empty */
		| declList decl
		;

decl		: constDecl
		| varDecl
		| funcDecl
		;

constDecl	: CONST numberList ';'
		;
		
numberList	: IDENT EQ NUMBER		{ enterTconst($1, $3); }
		| numberList COMMA IDENT EQ NUMBER
                  				{ enterTconst($3, $5); }
		;

varDecl	: VAR identList ';'
		;
		
identList	: IDENT 			{ enterTvar($1); }
		| identList COMMA IDENT	{ enterTvar($3); }
		;

optParList	: /* empty */
		| parList
		;
parList        : IDENT 			{ enterTpar($1); }
		| parList COMMA IDENT	{ enterTpar($3); increase_pars(); }
		;

funcDecl	: FUNCTION IDENT   	{ enterTfunc($2, DEFAULT ); blockBegin(FIRSTADDR); }
                  '('  optParList ')' 	{ } 
			block ';'
		;

statement	: /* empty */
		| IDENT COLOEQ expression
                    			{ }
		| BEGINN statement stateList END
		| IF condition THEN   {  }
                   statement       {  }
		| WHILE		{ }
		   condition DO	{ }
                    statement	{ 			}
		| RETURN expression	{  }
		| WRITE expression	{  }
		| WRITELN		{  }	
		;

stateList	: /* empty */
		| stateList ';' statement
		;

condition	: ODD expression 			{ }
		| expression EQ expression 		{ }
		| expression NOTEQ expression 	{ }
		| expression LT expression 		{ }
		| expression GT expression 		{ }
		| expression LE expression 		{ }
		| expression GE expression 		{ }
		;

expression	: '-'  term 	{ }
		   termList 
		| term  termList
		;
		
termList	:  /* empty */
		| termList '+' term 	{ }
		| termList '-' term 	{ }
		;

term		: factor factList
		;
factList	: /* empty */
		| factList '*' factor 	{  }
		| factList '/' factor 	{  }
		;

factor		: IDENT	{ }
		| NUMBER 	{ }

		| IDENT '(' expList ')'	{ }
		| '(' expression ')'
		;
		
expList	: 
		| expression
		| expList ',' expression
		;

COMMA	: ','
		| 		{ warning("warning: missing comma\n");}
		;

%%

int noError = 1;

warning(char* s) { fprintf(stderr, s); }

yyerror(char* s) {
  fprintf(stderr, s);
  noError = 0;
}

main(){ 
  yyparse();
  if (noError) { 
    printTable();
  }
}




