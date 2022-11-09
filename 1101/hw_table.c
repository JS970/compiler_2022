#include "hw_table.h"
#include <stdlib.h>
#include <string.h>

#define MAXTABLE 100		
#define MAXNAME  31		
#define MAXLEVEL 5	

typedef struct symbol
{
	KindT type;
	char name[MAXNAME];
	int val;
	int level;
	int addr;
}Symbol;

Symbol symbolTable[MAXTABLE];
int tIndex = 0;
int cLevel = -1;
int localAddr = 0;

void blockBegin(int firstAddr)	
{
	if (cLevel == -1)
	{
		tIndex = 0;
	}
	localAddr = 0;
	cLevel ++;

	return ;
}

void blockEnd()				
{
	cLevel --;

	return ;
}

int enterTfunc(char *id, int v)		
{
}

int enterTpar(char *id)				
{
}

int enterTvar(char *id)			
{
}

int enterTconst(char *id, int v)		
{
	strcpy(symbolTable[tIndex].name, id);
	symbolTable[tIndex].type = constId;
	symbolTable[tIndex].val = v;
	return tIndex++;
}

int searchT(char *id, KindT k)		
{
}

void printTable() 
{
	int i;
	for(i = 0; i < tIndex; i++)
	{
		printf("Index : %d\t, Kind : %s\n", i, symbolTable[i].type); 
	}	
}
