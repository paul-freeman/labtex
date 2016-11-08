/* JFlex file: Labtex language lexer specification */
/* http://www.jflex.de/manual.html#CUPWork */

package com.company.generated;
import java_cup.runtime.*;

/**
 * A lexer class for the custom Labtex language used by Lablet
 */
%%

%class Scanner
%unicode
%public
%cup
%line
%column

%{
	StringBuffer string = new StringBuffer();

	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
%}

LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]

Comment = "%" ~{LineTerminator}

SquareString = "\[" [^\]]* "\]"
CurlyString  = "\{" [^\}]* "\}"


LabletText = "\\lablettext" {CurlyString}

%%

/* keywords */
<YYINITIAL> "\\title" 		{ System.out.println("TITLE"); return symbol(sym.TITLE); }
<YYINITIAL> "\\begin"		{ System.out.println("BEGIN"); return symbol(sym.BEGIN); }
<YYINITIAL> "\\end"			{ System.out.println("END"); return symbol(sym.END); }

/* ignore */
<YYINITIAL> {
	{Comment}				{ /* ignore */ }
	{WhiteSpace}            { /* ignore */ }
}

[^]	{ throw new Error("illegal character <"+yytext()+">"); }
