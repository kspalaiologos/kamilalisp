package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Map implements SpecialForm, ReactiveFunction {
    private final Atom form;

    private final int l;
    private final int c;

    public Map(Atom form, int line, int col) {
        this.form = form;
        this.l = line;
        this.c = col;
    }

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Callable lambda = Evaluation.evaluate(env, form).getCallable();
        return new Atom(new Lambda() {
            @Override
            public String stringify() {
                return Map.this.stringify();
            }

            @Override
            public String frameString() {
                return Map.this.frameString();
            }

            @Override
            public Atom apply(Environment env, List<Atom> args) {
                if (args.size() == 0)
                    return Atom.NULL;
                if (args.size() == 1) {
                    // map
                    if(args.get(0).getType() != Type.LIST)
                        return Evaluation.evaluate(env, lambda, args);
                    return new Atom((List<Atom>)
                            args.get(0).getList().stream().map(x -> Evaluation.evaluate(env, lambda, List.of(x)))
                                    .collect(Collectors.toCollection(ArrayList::new)));
                } else {
                    // zipWith
                    return new Atom(IntStream.range(0, args.stream().filter(x -> x.getType() == Type.LIST).map(x -> x.getList().size()).filter(x -> x != 1).min(Integer::compareTo).orElse(1))
                            .mapToObj(index -> Evaluation.evaluate(env, lambda, args.stream().map(x -> x.getType() == Type.LIST ? (x.getList().size() != 1 ? x.getList().get(index) : x.getList().get(0)) : x)
                                    .collect(Collectors.toCollection(ArrayList::new)))).toList());
                }
            }

            @Override
            public int line() {
                return Map.this.line();
            }

            @Override
            public int column() {
                return Map.this.column();
            }
        });
    }

    @Override
    public String stringify() {
        return ":" + form.toString();
    }

    @Override
    public String frameString() {
        return ":/syn";
    }
}
