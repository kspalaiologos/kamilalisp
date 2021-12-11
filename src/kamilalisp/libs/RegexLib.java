package kamilalisp.libs;

import kamilalisp.data.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class RegexLib {
    public static void install(Environment env) {
        env.push("regex-match", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2 && arguments.size() != 3)
                    throw new Error("Invalid invocation to 'regex-match'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'regex-match'", Type.STRING_CONSTANT);
                    arguments.get(1).guardType("Second argument to 'regex-match'", Type.STRING_CONSTANT);
                    String pattern = arguments.get(0).getStringConstant().get().get();
                    String input = arguments.get(1).getStringConstant().get().get();
                    Pattern p = Pattern.compile(pattern);
                    Matcher reader = p.matcher(input);
                    if(arguments.size() == 3) {
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

        env.push("regex-replace", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'regex-replace'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'regex-replace'", Type.STRING_CONSTANT);
                    arguments.get(1).guardType("Second argument to 'regex-replace'", Type.STRING_CONSTANT, Type.MACRO, Type.CLOSURE);
                    arguments.get(2).guardType("Second argument to 'regex-replace'", Type.STRING_CONSTANT);
                    String pattern = arguments.get(0).getStringConstant().get().get();
                    String input = arguments.get(2).getStringConstant().get().get();
                    if(arguments.get(1).getType() == Type.STRING_CONSTANT) {
                        String replacement = arguments.get(1).getStringConstant().get().get();
                        return new StringConstant(input.replaceAll(pattern, replacement));
                    } else {
                        Pattern p = Pattern.compile(pattern);
                        Matcher reader = p.matcher(input);
                        Callable c = arguments.get(1).getCallable().get();
                        // Preprocess the results with a closure.
                        StringBuffer out = new StringBuffer();
                        while (reader.find()) {
                            List<Atom> args = new ArrayList<>();
                            for (int i = 0; i < reader.groupCount() + 1; i++)
                                args.add(new Atom(new StringConstant(reader.group(i))));
                            Atom application = c.apply(env, List.of(new Atom(new BigDecimal(reader.start())), new Atom(new BigDecimal(reader.end())), new Atom(args)));
                            String r;
                            if(application.getType() == Type.STRING_CONSTANT)
                                r = application.getStringConstant().get().get();
                            else
                                r = application.toString();
                            reader.appendReplacement(out, r);
                        }
                        reader.appendTail(out);
                        return out.toString();
                    }
                }));
            }
        }));

        env.push("regex-split", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'regex-split'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'regex-split'", Type.STRING_CONSTANT);
                    arguments.get(1).guardType("Second argument to 'regex-split'", Type.STRING_CONSTANT);
                    String pattern = arguments.get(0).getStringConstant().get().get();
                    String input = arguments.get(1).getStringConstant().get().get();
                    return Arrays.stream(input.split(pattern)).map(x -> new Atom(new StringConstant(x))).collect(Collectors.toList());
                }));
            }
        }));
    }
}
