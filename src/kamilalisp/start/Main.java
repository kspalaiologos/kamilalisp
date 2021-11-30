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

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    private static void banner() {
        System.out.println("KamilaLisp v 0.1 - Copyright (C) Kamila Szewczyk, 2021.");
        System.out.println("Interactive mode.");
        System.out.println();
    }

    public static void evalScript(Environment env, String source) throws IOException {
        Evaluation.evalString(env, Files.readString(Path.of(source))).stream().forEach(x -> x.get().get());
    }

    public static void main(String[] args) throws IOException {
        if(args.length == 1) {
            evalScript(Evaluation.createDefaultEnv(), args[0]);
            return;
        } else if(args.length != 0)
            throw new IllegalArgumentException("Please pass no arguments to start a REPL, or pass a single argument with the KamilaLisp script file.");
        Environment env = Evaluation.createDefaultEnv();
        banner();
        DefaultParser parser = new DefaultParser();
        parser.setEofOnUnclosedBracket(Bracket.ROUND, Bracket.SQUARE);
        parser.setEscapeChars(new char[]{});
        parser.setQuoteChars(new char[]{});
        LineReader r = LineReaderBuilder
                .builder()
                .appName("KamilaLisp")
                .parser(parser)
                .history(new DefaultHistory())
                .highlighter(new LispHighlight())
                .variable(LineReader.SECONDARY_PROMPT_PATTERN, "%P. ")
                .variable(LineReader.INDENTATION, 3)
                .build();
        try {
            while (true) {
                String code = r.readLine("--> ");
                if(code.length() == 0 || code.trim().length() == 0 || code.trim().startsWith(";"))
                    continue;
                try {
                    Atom result = Evaluation.evalAtom(env, code);
                    System.out.println(result);
                } catch(Throwable e) {
                    e.printStackTrace();
                }
            }
        } catch(EndOfFileException e) {
            System.out.println("Bye.");
        } catch(UserInterruptException e) {
            System.out.println("Interrupted.");
        }
    }
}
