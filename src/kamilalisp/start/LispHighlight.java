package kamilalisp.start;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Environment;
import kamilalisp.reader.GrammarLexer;
import kamilalisp.reader.GrammarParser;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.ParseTree;
import org.jline.reader.Highlighter;
import org.jline.reader.LineReader;
import org.jline.utils.AttributedString;
import org.jline.utils.AttributedStringBuilder;
import org.jline.utils.AttributedStyle;

import java.util.List;
import java.util.regex.Pattern;

public class LispHighlight implements Highlighter {
    private static Environment refGlobEnv = null;

    public static boolean isKeyword(String s) {
        if(refGlobEnv == null)
            refGlobEnv = Evaluation.createDefaultEnv();
        return refGlobEnv.has(s);
    }

    public AttributedStyle getStyleForToken(Token t, boolean isKw) {
        if(isKw)
            return new AttributedStyle().foreground(AttributedStyle.MAGENTA);
        switch(t.getType()) {
            case GrammarLexer.BIN: case GrammarLexer.FLOAT: case GrammarLexer.HEX: case GrammarLexer.LONG:
                return new AttributedStyle().foreground(AttributedStyle.YELLOW);
            case GrammarLexer.NAME: case GrammarLexer.TRASH:
                return new AttributedStyle();
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
        if(s.length() == 0 || s.trim().length() == 0)
            return b.toAttributedString();
        GrammarLexer lex = new GrammarLexer(CharStreams.fromString(s));
        ((List<Token>) lex.getAllTokens()).forEach(x -> {
            b.style(getStyleForToken(x, isKeyword(x.getText())));
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
