package palaiologos.kamilalisp.repl;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;
import org.jline.reader.Highlighter;
import org.jline.reader.LineReader;
import org.jline.utils.AttributedString;
import org.jline.utils.AttributedStringBuilder;
import org.jline.utils.AttributedStyle;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.parser.GrammarLexer;

import java.util.regex.Pattern;

class LispHighlight implements Highlighter {
    private Environment refGlobEnv;

    public LispHighlight(Environment env) {
        refGlobEnv = env;
    }

    private boolean isKeyword(String s) {
        return refGlobEnv.has(s);
    }

    private static AttributedStyle getStyleForToken(Token t, boolean isKw, boolean isWs) {
        if (isKw)
            return new AttributedStyle().foreground(AttributedStyle.MAGENTA);
        switch (t.getType()) {
            case GrammarLexer.BIN:
            case GrammarLexer.FLOAT:
            case GrammarLexer.HEX:
            case GrammarLexer.LONG:
            case GrammarLexer.COMPLEX:
                return new AttributedStyle().foreground(AttributedStyle.YELLOW);
            case GrammarLexer.NAME:
                return new AttributedStyle();
            case GrammarLexer.TRASH:
                return isWs ? new AttributedStyle() : new AttributedStyle().foreground(AttributedStyle.BRIGHT | AttributedStyle.BLACK);
            case GrammarLexer.NIL:
                return new AttributedStyle().foreground(AttributedStyle.RED);
            case GrammarLexer.STRING:
                return new AttributedStyle().foreground(AttributedStyle.GREEN);
            default:
                return new AttributedStyle().foreground(AttributedStyle.BLUE);
        }
    }

    @Override
    public AttributedString highlight(LineReader lineReader, String s) {
        AttributedStringBuilder b = new AttributedStringBuilder();
        if (s.isEmpty() || s.trim().isEmpty())
            return b.toAttributedString();
        GrammarLexer lex = new GrammarLexer(CharStreams.fromString(s));
        lex.getAllTokens().forEach(x -> {
            b.style(getStyleForToken(x, isKeyword(x.getText()), x.getText().trim().isEmpty()));
            b.append(x.getText());
        });
        return b.toAttributedString();
    }

    @Override
    public void setErrorPattern(Pattern pattern) {
        // Ignore.
    }

    @Override
    public void setErrorIndex(int i) {
        // Ignore.
    }
}
