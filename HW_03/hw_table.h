 /***********hw_table.h***********/

typedef enum kindT
{
	varId, funcId, parId, constId
}KindT;

void increase_pars();
void blockBegin(int firstAddr);	
void blockEnd();			
int enterTfunc(char *id, int v);	
int enterTvar(char *id);		
int enterTpar(char *id);		
int enterTconst(char *id, int v);	
int searchT(char *id, KindT k);	
KindT kindT(int i);			
void printTable();
void set_areaNumber1();
void set_areaNumber2();
void printMessage(int flag, char *id);
