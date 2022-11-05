package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Map implements Lambda {
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

    public Map(Atom form, int line, int col) {
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
                    args.get(0).getList().stream().map(x -> Evaluation.evaluate(env, lambda, List.of(x)))
                            .collect(Collectors.toCollection(ArrayList::new)));
        } else {
            // zipWith
            return new Atom(IntStream.range(0, args.stream().map(x -> x.getList().size()).min(Integer::compareTo).get())
                    .mapToObj(index -> Evaluation.evaluate(env, lambda, args.stream().map(x -> x.getType() == Type.LIST ? x.getList().get(index) : x)
                            .collect(Collectors.toCollection(ArrayList::new)))).toList());
        }
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
