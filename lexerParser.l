%{
#include <stdlib.h>
#include "lexerParser.tab.h"
%}

%option yylineno

/* BUSCAR CREAR ABRIR CUERPO ENGINE CARPETA ARCHIVO */

eol     \n
tab     \t
space   " "
buscar  (busca | encuentra) (me)+ /i
crear   (crea) (me)+ /i
abrir   (abre) (me)+ /i
cerrar   (cierra) (me)+ /i
cuerpo  
engine  (google | bing | wikipedia) /i
carpeta (carpeta) /i
archivo (archivo) /i
programa (spotify | calculadora | )

%%
{buscar}    { yylval.valString = strdup(yytext); return BUSCAR; }
{crear}     { yylval.valString = strdup(yytext); return CREAR; }
{abrir}     { yylval.valString = strdup(yytext); return ABRIR; }
{engine}    { yylval.valString = strdup(yytext); return ENGINE; } 
{carpeta}   { yylval.valString = strdup(yytext); return CARPETA; }
{archivo}   { yylval.valString = strdup(yytext); return ARCHIVO; }
{cuerpo}    { yylval.valString = strdup(yytext); return CUERPO; }
{programa}  { yylval.valString = strdup(yytext); return PROGRAMA; }
{space}     {;}
{tab}       {;}
{eol}       {;}
%%