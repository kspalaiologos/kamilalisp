package palaiologos.kamilalisp.repl;

import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.jline.reader.EndOfFileException;
import org.jline.reader.LineReader;
import org.jline.reader.LineReaderBuilder;
import org.jline.reader.UserInterruptException;
import org.jline.reader.impl.DefaultParser;
import org.jline.reader.impl.history.DefaultHistory;
import org.jline.terminal.Terminal;
import org.jline.terminal.TerminalBuilder;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Evaluation;
import palaiologos.kamilalisp.atom.Parser;
import palaiologos.kamilalisp.error.InterruptionError;
import palaiologos.kamilalisp.runtime.FunctionRegistry;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Main {
    private static Environment defaultRegistry;

    public static boolean isBuiltin(String name) {
        if(defaultRegistry == null) {
            defaultRegistry = new Environment();
            FunctionRegistry.registerDefault(defaultRegistry);
        }

        return defaultRegistry.keys().contains(name);
    }

    private static void banner() {
        System.out.println("KamilaLisp v 0.2 - Copyright (C) Kamila Szewczyk, 2021 - 2022.");
        System.out.println("Interactive mode.");
        System.out.println();
    }

    public static void evalScript(Environment env, String source) throws IOException {
        List<Atom> data = Parser.parse(Files.readString(Path.of(source)));
        try {
            for (Atom atom : data) {
                Evaluation.safeEvaluate(env, atom, x -> {
                    System.out.println(x);
                    throw new InterruptionError();
                });
            }
        } catch (InterruptionError e) {
            // Ignore, we just wanted to unwind the stack.
        }
    }

    public static void main(String[] args) throws IOException {
        if (args.length == 1) {
            evalScript(Environment.defaultEnvironment(), args[0]);
            return;
        } else if (args.length != 0)
            throw new IllegalArgumentException("Please pass no arguments to start a REPL, or pass a single argument with the KamilaLisp script file.");
        banner();
        Environment env = Environment.defaultEnvironment();
        DefaultParser parser = new DefaultParser();
        parser.setEofOnUnclosedBracket(DefaultParser.Bracket.ROUND, DefaultParser.Bracket.SQUARE);
        parser.setEscapeChars(new char[]{});
        parser.setQuoteChars(new char[]{});
        Terminal t = TerminalBuilder.builder().dumb(true).build();
        // Bug workaround for JLine3.
        String promptPattern = t.getType().equals(Terminal.TYPE_DUMB) || t.getType().equals(Terminal.TYPE_DUMB_COLOR) ? "" : "%P. ";
        LineReader r = LineReaderBuilder
                .builder()
                .appName("KamilaLisp")
                .parser(parser)
                .history(new DefaultHistory())
                .highlighter(new LispHighlight(env))
                .variable(LineReader.SECONDARY_PROMPT_PATTERN, promptPattern)
                .variable(LineReader.INDENTATION, 3)
                .terminal(t)
                .completer(new LispCompletion(env))
                .build();
        int lineNumberOffset = 0;
        try {
            while (true) {
                String code = r.readLine("--> ");
                if (code.length() == 0 || code.trim().length() == 0 || code.trim().startsWith(";"))
                    continue;
                try {
                    List<Atom> data;
                    try {
                        String cc;
                        if(code.startsWith("?")) {
                            cc = code.substring(1);
                        } else if(code.startsWith("(") && code.endsWith(")")) {
                            cc = code;
                        } else {
                            cc = "(" + code + "\n)";
                        }
                        data = Parser.parse(lineNumberOffset, cc);
                    } catch (ParseCancellationException e) {
                        System.out.println("Syntax error: " + e.getMessage());
                        continue;
                    }
                    for (Atom atom : data) {
                        Atom a = Evaluation.safeEvaluate(env, atom, s -> {
                            System.err.println(s);
                            throw new InterruptionError();
                        });
                        if(a.equals(Atom.NULL))
                            continue;
                        System.out.println(a.toDisplayString());
                    }
                } catch (InterruptionError e) {
                    // Ignore, we just wanted to unwind the stack.
                }
                // count newlines in code
                lineNumberOffset += code.chars().filter(c -> c == '\n').count();
            }
        } catch (EndOfFileException e) {
            System.out.println("Bye.");
        } catch (UserInterruptException e) {
            System.out.println("Interrupted.");
        }
    }
}
