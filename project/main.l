
%{
	#include<stdio.h>
	#include "main.tab.h"
	#include<stdlib.h>
	extern int yylval;
%}

alpha  [A-Za-z]+ 
single_line_comment [ ]*[/][/].*
multiple_line_comment [ ]*[/][a][/][a-zA-Z0-9!@#*(){}_+-,.:\|?><\n\t ]*[/][a][/]
header	"import"[ ]*+[^\n]+[.h][ ]*
%%

{single_line_comment} {
	printf("single line comment\n");

}
{multiple_line_comment} {
	printf("multiple_line_comment\n");
}

{header}  	{}

[0-9]+	{ yylval = atoi(yytext); return NUM; }

[a-z]	{ yylval = *yytext - 'a'; return VAR; }

"if"	{ return IF; }

"else"	{ return ELSE; }

[<>,(){}:] 	{ yylval = yytext[0]; return *yytext; }

"#"	{ return ';'	;}
"/"	{ return '/'	;}
"-"	{ return '-'	;}
"*"	{ return '*'	;}
"+"	{ return '+'	;}
"eq"	{ return '='	;}

"main"  	{ return (VOIDMAIN)  ;}

"print"  	{ return PRINT  ;}

"integer"    	{ return (INT)	;}

"float"  	{ return (FLOAT)	;}

"double"  	{ return (DOUBLE)	;}

"character"   	{ return (CHAR)	;}

"case"		{ return CASE  	;}

"default"       {return DEFAULT ;}

"switch"	{ return SWITCH ;}

"loop"       	{return LOOP	;}

"sin_func"			 {return SINE;}

"cos_func"            {return COSINE;}

"tan_func"            {return TANGENT;}

"log_func"			 {return LOG;}

"log10_func" 		   {return LOG10;}

"function "{alpha}	{ return FUNCTION; }


[ \t\n]*	;

.		{	yyerror("Unknown Character.\n"); }
%%

int main(){
	yyin = freopen("in.txt","r",stdin);
	yyout = freopen("out.txt","w",stdout);
	yyparse();
}

