package kamilalisp.api;

import kamilalisp.libs.CoreLib;
import kamilalisp.libs.IOLib;
import kamilalisp.libs.ListLib;
import kamilalisp.libs.MathLib;
import kamilalisp.data.Atom;
import kamilalisp.data.Environment;
import kamilalisp.data.Executor;
import kamilalisp.reader.DefaultVisitor;
import kamilalisp.reader.GrammarLexer;
import kamilalisp.reader.GrammarParser;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.stream.Collectors;

public class Evaluation {
    public static List<Atom> evalString(String code) {
        GrammarLexer lex = new GrammarLexer(CharStreams.fromString(code));
        CommonTokenStream tokens = new CommonTokenStream(lex);
        GrammarParser parser = new GrammarParser(tokens);
        ParseTree tree = parser.file_();
        DefaultVisitor visitor = new DefaultVisitor();
        List<Atom> atoms = visitor.visit(tree).getList().get();
        Environment globEnv = createDefaultEnv();
        Executor executor = new Executor(globEnv);
        return atoms.stream().map(executor::evaluate).collect(Collectors.toList());
    }

    public static List<Atom> evalString(Environment globEnv, String code) {
        GrammarLexer lex = new GrammarLexer(CharStreams.fromString(code));
        CommonTokenStream tokens = new CommonTokenStream(lex);
        GrammarParser parser = new GrammarParser(tokens);
        ParseTree tree = parser.file_();
        DefaultVisitor visitor = new DefaultVisitor();
        List<Atom> atoms = visitor.visit(tree).getList().get();
        Executor executor = new Executor(globEnv);
        return atoms.stream().map(executor::evaluate).collect(Collectors.toList());
    }

    public static Atom evalAtom(Environment globEnv, String code) {
        GrammarLexer lex = new GrammarLexer(CharStreams.fromString(code));
        CommonTokenStream tokens = new CommonTokenStream(lex);
        GrammarParser parser = new GrammarParser(tokens);
        ParseTree tree = parser.form();
        DefaultVisitor visitor = new DefaultVisitor();
        Atom atom = visitor.visit(tree);
        Executor executor = new Executor(globEnv);
        return executor.evaluate(atom);
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
