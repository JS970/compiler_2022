%{
%}

digit [0-9]
integer {digit}+
floating {integer}\.{integer}
point '\.'

%%
{integer} { printf("Integer:%d\n", atoi(yytext)); }
{floating} { printf("Float:%f\n", atof(yytext)); }
%%

int main (int argc, char *argv[])
{

	yylex();
	return 0;
}


