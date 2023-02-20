package palaiologos.kamilalisp.runtime.ide.terminal;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Lexer;
import org.fife.ui.rsyntaxtextarea.Token;
import palaiologos.kamilalisp.parsers.GrammarLexer;
import palaiologos.kamilalisp.repl.Main;
import palaiologos.kamilalisp.runtime.ide.AntlrTokenMaker;
import palaiologos.kamilalisp.runtime.ide.MultiLineTokenInfo;
import palaiologos.kamilalisp.runtime.remote.RemotePacketRegistry;

import java.util.Set;

public class TerminalKamilaLispTokenMaker extends AntlrTokenMaker {
    public TerminalKamilaLispTokenMaker() {
        super(new MultiLineTokenInfo(0, Token.LITERAL_STRING_DOUBLE_QUOTE,"\"","\""));
    }

    @Override
    protected Lexer createLexer(String text) {
        return new GrammarLexer(CharStreams.fromString(text))  {
            @Override
            public void skip() {
                setChannel(HIDDEN);
            }
        };
    }

    @Override
    protected int convertType(String s, int type) {
        return switch (type) {
            case GrammarLexer.BIN, GrammarLexer.HEX, GrammarLexer.LONG -> Token.LITERAL_NUMBER_DECIMAL_INT;
            case GrammarLexer.FLOAT -> Token.LITERAL_NUMBER_FLOAT;
            case GrammarLexer.COMPLEX -> Token.LITERAL_CHAR;
            case GrammarLexer.NIL -> Token.LITERAL_BOOLEAN;
            case GrammarLexer.NAME -> {
                if(s.equals("true") || s.equals("false"))
                    yield Token.LITERAL_BOOLEAN;
                else if (Main.defaultRegistry.has(s) || RemotePacketRegistry.terminalKeys.contains(s)) {
                    if (s.contains(":"))
                        yield Token.RESERVED_WORD;
                    else
                        yield Token.FUNCTION;
                } else
                    yield Token.VARIABLE;
            }
            case GrammarLexer.DOLLAR, GrammarLexer.DOT, GrammarLexer.ARROW,
                    GrammarLexer.PERCENT, GrammarLexer.BIND, GrammarLexer.LISTPART,
                    GrammarLexer.SWIZZLE, GrammarLexer.SELF, GrammarLexer.TACK,
                    GrammarLexer.TACKTACK, GrammarLexer.MAPSYM, GrammarLexer.QUOTE -> Token.OPERATOR;
            case GrammarLexer.COMMENT -> Token.COMMENT_EOL;
            case GrammarLexer.STRING -> Token.LITERAL_STRING_DOUBLE_QUOTE;
            default -> Token.IDENTIFIER;
        };
    }

    @Override
    public String[] getLineCommentStartAndEnd(int languageIndex) {
        return new String[]{";", null};
    }
}
