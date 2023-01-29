package palaiologos.kamilalisp.runtime;

import com.google.common.collect.Iterables;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class Depth implements SpecialForm, ReactiveFunction {
    private final Atom form;
    private final List<Atom> depths;

    private final int l;
    private final int c;

    public Depth(Atom form, List<Atom> depths, int line, int col) {
        this.form = form;
        this.l = line;
        this.c = col;
        this.depths = depths;

        if (this.depths.isEmpty()) {
            throw new RuntimeException("Error on line " + l + " column " + c + ". Empty depth.");
        }
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
    public Atom apply(Environment oldEnv, List<Atom> args) {
        Callable lambda = Evaluation.evaluate(oldEnv, form).getCallable();
        return new Atom(new Lambda() {
            @Override
            public String stringify() {
                return Depth.this.stringify();
            }

            @Override
            public String frameString() {
                return Depth.this.frameString();
            }

            @Override
            public Atom apply(Environment env, List<Atom> args) {
                if (args.size() == 0)
                    return Atom.NULL;

                // Check what in the world is the depths list.
                // Case 1: Just integers.
                List<Atom> data;
                if (depths.stream().allMatch(a -> a.getType() == Type.INTEGER)) {
                    // OK, so we have a list of integers. Cycle it so that it's the same length as the args list,
                    // shortening it if needed.
                    data = depths;
                } else {
                    // Case 2: Anything else.
                    // Evaluate the list in the old environment and then do the same thing as above.
                    Atom a = Evaluation.evaluate(oldEnv, new Atom(depths));
                    if (a.getType() != Type.LIST || !a.getList().stream().allMatch(b -> b.getType() == Type.INTEGER))
                        throw new RuntimeException("Depth list must be a list of integers or an expression that evaluates to a list of integers.");
                    data = a.getList();
                }

                List<Integer> depth = Streams.stream(Iterables.cycle(data)).limit(args.size()).map(a -> a.getInteger().intValueExact()).toList();

                return null;
            }

            @Override
            public int line() {
                return Depth.this.line();
            }

            @Override
            public int column() {
                return Depth.this.column();
            }
        });
    }

    @Override
    public String stringify() {
        return form.toString() + "%" + depths.toString();
    }

    @Override
    public String frameString() {
        return "%[]/syn";
    }
}
