package kamilalisp.api;

import com.google.common.io.Resources;
import kamilalisp.data.Atom;
import kamilalisp.data.Environment;
import kamilalisp.data.Executor;
import kamilalisp.libs.*;
import kamilalisp.reader.DefaultVisitor;
import kamilalisp.reader.GrammarLexer;
import kamilalisp.reader.GrammarParser;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
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
        CoreLib.install(globEnv);
        IOLib.install(globEnv);
        MathLib.install(globEnv);
        ListLib.install(globEnv);
        FoldLib.install(globEnv);
        MatrixLib.install(globEnv);
        RegexLib.install(globEnv);
        SymLib.install(globEnv);
        try {
            Evaluation.evalString(globEnv, Resources.toString(Resources.getResource("kamilalisp/prelude.lisp"), StandardCharsets.UTF_8));
        } catch (IOException e) {
            e.printStackTrace();
        }
        globEnv.owner = null;
        return globEnv;
    }
}
