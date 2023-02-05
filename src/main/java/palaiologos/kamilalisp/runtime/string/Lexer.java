package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class Lexer extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        List<Pattern> patterns = args.stream().map(Atom::getString).map(Pattern::compile).toList();
        return new Atom(new Lambda() {
            @Override
            public String stringify() {
                return "$" + Lexer.this.stringify();
            }

            @Override
            public String frameString() {
                return "$" + Lexer.this.frameString();
            }

            @Override
            public Atom apply(Environment env, List<Atom> args) {
                assertArity(args, 1);
                String string = args.get(0).getString();
                List<Pair<Integer, String>> tokens = new ArrayList<>();

                int pos = 0;
                while (pos < string.length()) {
                    boolean matched = false;

                    for (int i = 0; i < patterns.size(); i++) {
                        Pattern pattern = patterns.get(i);
                        var matcher = pattern.matcher(string);
                        matcher.region(pos, string.length());
                        if (matcher.lookingAt()) {
                            tokens.add(new Pair<>(i, matcher.group()));
                            pos = matcher.end();
                            matched = true;
                            break;
                        }
                    }

                    if (!matched) {
                        throw new RuntimeException("Lexer error: no pattern matched at " + pos);
                    }
                }

                return new Atom(tokens.stream().map(x -> new Atom(List.of(new Atom(BigInteger.valueOf(x.fst())), new Atom(x.snd())))).toList());
            }

            @Override
            public int line() {
                return Lexer.this.line();
            }

            @Override
            public int column() {
                return Lexer.this.column();
            }
        });
    }

    @Override
    protected String name() {
        return "str:lexer";
    }
}
