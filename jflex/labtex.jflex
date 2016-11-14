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

BeforeTitle   = {WhiteSpace}* "\\title"
BeforeSheet   = {WhiteSpace}* "\\begin" {SquareString}? "\{labletsheet\}"
LabletText    = {WhiteSpace}* "\\lablettext" {SquareString}?
LabletHeader  = {WhiteSpace}* "\\labletheader" {SquareString}?
HorizontalTwo = {WhiteSpace}* "\\horizontaltwo"

%state TITLE
%state TITLED
%state SHEET
%state YYINITIAL2
%state STRING

%%

/* keywords */
<YYINITIAL> {
    /* [^] { System.out.println("ERROR - Found: "+yytext()); } */
    {Line} { /* System.out.println("LINE: "+yytext()); */ }
    {BeforeTitle} {
        //System.out.println("TITLE");
        yybegin(TITLE);
        return symbol(LabParserSym.TITLE);
    }
    {BeforeSheet} {
        yybegin(SHEET);
        //System.out.println("BEGIN");
        return symbol(LabParserSym.BEGIN);
    }
}

<TITLE> {
    [\{] {
        string.setLength(0);
    }
    [\}] {
        yybegin(TITLED);
    }
    [^\{\}]+ {
        System.out.print("Lablet = {\n    interface = 1.0,\n    title = ");
        System.out.print("\""+yytext()+"\"\n}\n\n\n");
    }
}

<TITLED> {
    {Line} { /* System.out.println("LINE: "+yytext()); */ }
    {BeforeSheet} {
        yybegin(SHEET);
        //System.out.println("BEGIN");
        return symbol(LabParserSym.BEGIN);
    }
}

<SHEET> {
    "{" {
        //System.out.println("LCURLY");
        return symbol(LabParserSym.LCURLY);
    }
    "}" {WhiteSpace}* {
        //System.out.println("RCURLY");
        return symbol(LabParserSym.RCURLY);
    }
    [a-zA-Z0-9] {
        string.setLength(0);
        yybegin(STRING);
        yypushback(1);
    }
    [^\{\}] {
        //System.out.print(yytext());
    }
    {LabletText} {
        return symbol(LabParserSym.LABLETTEXT);
    }
    {LabletHeader} {
        return symbol(LabParserSym.LABLETHEADER);
    }
    {HorizontalTwo} {
        return symbol(LabParserSym.HORIZONTALTWO);
    }
    "\\end"	{SquareString}? "\{lablet\}" {
        yybegin(TITLED);
        //System.out.println("END");
        return symbol(LabParserSym.END);
    }
    [^] {
        System.out.println("Found an unknown thing: "+yytext());
    }
}

<STRING> {
    [\}] {
        yybegin(SHEET);
        yypushback(1);
        //System.out.println("STRING "+string.toString());
        return symbol(LabParserSym.STRING, string.toString());
    }
    {WhiteSpace}+ {
        // System.out.println("Found a whitespace thing: "+yytext());
        string.append(' ');
    }
    [^\} \n\r\t\f] {
        // System.out.println("Found a non-string thing: "+yytext());
        string.append(yytext());
    }
    [^] {
        System.out.println("Found an unknown thing: "+yytext());
    }
}

<<EOF>> { return symbol(LabParserSym.EOF); }
