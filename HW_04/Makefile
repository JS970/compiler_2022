a.out: lex.yy.c hw_table.c hw.tab.c
	gcc lex.yy.c hw_table.c hw_codegen.c hw.tab.c -lfl

lex.yy.c: hw.l
	flex hw.l

hw.tab.c: hw.y
	bison -d hw.y

clean:
	rm a.out hw.tab.c hw.tab.h lex.yy.c
