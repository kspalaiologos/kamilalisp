package kamilalisp.start;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Atom;
import kamilalisp.data.Environment;
import org.jline.reader.EndOfFileException;
import org.jline.reader.LineReader;
import org.jline.reader.LineReaderBuilder;
import org.jline.reader.UserInterruptException;
import org.jline.reader.impl.DefaultParser;
import org.jline.reader.impl.DefaultParser.Bracket;
import org.jline.reader.impl.history.DefaultHistory;
import org.jline.terminal.Size;
import org.jline.terminal.Terminal;
import org.jline.terminal.TerminalBuilder;

import java.io.IOException;
import java.util.List;
import java.util.Scanner;

public class Main {
    private static void banner() {
        System.out.println("KamilaLisp v 1.0 - Copyright (C) Kamila Szewczyk, 2021.");
        System.out.println("Interactive mode.");
        System.out.println();
    }

    public static void main(String[] args) throws IOException {
        Environment env = Evaluation.createDefaultEnv();
        banner();
        DefaultParser parser = new DefaultParser();
        parser.setEofOnUnclosedBracket(Bracket.ROUND, Bracket.SQUARE);
        parser.setEofOnUnclosedQuote(true);
        parser.setEscapeChars(new char[]{'\\'});
        parser.setQuoteChars(new char[]{'\"'});
        LineReader r = LineReaderBuilder
                .builder()
                .appName("KamilaLisp")
                .parser(parser)
                .history(new DefaultHistory())
                .variable(LineReader.SECONDARY_PROMPT_PATTERN, "%P. ")
                .variable(LineReader.INDENTATION, 3)
                .build();
        try {
            while (true) {
                String code = r.readLine("--> ");
                Atom result = Evaluation.evalAtom(env, code);
                System.out.println(result);
            }
        } catch(EndOfFileException e) {
            System.out.println("Bye.");
        } catch(UserInterruptException e) {
            System.out.println("Interrupted.");
        }
    }
}
