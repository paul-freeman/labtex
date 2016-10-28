/* JFlex file: Labtex language lexer specification */
import java.io.*;

/**
 * A lexer class for the custom Labtex language used by Lablet
 */
%%

%public
%class Lablex
%unicode

%int

%{
	public static void main(String argv[]) {
		if (argv.length == 0) {
			System.out.println("Usage : java Lablex <file>");
		}
		else {
			sheetCount = 0;
			try {
				int x;
				FileReader reader = new FileReader(argv[0]);
				Lablex scanner = new Lablex(reader);

				while (!scanner.zzAtEOF) {
					x = scanner.yylex();
					if (x == -1) break;
					System.out.print(scanner.yytext());
				}
				reader.close();
				System.out.print("\n");
			}
			catch (FileNotFoundException e) {
				System.out.println("File not found");
			}	
			catch (IOException e) {
				System.out.println("Expected IO exception");
			}
		}
	}

	public void printTitle(String str) {
		str = str.substring(7, str.length()-1);

		System.out.println("Lablet = {");
		System.out.println(  "\tinterface = 1.0,");
		System.out.println(  "\ttitle = '" + str + "'");
		System.out.println("}");
		System.out.println();
		System.out.println();
		System.out.println("function Lablet.buildActivity(builder)");
	}

	public static int sheetCount;

	public void printSheetStart(String str) {
		str = str.substring(1, str.length()-1);
		sheetCount++;
		String id = "sheet" + sheetCount;

		System.out.println("\tlocal " + id + " = builder:create(\"Sheet\")");
		System.out.println("\tbuilder:add(" + id + ")");
		System.out.println("\t" + id + ":setTitle(\"" + str + "\")");
		System.out.println();
	}
%}

LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]

Comment = "%" ~{LineTerminator}

SquareString = "\[" [^\]]* "\]"
CurlyString  = "\{" [^\}]* "\}"

Title = "\\title\{" [^\}]* "\}"

LabletBegin = "\\begin" {SquareString}? "\{labletsheet\}" {SquareString}?
LabletEnd   = "\\end\{labletsheet\}"

%state TITLED
%state SHEETTITLE
%state SHEET

%%

<YYINITIAL> {
	{Title}			{
					printTitle(yytext());
					yybegin(TITLED);
					}
	[^]				{ /* ignore */ }
}

<TITLED> {
	{LabletBegin}	{
					yybegin(SHEETTITLE);
					}
	[^]				{ /* ignore */ }
}

<SHEETTITLE> {
	{CurlyString}	{
					printSheetStart(yytext());
					yybegin(SHEET);
					}
}

<SHEET> {
	{LabletEnd}					{ yybegin(TITLED); }
	{Comment}					{ /* ignore */ }
	[^]							{ return  4; }
}

<<EOF>>							{ return YYEOF; }

