package palaiologos.kamilalisp.runtime.cas;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Parser;
import palaiologos.kamilalisp.parsers.DefaultFortranFormulaGrammarVisitor;
import palaiologos.kamilalisp.parsers.FortranFormulaLexer;
import palaiologos.kamilalisp.parsers.FortranFormulaParser;

public class FortranParser {
    public static Atom parse(String s) {
        s = s.replaceAll("[ \\t]+\\&[ \\t]*", "")
                .replace("\r", "")
                .replace("\n", "")
                .replaceAll("NOTHING\\(\\)", "")
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
        String s = "R2=(x*x*DEXP(1))/2";
        System.out.println(parse(s));
    }
}
