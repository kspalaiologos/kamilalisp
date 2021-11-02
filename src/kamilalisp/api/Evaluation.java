package kamilalisp.api;

import kamilalisp.libs.CoreLib;
import kamilalisp.libs.IOLib;
import kamilalisp.libs.ListLib;
import kamilalisp.libs.MathLib;
import kamilalisp.data.Atom;
import kamilalisp.data.Environment;
import kamilalisp.data.Executor;
import kamilalisp.reader.Lexer;
import kamilalisp.reader.Parser;
import kamilalisp.reader.Token;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

public class Evaluation {
    public static List<Atom> evalString(String code) {
        Lexer l = new Lexer(new StringReader(code));
        Parser p = new Parser(l);
        List<Atom> atoms = new LinkedList<>();
        while(p.hasMore())
            atoms.add(p.parse());
        Environment globEnv = createDefaultEnv();
        Executor executor = new Executor(globEnv);
        return atoms.stream().map(executor::evaluate).collect(Collectors.toList());
    }

    public static List<Atom> evalString(Environment globEnv, String code) {
        Lexer l = new Lexer(new StringReader(code));
        Parser p = new Parser(l);
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
        ListLib.install(globEnv);
        globEnv.owner = null;
        return globEnv;
    }
}
