package palaiologos.kamilalisp.atom;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.antlr.v4.runtime.tree.ParseTree;
import palaiologos.kamilalisp.parsers.DefaultGrammarVisitor;
import palaiologos.kamilalisp.parsers.GrammarLexer;
import palaiologos.kamilalisp.parsers.GrammarParser;

import java.util.List;

public class Parser {
    public static Atom parseNumber(String input) {
        GrammarLexer lex = new GrammarLexer(CharStreams.fromString(input)) {
            @Override
            public void skip() {
                setChannel(HIDDEN);
            }
        };
        lex.removeErrorListeners();
        lex.addErrorListener(new ThrowingErrorListener(0));
        CommonTokenStream tokens = new CommonTokenStream(lex);
        GrammarParser parser = new GrammarParser(tokens);
        parser.removeErrorListeners();
        parser.addErrorListener(new ThrowingErrorListener(0));
        ParseTree tree = parser.number();
        DefaultGrammarVisitor visitor = new DefaultGrammarVisitor(0);
        return visitor.visit(tree);
    }

    public static boolean isValidIdentifier(String input) {
        try {
            GrammarLexer lex = new GrammarLexer(CharStreams.fromString(input)) {
                @Override
                public void skip() {
                    setChannel(HIDDEN);
                }
            };
            lex.removeErrorListeners();
            lex.addErrorListener(new ThrowingErrorListener(0));
            var tokens = lex.getAllTokens();
            return tokens.get(0).getType() == GrammarLexer.NAME && tokens.size() == 1;
        } catch (Throwable e) {
            return false;
        }
    }

    public static List<Atom> parse(int lineNumberOffset, String input) {
        GrammarLexer lex = new GrammarLexer(CharStreams.fromString(input)) {
            @Override
            public void skip() {
                setChannel(HIDDEN);
            }
        };
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

    public static class ThrowingErrorListener extends BaseErrorListener {
        private final int lineNumberOffset;

        public ThrowingErrorListener(int lineNumberOffset) {
            this.lineNumberOffset = lineNumberOffset;
        }

        @Override
        public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e)
                throws ParseCancellationException {
            throw new ParseCancellationException("line " + lineNumberOffset + line + ":" + charPositionInLine + " " + msg);
        }
    }
}
