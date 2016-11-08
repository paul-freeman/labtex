package nz.ac.auckland.labtex;

import java.io.FileReader;

import nz.ac.auckland.labtex.generated.parser;
import nz.ac.auckland.labtex.generated.Scanner;

public class Main {
	public static void main(String[] args) {
		try {
            Scanner scanner = new Scanner(new FileReader(args[0]));
			parser p = new parser(scanner);
			Object result = p.parse().value;
		}
		catch (Exception e) {
			System.out.println("There was an error: " + e.getMessage());
		}
	}
}
