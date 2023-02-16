package palaiologos.kamilalisp.repl;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;
import org.jline.reader.Highlighter;
import org.jline.reader.LineReader;
import org.jline.utils.AttributedString;
import org.jline.utils.AttributedStringBuilder;
import org.jline.utils.AttributedStyle;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.parsers.GrammarLexer;

import java.util.regex.Pattern;

class LispHighlight implements Highlighter {
    private Environment refGlobEnv;

    public LispHighlight(Environment env) {
        refGlobEnv = env;
    }

    private boolean isKeyword(String s) {
        return refGlobEnv.has(s);
    }

    private static final AttributedStyle KW_STYLE = new AttributedStyle().foreground(AttributedStyle.MAGENTA);
    private static final AttributedStyle NUM_STYLE = new AttributedStyle().foreground(AttributedStyle.YELLOW);
    private static final AttributedStyle EMPTY_STYLE = new AttributedStyle();
    private static final AttributedStyle COMMENT_STYLE = new AttributedStyle().foreground(AttributedStyle.BRIGHT | AttributedStyle.BLACK);
    private static final AttributedStyle NIL_STYLE = new AttributedStyle().foreground(AttributedStyle.RED);
    private static final AttributedStyle STR_STYLE = new AttributedStyle().foreground(AttributedStyle.GREEN);
    private static final AttributedStyle DEF_STYLE = new AttributedStyle().foreground(AttributedStyle.BLUE);


    private static AttributedStyle getStyleForToken(Token t, boolean isKw, boolean isWs) {
        if (isKw)
            return KW_STYLE;
        return switch (t.getType()) {
            case GrammarLexer.BIN, GrammarLexer.FLOAT, GrammarLexer.HEX, GrammarLexer.LONG, GrammarLexer.COMPLEX ->
                    NUM_STYLE;
            case GrammarLexer.NAME -> EMPTY_STYLE;
            case GrammarLexer.TRASH -> isWs ? EMPTY_STYLE : COMMENT_STYLE;
            case GrammarLexer.NIL -> NIL_STYLE;
            case GrammarLexer.STRING -> STR_STYLE;
            default -> DEF_STYLE;
        };
    }

    @Override
    public AttributedString highlight(LineReader lineReader, String s) {
        AttributedStringBuilder b = new AttributedStringBuilder();
        if (s.isEmpty() || s.trim().isEmpty())
            return b.toAttributedString();
        GrammarLexer lex;

        if (s.startsWith("?")) {
            b.style(EMPTY_STYLE);
            b.append("?");
            s = s.substring(1);
        }
        
        lex = new GrammarLexer(CharStreams.fromString(s));

        lex.removeErrorListeners();
        int written = 0;
        for (Token x : lex.getAllTokens()) {
            b.style(getStyleForToken(x, isKeyword(x.getText()), x.getText().trim().isEmpty()));
            b.append(x.getText());
            written += x.getText().length();
        }
        if(written != s.length()) {
            b.style(EMPTY_STYLE);
            b.append(s.substring(written));
        }
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
