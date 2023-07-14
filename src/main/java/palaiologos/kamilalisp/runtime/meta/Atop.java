package palaiologos.kamilalisp.runtime.meta;

import com.google.common.collect.Iterables;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Atop implements SpecialForm, ReactiveFunction {
    private final Atom form;
    private final List<Atom> processors;

    private final int l;
    private final int c;

    public Atop(Atom form, List<Atom> processors, int line, int col) {
        this.form = form;
        this.l = line;
        this.c = col;
        this.processors = processors;

        if (this.processors.isEmpty()) {
            throw new RuntimeException("Error on line " + l + " column " + c + ". Empty processor list.");
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
        List<Atom> processors = this.processors.stream().map(x -> Evaluation.evaluate(oldEnv, x)).toList();
        return new Atom(new Lambda() {
            @Override
            public String stringify() {
                return Atop.this.stringify();
            }

            @Override
            public String frameString() {
                return Atop.this.frameString();
            }

            @Override
            public Atom apply(Environment env, List<Atom> args) {
                if (args.isEmpty())
                    return Atom.NULL;

                // Cycle "processors" enough times to be as long as args.
                // Process all args with corresponding processors.
                List<Atom> processed = Streams.zip(args.stream(), Streams.stream(Iterables.cycle(processors)).limit(args.size()), (a, p) -> {
                    if(p.getType() == Type.CALLABLE)
                        return Evaluation.evaluate(env, p.getCallable(), List.of(a));
                    else
                        return p;
                }).toList();

                // Apply form to whatever we got.
                return Evaluation.evaluate(env, lambda, processed);
            }

            @Override
            public int line() {
                return Atop.this.line();
            }

            @Override
            public int column() {
                return Atop.this.column();
            }
        });
    }

    @Override
    public String stringify() {
        return form.toString() + "&" + processors.toString();
    }

    @Override
    public String frameString() {
        return "&[]/syn";
    }
}
