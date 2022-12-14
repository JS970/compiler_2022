#include "hw_table.h"
#include <stdio.h>
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
	int pars;
}Symbol;

Symbol symbolTable[MAXTABLE];
int tIndex = 0;
int cLevel = -1;
int pars = 1;
int parAddr = 0;
int varAddr = 0;
int funcAddr = 0;
int localvarAddr = 0;
int localfuncAddr = 0;
int prevlocalvarAddr;
int prevlocalfuncAddr;
int countedparIndex;
int parstartIndex;
int areaNumber;
KindT currentKind;

void set_areaNumber1()
{
	areaNumber = tIndex;
}

void set_areaNumber2()
{
	areaNumber++;
}

void increase_pars()
{
	pars++;
}

void blockBegin(int firstAddr)	
{
	if (cLevel == -1)
	{
		tIndex = 0;
	}
	prevlocalvarAddr = localvarAddr;
	prevlocalfuncAddr = localfuncAddr;
	parAddr = 0;
	cLevel ++;

	return ;
}

void blockEnd()				
{
	if (cLevel != 0)
	{
		symbolTable[countedparIndex].pars = pars;	
		int j = pars;
		for(int i = 0; i <= pars; i++)
		{
			symbolTable[parstartIndex + i - 1].addr = (-1*(j--));
		}	
		pars = 1;
	}
	cLevel --;
	localvarAddr = prevlocalvarAddr;
	localfuncAddr = prevlocalfuncAddr;
	return ;
}

int enterTfunc(char *id, int v)		
{
	countedparIndex = tIndex;
	strcpy(symbolTable[tIndex].name, id);
	symbolTable[tIndex].type = funcId;
	symbolTable[tIndex].pars = v;
	symbolTable[tIndex].level = cLevel;
	symbolTable[tIndex].addr = localfuncAddr++;
	return tIndex++;
}

int enterTpar(char *id)				
{
	if(pars == 1)
		parstartIndex = tIndex;
	strcpy(symbolTable[tIndex].name, id);
	symbolTable[tIndex].type = parId;
	symbolTable[tIndex].level = cLevel;
	return tIndex++;
}

int enterTvar(char *id)			
{
	strcpy(symbolTable[tIndex].name, id);
	symbolTable[tIndex].type = varId;
	symbolTable[tIndex].level = cLevel;
	symbolTable[tIndex].addr = localvarAddr++;
	return tIndex++;
}

int enterTconst(char *id, int v)		
{
	strcpy(symbolTable[tIndex].name, id);
	symbolTable[tIndex].type = constId;
	symbolTable[tIndex].val = v;
	return tIndex++;
}

void printMessage(int flag, char*id)
{
	if(flag == -1)
	{
		printf("undef\n");
		printf("Can't find symbol (%s, var) in the table\n", id);
	}
	
	else
	{
		switch(currentKind)
		{
			case varId:
				printf("Index : %d\t kind : var\t Id:%s\n", flag, symbolTable[flag].name);
				break;
			case parId:
				printf("Index : %d\t kind : par\t Id:%s\n", flag, symbolTable[flag].name);
				break;
			case constId:
				printf("Index : %d\t kind : const\t Id:%s\n", flag, symbolTable[flag].name);
				break;
			case funcId:
				break;

		}
	}
}

int searchT(char *id, KindT k)		
{
	int idx = -1;
	k = parId;
	for(int i = areaNumber; i < MAXTABLE; i++)
	{
		if(!strcmp(symbolTable[i].name, id) && symbolTable[i].type == k)
		{
			idx = i;
			break;
		}
	}
	if(idx == -1)
	{
		k = varId;
		for(int i = areaNumber; i < MAXTABLE; i++)
		{
			if(!strcmp(symbolTable[i].name, id))
			{
				if(symbolTable[i].type == k)
				{   
					idx = i;
					break;
				}
			}
		}
	}
	if(idx == -1)
	{
		k = constId;
		for(int i = areaNumber; i < MAXTABLE; i++)
		{
			if(!strcmp(symbolTable[i].name, id) && symbolTable[i].type == k)
			{
				idx = i;
				break;
			}
		}
	}	
	currentKind = k;
	return idx;
}

void printTable() 
{
	int i;
	printf("Index\t KindT\t name\t value\t level\t addr\t pars\n");
	for(i = 0; i < tIndex; i++)
	{
		switch(symbolTable[i].type)
		{
			case varId:
				printf("[%d]\t var\t %s\t \t %d\t %d\n", 
				i,
				symbolTable[i].name,
				symbolTable[i].level,
				symbolTable[i].addr
				);
				break;

			case funcId:
				printf("[%d]\t func\t %s\t \t %d\t %d\t %d\n", 
				i,
				symbolTable[i].name,
				symbolTable[i].level,
				symbolTable[i].addr,
				symbolTable[i].pars
				);
				break;

			case parId:
				printf("[%d]\t par\t %s\t \t %d\t %d\n", 
				i,
				symbolTable[i].name,
				symbolTable[i].level,
				symbolTable[i].addr
				);
				break;

			case constId:
				printf("[%d]\t const\t %s\t %d\n", 
				i,
				symbolTable[i].name,
				symbolTable[i].val
				);
				break;
		}	
	}	
}

