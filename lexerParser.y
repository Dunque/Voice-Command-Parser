%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int numLinea = 0;

void yyerror (char const *);
extern int yylex();
extern int yylineno;
%}
%union{
	char * valString;
}
%token <valString> BUSCAR CREAR ABRIR CUERPO ENGINE CARPETA ARCHIVO PROGRAMA
%type <valString> orden accion busqueda creacion ejecucion
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

busqueda : BUSCAR CUERPO ENGINE { system ("python3 search.py \"%s\" \"%s\"", ENGINE, CUERPO); }
	| BUSCAR ENGINE CUERPO { system ("python3 search.py \"%s\" \"%s\"", ENGINE, CUERPO); }
	;

creacion : CREAR CARPETA CUERPO
	| CREAR ARCHIVO CUERPO
	;

ejecucion : ABRIR PROGRAMA
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