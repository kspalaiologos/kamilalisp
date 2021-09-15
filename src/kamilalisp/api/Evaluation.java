package kamilalisp.api;

import kamilalisp.libs.CoreLib;
import kamilalisp.libs.IOLib;
import kamilalisp.libs.MathLib;
import kamilalisp.data.Atom;
import kamilalisp.data.Environment;
import kamilalisp.data.Executor;
import kamilalisp.reader.Lexer;
import kamilalisp.reader.Parser;
import kamilalisp.reader.Token;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

public class Evaluation {
    public static List<Atom> evalString(String code) {
        ByteArrayInputStream input = new ByteArrayInputStream(code.getBytes(StandardCharsets.UTF_8));
        List<Token> tokens = null;
        try {
            tokens = new Lexer(input).getTokens();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Parser p = new Parser(tokens);
        List<Atom> atoms = new LinkedList<>();
        while(p.hasMore())
            atoms.add(p.parse());
        Environment globEnv = new Environment("Global scope");
        globEnv.owner = null;
        IOLib.install(globEnv);
        MathLib.install(globEnv);
        CoreLib.install(globEnv);
        Executor executor = new Executor(globEnv);
        return atoms.stream().map(executor::evaluate).collect(Collectors.toList());
    }

    public static List<Atom> evalString(Environment globEnv, String code) {
        ByteArrayInputStream input = new ByteArrayInputStream(code.getBytes(StandardCharsets.UTF_8));
        List<Token> tokens = null;
        try {
            tokens = new Lexer(input).getTokens();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Parser p = new Parser(tokens);
        List<Atom> atoms = new LinkedList<>();
        while(p.hasMore())
            atoms.add(p.parse());
        Executor executor = new Executor(globEnv);
        return atoms.stream().map(executor::evaluate).collect(Collectors.toList());
    }

    public static Environment createDefaultEnv() {
        Environment globEnv = new Environment("Global scope");
        IOLib.install(globEnv);
        MathLib.install(globEnv);
        CoreLib.install(globEnv);
        globEnv.owner = null;
        return globEnv;
    }
}
