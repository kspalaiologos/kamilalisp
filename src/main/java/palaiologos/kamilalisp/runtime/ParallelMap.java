package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.InterruptionError;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class ParallelMap implements Lambda {
    private Atom form;

    private int l, c;

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    public ParallelMap(Atom form, int line, int col) {
        this.form = form;
        this.l = line;
        this.c = col;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Callable lambda = Evaluation.evaluate(env, form).getCallable();
        if(args.size() == 0)
            return Atom.NULL;
        if(args.size() == 1) {
            // map
            return new Atom((List<Atom>)
                    args.get(0).getList().stream().parallel().map(x -> {
                        return Evaluation.safeEvaluate(env, lambda, List.of(x), new Function<String, Atom>() {
                            @Override
                            public Atom apply(String s) {
                                System.err.println(s);
                                throw new InterruptionError();
                            }
                        });
                    }).collect(Collectors.toCollection(ArrayList::new)));
        } else {
            // zipWith
            return new Atom(IntStream.range(0, args.stream().map(x -> x.getList().size()).min(Integer::compareTo).get()).parallel()
                    .mapToObj(index -> Evaluation.safeEvaluate(env, lambda, args.stream().map(x -> x.getType() == Type.LIST ? x.getList().get(index) : x).collect(Collectors.toList()), new Function<String, Atom>() {
                        @Override
                        public Atom apply(String s) {
                            System.err.println(s);
                            throw new InterruptionError();
                        }
                    })).toList());
        }
    }

    @Override
    public String stringify() {
        return "$:" + form.toString();
    }

    @Override
    public String frameString() {
        return "$:/syn";
    }
}
