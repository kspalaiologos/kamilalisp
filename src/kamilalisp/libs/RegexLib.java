package kamilalisp.libs;

import kamilalisp.data.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexLib {
    public static void install(Environment env) {
        env.push("regex-match", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                return new Atom(new LbcSupplier<>(() -> {
                    if(arguments.size() < 2)
                        throw new RuntimeException("Invalid invocation to 'regex-match'.");
                    arguments.get(0).guardType("First argument to 'regex-match'", Type.STRING_CONSTANT);
                    arguments.get(1).guardType("Second argument to 'regex-match'", Type.STRING_CONSTANT);
                    String pattern = arguments.get(0).getStringConstant().get().get();
                    String input = arguments.get(1).getStringConstant().get().get();
                    Pattern p = Pattern.compile(pattern);
                    Matcher reader = p.matcher(input);
                    if(arguments.size() > 2) {
                        arguments.get(2).guardType("Third argument to 'regex-match'", Type.CLOSURE, Type.MACRO);
                        Callable c = arguments.get(2).getCallable().get();
                        // Preprocess the results with a closure.
                        List<Atom> results = new ArrayList<>();
                        while(reader.find()) {
                            List<Atom> args = new ArrayList<>();
                            for(int i = 0; i < reader.groupCount() + 1; i++)
                                args.add(new Atom(new StringConstant(reader.group(i))));
                            results.add(c.apply(env, List.of(new Atom(new BigDecimal(reader.start())), new Atom(new BigDecimal(reader.end())), new Atom(args))));
                        }
                        return results;
                    } else {
                        // Simply dump the results into an array.
                        List<Atom> l = new ArrayList<>();
                        while(reader.find())
                            l.add(new Atom(new StringConstant(reader.group())));
                        return l;
                    }
                }));
            }
        }));
    }
}
