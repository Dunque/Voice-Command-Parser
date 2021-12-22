%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>

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
%type <valString> orden accion busqueda creacion ejecucion cuerpoRec error
%start S
%%

S : orden
	| error {			 
			 char str[300];
			 sprintf(str, "Sintaxis errónea - Archivo input vacío");
			 yyerror(str);
		    }
	;

orden : accion
	| orden accion
	;

accion : busqueda
	| creacion
	| ejecucion
	| error { 
			 char str[300];
			 sprintf(str, "Sintaxis errónea - no se reconoció ningún comando %s", $1);
			 yyerror(str);
			}
	;

busqueda : BUSCAR cuerpoRec ENGINE { 
									 char str[300];
									 sprintf(str, "python3 search.py \"%s\" \"%s\" &", $3, $2);
									 system (str);
								   }
	| BUSCAR ENGINE cuerpoRec {	
								char str[300];
								sprintf(str, "python3 search.py \"%s\" \"%s\" &", $2, $3);
								system (str); 
							  }
	| BUSCAR cuerpoRec error {
							   char str[300];
							   sprintf(str, "Sintaxis errónea - %s %s - se encontró %s en vez del motor de búsqueda", $1, $2,$3);
							   yyerror(str);
							 }
	| BUSCAR ENGINE error {
							char str[300];
							sprintf(str, "Sintaxis errónea - %s %s - se encontró %s en vez de un cuerpo de búsqueda válido", $1, $2, $3);
							yyerror(str);
						  }
	| BUSCAR error {
					 char str[300];
					 sprintf(str, "Sintaxis errónea - %s - se encontró %s en vez de un cuerpo de búsqueda o motor válido", $1, $2);
					 yyerror(str);
				   }
	;

cuerpoRec : CUERPO {$$ = $1;}
	| cuerpoRec CUERPO {strcat(strcat($1," "),$2);}
	;

creacion : CREAR CARPETA CUERPO	{if (mkdir($3,S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)==-1) printf("Error %s",strerror(errno));}
	| CREAR ARCHIVO CUERPO {if (creat($3,S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)==-1) printf("Error %s",strerror(errno));}
	| CREAR error {
					char str[300];
					sprintf(str, "Sintaxis errónea - %s - se encontró %s en vez de \"carpeta\" o \"archivo\"", $1, $2);
					yyerror(str);
				  }
	| CREAR CARPETA error {
							char str[300];
							sprintf(str, "Sintaxis errónea - %s %s - se encontró %s en vez de un nombre de carpeta válido", $1, $2, $3);
							yyerror(str);
				  		  }
	| CREAR ARCHIVO error {
							char str[300];
							sprintf(str, "Sintaxis errónea - %s %s - se encontró %s en vez de un nombre de archivo válido", $1, $2, $3);
							yyerror(str);
				  		  }
	;

ejecucion : ABRIR PROGRAMA {
							 char str[300];
							 sprintf(str, "%s &", $2);
							 system (str); 
							 if(system (str)==-1) printf("Error %s",strerror(errno));
							}
	| ABRIR error {
					char str[300];
					sprintf(str, "Sintaxis errónea - %s - se encontró %s en vez de un programa válido", $1, $2);
					yyerror(str);
				  }
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
