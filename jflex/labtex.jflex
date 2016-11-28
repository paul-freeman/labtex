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

BeforeTitle     = {WhiteSpace}* "\\title"
BeforeNormal    = {WhiteSpace}* "\\begin" {SquareString}? "\{labletsheet\}"
BeforeVideo     = {WhiteSpace}* "\\begin\{labletvideopage\}"
BeforeVideoOp   = {WhiteSpace}* "\\begin" {SquareString} "\{labletvideopage\}"
EndSheet        = {WhiteSpace}* "\\end\{labletsheet\}"
LabletText      = {WhiteSpace}* "\\lablettext" {SquareString}?
LabletHeader    = {WhiteSpace}* "\\labletheader" {SquareString}?
LabletCheck     = {WhiteSpace}* "\\labletcheck" {SquareString}?
LabletVideo     = {WhiteSpace}* "\\labletvideo" {SquareString}?
HorizontalTwo   = {WhiteSpace}* "\\horizontaltwo"
HorizontalThree = {WhiteSpace}* "\\horizontalthree"

BeforeSheet   = {BeforeNormal} | {BeforeVideo}

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
    {BeforeVideoOp} {
        yybegin(SHEET);
        //System.out.println("BEGIN");
        String s = yytext().substring(7, yytext().length()-18);
        System.out.println("SQUARE "+s);
        return symbol(LabParserSym.VIDEO_OP, s);
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
        System.out.print("\"(TeX) "+yytext()+"\"\n}\n\n\n");
    }
}

<TITLED> {
    {Line} { /* System.out.println("LINE: "+yytext()); */ }
    {BeforeSheet} {
        yybegin(SHEET);
        //System.out.println("BEGIN");
        return symbol(LabParserSym.BEGIN);
    }
    {BeforeVideoOp} {
        yybegin(SHEET);
        //System.out.println("BEGIN");
        String s = yytext().trim();
        s = s.substring(7, s.length()-18);
        System.out.println("SQUARE "+s);
        return symbol(LabParserSym.VIDEO_OP, s);
    }
}

<SHEET> {
    "{" {
        // System.out.println("LCURLY");
        return symbol(LabParserSym.LCURLY);
    }
    "}" {WhiteSpace}* {
        // System.out.println("RCURLY");
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
    {LabletCheck} {
        return symbol(LabParserSym.LABLETCHECK);
    }
    {LabletVideo} {
        // System.out.println("VIDEO found");
        return symbol(LabParserSym.LABLETVIDEO);
    }
    {HorizontalTwo} {
        return symbol(LabParserSym.HORIZONTALTWO);
    }
    {HorizontalThree} {
        return symbol(LabParserSym.HORIZONTALTHREE);
    }
    {EndSheet} {
        yybegin(TITLED);
        // System.out.println("END");
        return symbol(LabParserSym.END);
    }
    {SquareString} {
        return symbol(LabParserSym.SQUARESTRING, yytext());
    }
    [^] {
        System.out.println("Found an unknown thing: "+yytext());
    }
}

<STRING> {
    [\}] {
        yybegin(SHEET);
        yypushback(1);
        // System.out.println("STRING "+string.toString());
        return symbol(LabParserSym.STRING, string.toString());
    }
    {WhiteSpace}+ {
        // System.out.println("Found a whitespace thing: "+yytext());
        string.append(' ');
    }
    [\"] { /* need to escape quotes in Lua strings */
        string.append('\\');
        string.append('\"');
    }
    [^\"\} \n\r\t\f] {
        // System.out.println("Found a non-string thing: "+yytext());
        string.append(yytext());
    }
    [^] {
        System.out.println("Found an unknown thing: "+yytext());
    }
}

<<EOF>> { return symbol(LabParserSym.EOF); }
