package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class ParitalApplication implements SpecialForm, ReactiveFunction {
    private final Atom bindData;
    private final int l;
    private final int c;

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    public class PartiallyAppliedThunk implements Lambda {
        private List<Atom> data;

        public PartiallyAppliedThunk(List<Atom> data) {
            this.data = data;
        }

        @Override
        public String stringify() {
            return ParitalApplication.this.stringify();
        }

        @Override
        public String frameString() {
            return ParitalApplication.this.frameString();
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            int consumedArgs = 0;
            for (int i = 0; i < data.size(); i++) {
                if (data.get(i).getType() == Type.IDENTIFIER && Identifier.of(data.get(i).getIdentifier()).equals("_"))
                    data.set(i, new Atom(new Quote(Evaluation.evaluate(env, args.get(consumedArgs++)), l, c)));
                if (consumedArgs == args.size() && i != data.size() - 1) {
                    // Not all arguments bound. Automatically curry the function.
                    return new Atom(new PartiallyAppliedThunk(data));
                }
            }
            List<Atom> evaluatedData = new ArrayList<>(data);
            // 2: Append the remaining args.
            if (consumedArgs != args.size())
                for (Atom a : args.subList(consumedArgs, args.size()))
                    evaluatedData.add(new Atom(new Quote(a, l, c)));
            return Evaluation.evaluate(env, new Atom(evaluatedData));
        }

        @Override
        public int line() {
            return ParitalApplication.this.line();
        }

        @Override
        public int column() {
            return ParitalApplication.this.column();
        }
    }

    public ParitalApplication(Atom bindingData, int l, int c) {
        this.bindData = bindingData;
        this.l = l;
        this.c = c;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // 1: Replace placeholders.
        List<Atom> data = new ArrayList<>(bindData.getList());
        for(int i = 0; i < data.size(); i++) {
            if (data.get(i).getType() != Type.IDENTIFIER || !Identifier.of(data.get(i).getIdentifier()).equals("_"))
                data.set(i, new Atom(new Quote(Evaluation.evaluate(env, data.get(i)), l, c)));
        }
        return new Atom(new PartiallyAppliedThunk(data));
    }

    @Override
    public String stringify() {
        return "$" + bindData.toString();
    }

    @Override
    public String frameString() {
        return "$/syn";
    }
}
