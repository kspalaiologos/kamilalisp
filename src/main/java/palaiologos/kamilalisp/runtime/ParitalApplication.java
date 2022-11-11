package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class ParitalApplication implements SpecialForm {
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

    public ParitalApplication(Atom bindingData, int l, int c) {
        this.bindData = bindingData;
        this.l = l;
        this.c = c;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        // 1: Replace placeholders.
        List<Atom> data = new ArrayList<>(bindData.getList());
        int consumedArgs = 0;
        for (int i = 0; i < data.size(); i++) {
            if (data.get(i).getType() == Type.IDENTIFIER && Identifier.of(data.get(i).getIdentifier()).equals("_"))
                data.set(i, new Atom(new Quote(args.get(consumedArgs++), l, c)));
            if (consumedArgs == args.size() && i != data.size() - 1) {
                // Not all arguments bound. Automatically curry the function.
                return new Atom(new ParitalApplication(new Atom(data), l, c));
            }
        }
        // 2: Append the remaining args.
        if (consumedArgs != args.size())
            for (Atom a : args.subList(consumedArgs, args.size()))
                data.add(new Atom(new Quote(a, l, c)));
        return Evaluation.evaluate(env, new Atom(data));
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
