package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class ParitalApplication implements SpecialForm, ReactiveFunction {
    private final Atom bindData;
    private final int l;
    private final int c;

    public ParitalApplication(Atom bindingData, int l, int c) {
        this.bindData = bindingData;
        this.l = l;
        this.c = c;
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
        // 1: Replace placeholders.
        List<Atom> data = new ArrayList<>(bindData.getList());
        int varSlots = 0;
        for (int i = 0; i < data.size(); i++) {
            if (data.get(i).getType() != Type.IDENTIFIER || !Identifier.of(data.get(i).getIdentifier()).equals("_"))
                data.set(i, new Atom(new Quote(Evaluation.evaluate(env, data.get(i)), l, c)));
            else
                varSlots++;
        }
        return new Atom(new PartiallyAppliedThunk(varSlots, data));
    }

    @Override
    public String stringify() {
        return "$" + bindData.toString();
    }

    @Override
    public String frameString() {
        return "$/syn";
    }

    public class PartiallyAppliedThunk implements Lambda {
        private final List<Atom> data;
        private final int varSlots;

        PartiallyAppliedThunk(int varSlots, List<Atom> data) {
            this.data = data;
            this.varSlots = varSlots;
        }

        @Override
        public String stringify() {
            return "$" + data.toString();
        }

        @Override
        public String frameString() {
            return ParitalApplication.this.frameString();
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            List<Atom> evaluatedData = new ArrayList<>(data);
            int consumedArgs = 0;
            for (int i = 0; i < evaluatedData.size(); i++) {
                if (evaluatedData.get(i).getType() == Type.IDENTIFIER && Identifier.of(evaluatedData.get(i).getIdentifier()).equals("_"))
                    evaluatedData.set(i, new Atom(new Quote(Evaluation.evaluate(env, args.get(consumedArgs++)), l, c)));
                if (consumedArgs == args.size() && consumedArgs < varSlots) {
                    // Not all arguments bound. Automatically curry the function.
                    return new Atom(new PartiallyAppliedThunk(varSlots - consumedArgs, evaluatedData));
                }
            }
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
}
