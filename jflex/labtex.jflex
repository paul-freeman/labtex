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
	private String escapeForLua(String str) {
	    return str.replace("\"", "\\\"")
	              .replace("\'", "\\\'")
	              .replace("[", "\\[")
	              .replace("]", "\\]")
	              .replace("``", "\\\"");
	}
%}

LineTerminator      = \r|\n|\r\n
NonLineTerminator   = [ \t\f]
WhiteSpace          = {LineTerminator}
                      | {NonLineTerminator}+ {LineTerminator}? {NonLineTerminator}*
                      | {NonLineTerminator}* {LineTerminator}? {NonLineTerminator}+
BlankLine           = {NonLineTerminator}* {LineTerminator}
                      {NonLineTerminator}* {LineTerminator}
                      ({NonLineTerminator}|{LineTerminator})*

/* Labtex commands must be LaTeX comments with a specific prefix */
Prefix          = "%" [ \t]* ">>" [ \t]* "lablet:"
LabletTitle     = "%" [ \t]* ">>" [ \t]* "lablet:title"
LabletSheet     = "%" [ \t]* ">>" [ \t]* "lablet:sheet"

/* Special    = [&%$#_{}~\^\\] */
NonSpecial = [^&%$#_{}~\^\\ \t\f\r\n] /* no special characters and no whitespace */
Backslash  = \\

/* strip equations and figures */
Equation = ("\\begin\{equation\}" ~"\\end\{equation\}") | ("\\[" ~"\\]")
Figure   = "\\begin\{figure\}" ~"\\end\{figure\}"

%state TITLE, TITLED, SHEET, ELEMENT, ELEMENTS
%state TITLE_COMMENT, SHEET_COMMENT, ELEMENT_COMMENT

%%

/* scan to find commands */
{Prefix} "title"            { yybegin(TITLE); System.out.println("(CMD_TITLE)title"); return symbol(LabParserSym.CMD_TITLE); }
{Prefix} "sheet"            { yybegin(SHEET); System.out.println("(CMD_SHEET)sheet"); return symbol(LabParserSym.CMD_SHEET); }
{Prefix} "header"           { yybegin(ELEMENT); System.out.println("(CMD_HEADER)header"); return symbol(LabParserSym.CMD_HEADER); }
{Prefix} "text"             { yybegin(ELEMENT); System.out.println("(CMD_TEXT)text"); return symbol(LabParserSym.CMD_TEXT); }
{Prefix} "check"            { yybegin(ELEMENT); System.out.println("(CMD_CHECK)check"); return symbol(LabParserSym.CMD_CHECK); }

/* ignore advanced LaTeX stuff */
{Equation}                  { System.out.println("(EQUATION)(equation omitted)"); return symbol(LabParserSym.LATEXSTRING, "(equation omitted)"); }
{Figure}                    { System.out.println("(FIGURE)(figure omitted)"); return symbol(LabParserSym.LATEXSTRING, "(figure omitted)"); }

<YYINITIAL> {
    [^]                     { /* System.out.println("(IGNORE)"+yytext()); */ }
}

<TITLE, SHEET, ELEMENT> {
    /* whitespace is compressed to one token */
    {WhiteSpace}            { System.out.println("(WHITESPACE)"); return symbol(LabParserSym.WHITESPACE); }

    /* non-special characters start a LaTeX string */
    {NonSpecial}+           { System.out.println("(LATEXSTRING)"+yytext().replaceAll("(\\r|\\n)", ""));
                              return symbol(LabParserSym.LATEXSTRING, escapeForLua(yytext())); }

    /* special characters generate tokens */
    "&"                     { System.out.println("(AMPERSAND)"+yytext()); return symbol(LabParserSym.AMPERSAND); }
    {Backslash} "%"         { System.out.println("(PERCENT)"+yytext()); return symbol(LabParserSym.PERCENT); }
    "\$"                    { System.out.println("(DOLLARSIGN)"+yytext()); return symbol(LabParserSym.DOLLARSIGN); }
    "#"                     { System.out.println("(HASHMARK)"+yytext()); return symbol(LabParserSym.HASHMARK); }
    "_"                     { System.out.println("(UNDERSCORE)"+yytext()); return symbol(LabParserSym.UNDERSCORE); }
    "\{"                    { System.out.println("(LEFTCURLYBRACE)"+yytext()); return symbol(LabParserSym.LEFTCURLYBRACE); }
    "\}"                    { System.out.println("(RIGHTCURLYBRACE)"+yytext()); return symbol(LabParserSym.RIGHTCURLYBRACE); }
    "~"                     { System.out.println("(TILDE)"+yytext()); return symbol(LabParserSym.TILDE); }
    "\^"                    { System.out.println("(CARROT)"+yytext()); return symbol(LabParserSym.CARROT); }
    {Backslash}             { System.out.println("(BACKSLASH)"+yytext()); return symbol(LabParserSym.BACKSLASH); }
    {Backslash} {Backslash} { System.out.println("(ESCAPED_BACKSLASH)"+yytext()); return symbol(LabParserSym.ESCAPED_BACKSLASH); }
}

<TITLE> {
    /* title must be located before the next blank line */
    {BlankLine}             { yybegin(TITLED); System.out.println("(BLANKLINE)"); return symbol(LabParserSym.BLANKLINE); }

    /* comments are ignored */
    "%"                     { yypushback(1); yybegin(TITLE_COMMENT); }
}

<TITLED> {
    /* scan for sheets */
    {LabletSheet}           { yybegin(SHEET); System.out.println("(CMD_SHEET)sheet"); return symbol(LabParserSym.CMD_SHEET); }
    [^]                     { /* ignore */ }
}

<SHEET> {
    /* sheet title must be located before the next blank line */
    {BlankLine}             { yybegin(ELEMENTS); System.out.println("(BLANKLINE)"); }

    /* comments are ignored */
    "%"                     { yypushback(1); yybegin(SHEET_COMMENT); }
}

<ELEMENTS> {
    /* scan for Lablet elements */
    [^]                     { /* ignore */ }
}

<ELEMENT> {
    /* LaTeX commands start with a backslash */
    {Backslash} "href"      { System.out.println("(LATEX_HREF)"+yytext()); return symbol(LabParserSym.LATEX_HREF, yytext()); }
    {Backslash} [a-zA-Z_]+  { System.out.println("(LATEX_CMD)"+yytext()); return symbol(LabParserSym.LATEX_CMD, yytext()); }
    {Backslash} "["         { System.out.println("(LATEX_CMD)"+yytext()); return symbol(LabParserSym.LATEX_CMD, yytext()); }
    {Backslash} "]"         { System.out.println("(LATEX_CMD)"+yytext()); return symbol(LabParserSym.LATEX_CMD, yytext()); }
    {Backslash} ","         { System.out.println("(LATEX_CMD)"+yytext()); return symbol(LabParserSym.LATEX_CMD, yytext()); }

    {BlankLine}             { yybegin(TITLED); System.out.println("(BLANKLINE)"); return symbol(LabParserSym.BLANKLINE); }

    "%"                     { yypushback(1); yybegin(ELEMENT_COMMENT); }
}

<TITLE_COMMENT> {
    %.* {WhiteSpace}        { yybegin(TITLE); }
}

<SHEET_COMMENT> {
    %.* {WhiteSpace}        { yybegin(SHEET); }
}

<ELEMENT_COMMENT> {
    %.* {WhiteSpace}        { yybegin(ELEMENT); }
}

<<EOF>> { return symbol(LabParserSym.EOF); }
