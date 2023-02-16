package palaiologos.kamilalisp.runtime.cas;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Parser;
import palaiologos.kamilalisp.parsers.DefaultFortranFormulaGrammarVisitor;
import palaiologos.kamilalisp.parsers.FortranFormulaLexer;
import palaiologos.kamilalisp.parsers.FortranFormulaParser;

import java.util.Iterator;
import java.util.stream.Collectors;

public class FortranParser {
    public static Atom parse(String s) {
        // Skip until the first match of ^[A-Z][0-9]+=.
        Iterator<String> it = s.lines().map(x -> x.trim().matches("^[A-Z][0-9]+(\\([0-9]+\\))?=.*") ? x : null).iterator();
        int lineIdx = 0;
        while (it.hasNext()) {
            String q = it.next();
            if (q != null)
                break;
            lineIdx++;
        }
        s = s.lines().skip(lineIdx).collect(Collectors.joining());

        s = s.replaceAll("[ \\t]+\\&[ \\t]*", "")
                .replaceAll("NOTHING\\(\\)", "")
                .replaceAll("DSQRT\\(\\-1\\.0D0\\)", "%i")
                .replaceAll("DEXP\\(1\\)", "%e");
        FortranFormulaLexer lex = new FortranFormulaLexer(CharStreams.fromString(s));
        lex.removeErrorListeners();
        lex.addErrorListener(new Parser.ThrowingErrorListener(0));
        CommonTokenStream tokens = new CommonTokenStream(lex);
        FortranFormulaParser parser = new FortranFormulaParser(tokens);
        parser.removeErrorListeners();
        parser.addErrorListener(new Parser.ThrowingErrorListener(0));
        ParseTree tree = parser.main();
        DefaultFortranFormulaGrammarVisitor visitor = new DefaultFortranFormulaGrammarVisitor();
        return visitor.visit(tree);
    }

    public static void main(String[] args) {
        String s = "T1(1)=leftHandLimit=0\n" +
                "\n" +
                "      T1(2)=rightHandLimit=\"failed\"\n" +
                "\n" +
                "      T1";
        System.out.println(parse(s));
    }
}
