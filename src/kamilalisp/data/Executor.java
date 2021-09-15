package kamilalisp.data;

import java.util.List;
import java.util.stream.Collectors;

public class Executor {
    public Environment env;

    public Executor(Environment env) {
        this.env = env;
    }

    public Atom evaluate(Atom a) {
        return evaluate(a, true);
    }

    public Atom evaluate(Atom a, boolean eval_params) {
        if(a.getType() != Type.LIST && a.getType() != Type.STRING)
            return a;
        if(a.getType() == Type.STRING) {
            String key = a.getString().get();

            if(env.has(key))
                return env.get(key);
            return a;
        }
        List<Atom> sexpr = a.getList().get();
        if(sexpr.size() == 0)
            throw new Error("Attempted to evaluate an empty s-expression.");
        Atom head = evaluate(sexpr.get(0));
        switch(head.getType()) {
            case CLOSURE:
                if(eval_params)
                    return head.getClosure().get().apply(this, sexpr.stream().skip(1).map(x -> evaluate(x)).collect(Collectors.toList()));
                else
                    return head.getClosure().get().apply(this, sexpr.stream().skip(1).collect(Collectors.toList()));
            case MACRO:
                return head.getMacro().get().apply(this, sexpr.stream().skip(1).collect(Collectors.toList()));
            default:
                throw new Error("Can't evaluate a list with head of type " + head.getType().name() + " - '" + head + "'.");
        }
    }
}
