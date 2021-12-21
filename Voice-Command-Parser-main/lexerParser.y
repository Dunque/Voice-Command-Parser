%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/stat.h>

int numLinea = 0;
char* cuerpoAcc;

void yyerror (char const *);
extern int yylex();
extern int yylineno;
%}
%union{
	char * valString;
}
%token <valString> BUSCAR CREAR ABRIR CUERPO ENGINE CARPETA ARCHIVO PROGRAMA
%type <valString> orden accion busqueda creacion ejecucion cuerpoRec
%start S
%%

S : orden
	;

orden : accion
	| orden accion
	;

accion : busqueda
	| creacion
	| ejecucion
	;

busqueda : BUSCAR cuerpoRec ENGINE { 
									 char str[300];
									 sprintf(str, "python3 search.py \"%s\" \"%s\"", $3, $2);
									 system (str);
								   }
	| BUSCAR ENGINE cuerpoRec {	
								char str[300];
								sprintf(str, "python3 search.py \"%s\" \"%s\"", $2, $3);
								system (str); 
							  }
	|error		{yyerro()}
	;

cuerpoRec : CUERPO {$$ = $1;}
	| cuerpoRec CUERPO { strcat(strcat($1," "),$2);}
	;

creacion : CREAR CARPETA CUERPO		{if (mkdir($3)==-1) printf("Error %s",strerror(errno));}
	| CREAR ARCHIVO CUERPO			{if (open($3)==-1) printf("Error %s",strerror(errno));}
	;

ejecucion : ABRIR PROGRAMA			{}
	;

%%
int main(int argc, char *argv[]) {
extern FILE *yyin;

	switch (argc) {
		case 1:	yyin=stdin;
			yyparse();
			break;
		case 2: yyin = fopen(argv[1], "r");
			if (yyin == NULL) {
				printf("ERROR: No se ha podido abrir el fichero.\n");
			}
			else {
				yyparse();
				fclose(yyin);
			}
			break;
		default: printf("ERROR: Demasiados argumentos.\nSintaxis: %s [fichero_entrada]\n\n", argv[0]);
	}

	return 0;
}

void yyerror (char const *s) { 
	fprintf(stderr, "Error: %s\n", s); 
}
