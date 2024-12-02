// import sekcija
import java_cup.runtime.*;

%%

// sekcija opcija i deklaracija
%class GenerisanaKlasa

%cup

%line
%column

//konstruktor
%eofval{
return new Symbol ( sym.EOF );
%eofval}

// dodatne članice klase
%{
    public int getLine()
    {
        return yyline;
    }
%}

//stanja
%xstate KOMENTAR
//makroi

%%

// pravila
"//" { yybegin( KOMENTAR ); }
<KOMENTAR>~"\n" { yybegin( YYINITIAL ); }

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
([a-zA-Z])(([a-zA-Z]|[0-9])+) { return new Symbol(sym.ID, yytext() ); }

//konstante
(0|0x)?([0-9]+) { return new Symbol( sym.CONST ); }
(\true|\false) { return new Symbol( sym.CONST ); }
0.(0|[0-9]+)(E\+(0|[0-9]+)|E\-(0|[0-9]+)) { return new Symbol( sym.CONST ); }

//operatori
\+ { return new Symbol( sym.PLUS ); }
\- { return new Symbol( sym.MINUS); }

//obrada gresaka
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }


