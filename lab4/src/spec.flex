// import sekcija
import java_cup.runtime.*;
%%

// sekcija opcija i deklaracija
%class MPLexer

%cup

%line
%column

%eofval{
	return new Symbol( sym.EOF );
%eofval}

%{
   public int getLine()
   {
      return yyline;
   }
%}

//stanja
%xstate KOMENTAR
//makroi
slovo = [a-zA-Z]
cifra = [0-9A-Fa-f]

%%

// pravila
\(\* { yybegin( KOMENTAR ); }
<KOMENTAR>~"*)" { yybegin( YYINITIAL ); }

[\t\n\r ] { ; }

//operatori
\+ { return new Symbol( sym.PLUS ); }
\- { return new Symbol( sym.MINUS ); }


[\t\n\r ] { ; }
\[ { return new Symbol ( sym.OPENSQUARE ); }
\] { return new Symbol( sym.CLOSEDSQUARE ); }


//separatori
; { return new Symbol( sym.SEMICOLON ); }
: { return new Symbol( sym.COLON ); }
, { return new Symbol( sym.COMMA ); }
:= { return new Symbol( sym.ASSIGN ); }

//kljucne reci

"int" { return new Symbol(sym.INT ); }
"bool" { return new Symbol(sym.BOOL ); }
"float" { return new Symbol(sym.FLOAT ); }
"main" { return new Symbol(sym.MAIN ); }
"exit" { return new Symbol(sym.EXIT ); }
"for" { return new Symbol(sym.FOR ); }
"in" { return new Symbol(sym.IN ); }
"apply" { return new Symbol(sym.APPLY ); }


//identifikatori
{slovo}({slovo}|{cifra})* { return new Symbol( sym.ID, yytext()); }
//konstante


(0|0x)?([0-9]+) { return new Symbol( sym.INTCONST, new Integer( yytext() ) ); }
(\true|\false) { return new Symbol( sym.BOOLCONST, new Boolean( yytext() ) ); }
0.(0|[0-9]+)(E\+(0|[0-9]+)|E\-(0|[0-9]+)) { return new Symbol( sym.FLOATCONST, new Float( yytext() ) ); }


. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }
