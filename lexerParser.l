%{
#include <stdlib.h>
#include "lexerParser.tab.h"
%}

%option yylineno

/* BUSCAR CREAR ABRIR CUERPO ENGINE CARPETA ARCHIVO */

eol         \n
tab         \t
space       " "
buscar      (("B"|"b")"usca"|("E"|"e")"ncuentra")"me"?|(("B"|"b")"úscame"|("E"|"e")"ncuéntrame")
crear       "crea""me"?|"créame"
abrir       "abre""me"?|"ábreme"
engine      ((("G"|"g")"oogle")|(("B"|"b")"ing")|(("D"|"d")"uckduckgo"))|(("E"|"e")"n "(("G"|"g")"oogle")|(("E"|"e")"n "("B"|"b")"ing")|(("E"|"e")"n "("D"|"d")"uckduckgo"))
carpeta     "una "?"carpeta"
archivo     "un "?"archivo"
programa    "nano"|"libreoffice"|"firefox"
cuerpo      [^ \t\n]+(^buscar|crear|abrir|cerra|engine|carpeta|archivo|eol)*

%%
{buscar}    { /* printf("-buscar: %s\n", yytext); */ yylval.valString = strdup(yytext); return BUSCAR; }
{crear}     { /* printf("-crear: %s\n", yytext); */ yylval.valString = strdup(yytext); return CREAR; }
{abrir}     { /* printf("-abrir: %s\n", yytext); */ yylval.valString = strdup(yytext); return ABRIR; }
{engine}    { /* printf("-engine: %s\n", yytext); */ yylval.valString = strdup(yytext); return ENGINE; } 
{carpeta}   { /* printf("-carpeta: %s\n", yytext); */ yylval.valString = strdup(yytext); return CARPETA; }
{archivo}   { /* printf("-archivo: %s\n", yytext); */ yylval.valString = strdup(yytext); return ARCHIVO; }
{programa}  { /* printf("-programa: %s\n", yytext); */ yylval.valString = strdup(yytext); return PROGRAMA; }
{cuerpo}    { /* printf("-cuerpo: %s\n", yytext); */ yylval.valString = strdup(yytext); return CUERPO; }
{space}     {;}
{tab}       {;}
{eol}       {;}
%%
