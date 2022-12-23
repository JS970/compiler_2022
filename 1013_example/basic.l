%{
#include "basic.tab.h"
%}

%%
"c" { return c; }
"d" { return d; }
\n { return EOL; }
[\t] { }
. { printf("Can not accept %c\n", *yytext); }
%%

