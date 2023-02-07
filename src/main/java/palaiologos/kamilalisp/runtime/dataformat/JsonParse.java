package palaiologos.kamilalisp.runtime.dataformat;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.parser.DefaultGrammarVisitor;
import palaiologos.kamilalisp.parser.JSONLexer;
import palaiologos.kamilalisp.parser.JSONParser;

import java.nio.charset.StandardCharsets;
import java.util.List;

public class JsonParse extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Atom arg = args.get(0);
        String jsondata = null;

        if (arg.getType() == Type.LIST) {
            // Assume a buffer.
            byte[] data = new byte[arg.getList().size()];
            for (int i = 0; i < arg.getList().size(); i++)
                data[i] = arg.getList().get(i).getInteger().byteValueExact();
            jsondata = new String(data, StandardCharsets.UTF_8);
        } else if (arg.getType() == Type.STRING) {
            // Assume a string.
            jsondata = arg.getString();
        } else {
            throw new RuntimeException("json:parse not defined for: " + arg.getType());
        }

        JSONLexer lex = new JSONLexer(CharStreams.fromString(jsondata));
        lex.removeErrorListeners();
        lex.addErrorListener(new Parser.ThrowingErrorListener(0));
        CommonTokenStream tokens = new CommonTokenStream(lex);
        JSONParser parser = new JSONParser(tokens);
        parser.removeErrorListeners();
        parser.addErrorListener(new Parser.ThrowingErrorListener(0));
        ParseTree tree = parser.json();
        DefaultGrammarVisitor visitor = new DefaultGrammarVisitor(0);
        return visitor.visit(tree);
    }

    @Override
    protected String name() {
        return "json:parse";
    }
}
