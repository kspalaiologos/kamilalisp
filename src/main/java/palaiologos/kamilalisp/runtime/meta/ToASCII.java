package palaiologos.kamilalisp.runtime.meta;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.parser.GrammarLexer;

import java.util.List;

public class ToASCII extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        String code = args.get(0).getString();
        GrammarLexer lex = new GrammarLexer(CharStreams.fromString(code));
        lex.removeErrorListeners();
        lex.addErrorListener(new Parser.ThrowingErrorListener(0));
        List<Token> tokens = (List<Token>) lex.getAllTokens();
        StringBuilder sb = new StringBuilder();
        for (Token token : tokens) {
            if (Environment.aliases.inverse().containsKey(token.getText()))
                sb.append(Environment.aliases.inverse().get(token.getText()));
            else
                sb.append(token.getText());
        }
        return new Atom(sb.toString());
    }

    @Override
    protected String name() {
        return "meta:to-ascii";
    }
}
