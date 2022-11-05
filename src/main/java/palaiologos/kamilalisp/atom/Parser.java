package palaiologos.kamilalisp.atom;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.antlr.v4.runtime.tree.ParseTree;
import palaiologos.kamilalisp.parser.DefaultGrammarVisitor;
import palaiologos.kamilalisp.parser.GrammarLexer;
import palaiologos.kamilalisp.parser.GrammarParser;

import java.util.List;

public class Parser {
    static class ThrowingErrorListener extends BaseErrorListener {
        private int lineNumberOffset;

        public ThrowingErrorListener(int lineNumberOffset) {
            this.lineNumberOffset = lineNumberOffset;
        }

        @Override
        public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e)
                throws ParseCancellationException {
            throw new ParseCancellationException("line " + lineNumberOffset + line + ":" + charPositionInLine + " " + msg);
        }
    }

    public static List<Atom> parse(int lineNumberOffset, String input) {
        GrammarLexer lex = new GrammarLexer(CharStreams.fromString(input));
        lex.removeErrorListeners();
        lex.addErrorListener(new ThrowingErrorListener(lineNumberOffset));
        CommonTokenStream tokens = new CommonTokenStream(lex);
        GrammarParser parser = new GrammarParser(tokens);
        parser.removeErrorListeners();
        parser.addErrorListener(new ThrowingErrorListener(lineNumberOffset));
        ParseTree tree = parser.file_();
        DefaultGrammarVisitor visitor = new DefaultGrammarVisitor(lineNumberOffset);
        return visitor.visit(tree).getList();
    }

    public static List<Atom> parse(String input) {
        return parse(0, input);
    }
}
