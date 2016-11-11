/* JFlex file: Labtex language lexer specification */
/* http://www.jflex.de/manual.html#CUPWork */

package nz.ac.auckland.labtex.generated;
import java_cup.runtime.*;

/**
 * A lexer class for the custom Labtex language used by Lablet
 */
%%

%class LabLexer
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
Comment = "%" [^\r\n]* ~{LineTerminator}
Line = [^\r\n]* ~{LineTerminator}

SquareString = "\[" [^\]]* "\]"
CurlyString  = "\{" [^\}]* "\}"

BeforeTitle = {WhiteSpace}* "\\title"
BeforeSheet = {WhiteSpace}* "\\begin" {SquareString}? "\{labletsheet\}"

%state TITLE
%state TITLED
%state SHEET
%state YYINITIAL2

%%

/* keywords */
<YYINITIAL> {
    /* [^] { System.out.println("ERROR - Found: "+yytext()); } */
    {Line} { /* System.out.println("LINE: "+yytext()); */ }
    {BeforeTitle} {
        System.out.println("Changing from YYINITIAL to TITLE");
        yybegin(TITLE);
        return symbol(LabSymbols.TITLE);
    }
    {BeforeSheet} {
        System.out.println("BEGIN");
        System.out.println("Changing from YYINITIAL to SHEET");
        yybegin(SHEET);
        return symbol(LabSymbols.BEGIN);
    }
}

<TITLE> {
    [\{] {
        string.setLength(0);
    }
    [\}] {
        System.out.println("Changing from TITLE to TITLED");
        yybegin(TITLED);
        return symbol(LabSymbols.STRING, string.toString());
    }
    [^\{\}]+ {
        System.out.println(yytext());
        string.append(yytext());
    }
}

<TITLED> {
    {Line} { /* System.out.println("LINE: "+yytext()); */ }
    {BeforeSheet} {
        System.out.println("BEGIN");
        System.out.println("Changing from TITLED to SHEET");
        yybegin(SHEET);
        return symbol(LabSymbols.BEGIN);
    }
}

<SHEET> {
    [^] {
        System.out.print(yytext());
    }
    "\\end"	{SquareString}? "\{lablet\}" {
        System.out.println("END");
        System.out.println("Changing from SHEET to TITLED");
        yybegin(TITLED);
        return symbol(LabSymbols.END);
    }
}

<<EOF>> { return symbol(LabSymbols.EOF); }
