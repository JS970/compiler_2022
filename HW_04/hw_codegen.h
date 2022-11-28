typedef enum codes
{
	lit, opr, lod, sto, ict, ret, jmp
}OpCode;

typedef enum ops
{
	wrt, wrl
}Operator;
int genCodeV(OpCode op, int v);		
int genCodeT(OpCode op, int ti);
int genCodeO(Operator p);	
int genCodeR();			
void backPatch(int i);

int nextCode();		
void listCode();
void execute();


