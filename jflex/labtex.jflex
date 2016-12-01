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
	int prior_state = 0;

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

ValidLaTeX = [^&%$#_{}~\^\\\r\n\t\f \"]

SquareString = "\[" [^\]]* "\]"

LabletSheet     = "\{labletsheet\}"
LabletVideoPage = "\{labletvideopage\}"
MotionPage      = "\\labletmotionpage"
CalcYSpeed      = "\\labletcalcyspeed"
AnySheet        = {LabletSheet} | {LabletVideoPage}
BeginAnySheet   = ( "\\begin" {SquareString}? {AnySheet} ) | {MotionPage} | {CalcYSpeed}
EndAnySheet     = "\\end" {AnySheet}

Key   = {WhiteSpace}* [a-zA-Z_] [a-zA-Z_0-9]* {WhiteSpace}* [=]
Value = {WhiteSpace}* [a-zA-Z_] [a-zA-Z_0-9]* {WhiteSpace}* [,]?

%state TITLE
%state TITLED
%state SHEET
%state LATEXSTRING
%state OPTIONS

%%

{Comment}           { /* always ignore */ }

<YYINITIAL> {
    /* scan to find the title */
    "\\title"       { yypushback(yylength()); yybegin(TITLE); }
    {BeginAnySheet} { throw new Error("Missing title"); }
    [^]             { /* ignore */ }
}

<TITLE> {
    /* parse title */
    "\\title"       { return symbol(LabParserSym.KW_TITLE); }
    [\{]            { return symbol(LabParserSym.LCURLY); }
    [\}]            { yybegin(TITLED);
                      return symbol(LabParserSym.RCURLY); }
    {SquareString}  { /* ignore */ }
    [^]             { yybegin(LATEXSTRING);
                      string.setLength(0);
                      prior_state = TITLE;
                      yypushback(1); }
}

<TITLED> {
    /* scan to find a sheet */
    {BeginAnySheet} { yypushback(yylength()); yybegin(SHEET); }
    [^]             { /* ignore */ }

    /*  String s = yytext().trim();
        s = s.substring(7, s.length()-18);
        System.out.println("SQUARE "+s);
        return symbol(LabParserSym.VIDEO_OP, s);
    } */
}

<SHEET> {
    /* parse sheet */
    {EndAnySheet}       { yybegin(TITLED); }
    "\\begin"           { return symbol(LabParserSym.KW_BEGIN); }
    "\\end"             { return symbol(LabParserSym.KW_END); }
    "labletsheet"       { return symbol(LabParserSym.KW_LABLETSHEET); }
    "labletvideopage"   { return symbol(LabParserSym.KW_LABLETVIDEOPAGE); }
    {MotionPage}        { return symbol(LabParserSym.KW_LABLETMOTIONPAGE); }
    {CalcYSpeed}        { return symbol(LabParserSym.KW_LABLETCALCYSPEED); }
    "\\lablettext"      { return symbol(LabParserSym.KW_LABLETTEXT); }
    "\\labletheader"    { return symbol(LabParserSym.KW_LABLETHEADER); }
    "\\labletcheck"     { return symbol(LabParserSym.KW_LABLETCHECK); }
    "\\labletvideo"     { return symbol(LabParserSym.KW_LABLETVIDEO); }
    "\\horizontal"      { return symbol(LabParserSym.KW_HORIZONTAL); }
    "\\horizontaltwo"   { return symbol(LabParserSym.KW_HORIZONTALTWO); }
    "\\horizontalthree" { return symbol(LabParserSym.KW_HORIZONTALTHREE); }
    [\\]                { return symbol(LabParserSym.BACKSLASH); }
    [\{]                { return symbol(LabParserSym.LCURLY); }
    [\}]                { return symbol(LabParserSym.RCURLY); }
    [\[]                { yybegin(OPTIONS);
                          /* return symbol(LabParserSym.LEFTSQUARE); */ }
    {WhiteSpace}+       { /* gobble */ }
    [^]                 { yybegin(LATEXSTRING);
                          string.setLength(0);
                          prior_state = SHEET;
                          yypushback(1); }
}

/*
 * For now, we just look for valid characters
 * eventually, we will want to support escape commands
 */
<LATEXSTRING> {
    {WhiteSpace}+   { string.append(' '); }
    [\"]            { string.append("\\\""); }
    {ValidLaTeX}+   { string.append(yytext()); }
    [^]             { yypushback(1);
                      yybegin(prior_state);
                      return symbol(LabParserSym.LATEXSTRING, string.toString()); }
}

/* not used yet */
<OPTIONS> {
    [\]]    { yybegin(SHEET); /* return symbol(LabParserSym.RIGHTSQUARE); */ }
    {Key}   { /* return symbol(LabParserSym.LATEXSTRING, yytext().substring(0,yylength()-1)); */ }
    {Value} { /*
                if (yytext().endsWith(",") {
                    return symbol(LabParserSym.LATEXSTRING, yytext().substring(0,yylength()-1));
                } else {
                    return symbol(LabParserSym.LATEXSTRING, yytext());
                }
            */ }
    {WhiteSpace}+ { /* gobble */ }
}

<<EOF>> { return symbol(LabParserSym.EOF); }
