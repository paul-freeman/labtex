package nz.ac.auckland.labtex;

import java.io.FileReader;
import java.io.PrintWriter;

import nz.ac.auckland.labtex.generated.LabParser;
import nz.ac.auckland.labtex.generated.LabLexer;

public class Main {
    public static void main(String[] args) {
        LabLexer lexer;
		LabParser parser;
		try {
			lexer = new LabLexer(new FileReader(args[0]));

            /* deprecated in favor of new ComplexSymbolFactory */
            /* but seems like premature deprecation to me */
			parser = new LabParser(lexer);

			Object result = parser.parse().value;
            PrintWriter my_file = new PrintWriter("/home/pfre484/testLua.lua");
			my_file.println(result);
			my_file.close();
		}
		catch (Exception e) {
			System.out.println("There was an error: " + e.getMessage());
		}
	}
}
