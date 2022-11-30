typedef enum codes
{
	lit, opr, lod, sto, ict, ret, jmp,
	cal, jpc
}OpCode;

typedef enum ops
{
	wrt, wrl, neg, add, sub, mul, div, odd, eq,
	ls, gr, neq, lseq, greq
}Operator;
int genCodeV(OpCode op, int v);		
int genCodeT(OpCode op, int ti);
int genCodeO(Operator p);	
int genCodeR();			
void backPatch(int i);

int nextCode();		
void listCode();
void execute();


