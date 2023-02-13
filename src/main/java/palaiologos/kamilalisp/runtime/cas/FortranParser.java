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
                .replaceAll("NOTHING\\(\\)", "");
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
        String s = "R2=(45*polylog(6,DEXP(2*n*pi))-90*n*pi*polylog(5,DEXP(2*n*pi))+90*\n" +
                "\n" +
                "     &n*n*%pi*%pi*polylog(4,DEXP(2*n*pi))-60*n**3*pi**3*polylog(3,DEXP(2\n" +
                "\n" +
                "     &*n*pi))+12*n**5*pi**5*DLOG(-DEXP(2*n*pi)+1)+30*n**4*pi**4*dilog(-D\n" +
                "\n" +
                "     &EXP(2*n*pi)+1)-4*n**6*pi**6)/(24*pi**6)";
        System.out.println(parse(s));
    }
}
