%{
#include <stdlib.h>
#include "lexerParser.tab.h"
%}

%option yylineno

/* BUSCAR CREAR ABRIR CUERPO ENGINE CARPETA ARCHIVO */

eol         \n
tab         \t
space       " "
buscar      ("busca"|"encuentra")"me"?
crear       "crea""me"+
abrir       "abre""me"+
cerrar      "cierra""me"+
engine      "google"|"bing"|"duckduckgo"|"en google"|"en bing"|"en duckduckgo"
carpeta     "carpeta"
archivo     "archivo"
programa    "spotify"|"calculadora"
cuerpo      [^ \t\n]+(^buscar|crear|abrir|cerra|engine|carpeta|archivo|eol)*

%%
{buscar}    { printf("-buscar: %s\n", yytext); yylval.valString = strdup(yytext); return BUSCAR; }
{crear}     { printf("-crear: %s\n", yytext); yylval.valString = strdup(yytext); return CREAR; }
{abrir}     { printf("-abrir: %s\n", yytext); yylval.valString = strdup(yytext); return ABRIR; }
{engine}    { printf("-engine: %s\n", yytext); yylval.valString = strdup(yytext); return ENGINE; } 
{carpeta}   { printf("-carpeta: %s\n", yytext); yylval.valString = strdup(yytext); return CARPETA; }
{archivo}   { printf("-archivo: %s\n", yytext); yylval.valString = strdup(yytext); return ARCHIVO; }
{programa}  { printf("-programa: %s\n", yytext); yylval.valString = strdup(yytext); return PROGRAMA; }
{cuerpo}    { printf("-cuerpo: %s\n", yytext); yylval.valString = strdup(yytext); return CUERPO; }
{space}     {;}
{tab}       {;}
{eol}       {;}
%%
