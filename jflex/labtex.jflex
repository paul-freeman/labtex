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

LineTerminator      = \r|\n|\r\n
NonLineTerminator   = [ \t\f]
WhiteSpace          = {LineTerminator} | {NonLineTerminator}
SquishSpace         = {LineTerminator}
                      | ( {NonLineTerminator}+ {LineTerminator}? {NonLineTerminator}* )
                      | ( {NonLineTerminator}* {LineTerminator}? {NonLineTerminator}+ )
BlankLine           = {LineTerminator} {WhiteSpace}* {LineTerminator}

/* Labtex commands must be LaTeX comments with a specific prefix */
Prefix = "%" [ \t]* ">>" [ \t]* "lablet:"

Special    = [&%$#_{}~\^\\]
NonSpecial = [^&%$#_{}~\^\\]
Backslash  = \\

%state COMMAND
%state LATEXSTRING
%state COMMENT

%%

<YYINITIAL> {
    /* gobble whitespace */
    {WhiteSpace}+           { /* ignore */ }

    /* scan to find commands */
    {Prefix}                { yybegin(COMMAND); }

    /* check for LaTeX keywords we may be interested in */
    "title"                 { System.out.println("(KW_TITLE)"+yytext()); return symbol(LabParserSym.KW_TITLE); }

    /* non-special characters start a LaTeX string */
    {NonSpecial}            { string.setLength(0); string.append(yytext()); yybegin(LATEXSTRING); }

    /* special characters generate tokens */
    "&"                     { System.out.println("(AMPERSAND)"+yytext()); return symbol(LabParserSym.AMPERSAND); }
    "\$"                    { System.out.println("(DOLLARSIGN)"+yytext()); return symbol(LabParserSym.DOLLARSIGN); }
    "#"                     { System.out.println("(HASHMARK)"+yytext()); return symbol(LabParserSym.HASHMARK); }
    "_"                     { System.out.println("(UNDERSCORE)"+yytext()); return symbol(LabParserSym.UNDERSCORE); }
    "\{"                    { System.out.println("(LEFTCURLYBRACE)"+yytext()); return symbol(LabParserSym.LEFTCURLYBRACE); }
    "\}"                    { System.out.println("(RIGHTCURLYBRACE)"+yytext()); return symbol(LabParserSym.RIGHTCURLYBRACE); }
    "~"                     { System.out.println("(TILDE)"+yytext()); return symbol(LabParserSym.TILDE); }
    "\^"                    { System.out.println("(CARROT)"+yytext()); return symbol(LabParserSym.CARROT); }
    {Backslash}             { System.out.println("(BACKSLASH)"+yytext()); return symbol(LabParserSym.BACKSLASH); }

    "%"                     { yypushback(1); yybegin(COMMENT); }
    [^]                     { System.out.println("(INVALID)"+yytext()); /* ignore */ }
}

<COMMAND> {
    "title"                 { yybegin(YYINITIAL); System.out.println("(CMD_TITLE)title"); return symbol(LabParserSym.CMD_TITLE); }
    "sheet"                 { yybegin(YYINITIAL); System.out.println("(CMD_SHEET)sheet"); return symbol(LabParserSym.CMD_SHEET); }
    "header"                { yybegin(YYINITIAL); System.out.println("(CMD_HEADER)header"); return symbol(LabParserSym.CMD_HEADER); }
    "text"                  { yybegin(YYINITIAL); System.out.println("(CMD_TEXT)text"); return symbol(LabParserSym.CMD_TEXT); }
    [^]                     { yypushback(1); yybegin(YYINITIAL); System.out.println("(INVALID)"+yytext()); }
}

<LATEXSTRING> {
    /* get the entire LaTeX string */

    /* squish whitespace in standard LaTeX fashion */
    {SquishSpace}           { string.append(" "); }

    /* handle LaTeX special characters */
    {Backslash} "&"         { string.append("&"); }
    {Backslash} "%"         { string.append("%"); }
    {Backslash} "\$"        { string.append("$"); }
    {Backslash} "#"         { string.append("#"); }
    {Backslash} "_"         { string.append("_"); }
    {Backslash} "\{"        { string.append("{"); }
    {Backslash} "\}"        { string.append("}"); }
    {Backslash} "~"         { string.append("~"); }
    {Backslash} "\^"        { string.append("^"); }
    {Backslash} {Backslash} { string.append("\\\\"); }

    /* handle Lua special characters */
    "\""                    { string.append("\\\""); }
    "'"                     { string.append("\\\'"); }
    "\["                    { string.append("\\["); }
    "\]"                    { string.append("\\]"); }

    /* now check for invalid string characters and blank lines */
    \$                      { /* TODO: implement math mode */ }
    {Special}               { yypushback(1);
                              yybegin(YYINITIAL);
                              System.out.println("(LATEXSTRING)"+string.toString().replaceAll("(\\r|\\n)", ""));
                              return symbol(LabParserSym.LATEXSTRING, string.toString()); }
    {BlankLine}             { yybegin(YYINITIAL);
                              System.out.println("(LATEXSTRING)"+string.toString().replaceAll("(\\r|\\n)", ""));
                              return symbol(LabParserSym.LATEXSTRING, string.toString()); }

    /* anything else just gets added onto the string */
    [^]                     { string.append(yytext()); }
}

<COMMENT> {
    %.*                      { yybegin(YYINITIAL); }
}

<<EOF>> { return symbol(LabParserSym.EOF); }
