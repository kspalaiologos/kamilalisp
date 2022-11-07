package palaiologos.kamilalisp.atom;

import palaiologos.kamilalisp.error.TypeError;

import javax.annotation.Nonnull;
import java.util.List;
import java.util.function.Function;

public class Evaluation {
    @Nonnull
    public static Atom evaluate(Environment env, Atom atom) {
        switch(atom.getType()) {
            case STRING: case REAL: case COMPLEX: case INTEGER:
                return atom;
            case CALLABLE:
                return atom;
            case LIST:
                if(atom.getList().get(0) instanceof CodeAtom) {
                    StackFrame.push((CodeAtom) atom.getList().get(0));
                }
                Atom head = evaluate(env, atom.getList().get(0));
                if(head.getType() != Type.CALLABLE) {
                    throw new TypeError("Cannot call non-callable atom");
                }
                Callable c = head.getCallable();
                Atom result;
                if(c instanceof Lambda) {
                    result = evaluate(env, c, atom.getList().stream().skip(1).map(x -> evaluate(env, x)).toList());
                } else if(c instanceof Macro) {
                    result = evaluate(env, evaluate(env, c, atom.getList().subList(1, atom.getList().size())));
                } else if(c instanceof SpecialForm) {
                    result = evaluate(env, c, atom.getList().subList(1, atom.getList().size()));
                } else {
                    throw new RuntimeException("Unknown callable type: " + c.getClass().getName());
                }
                if(atom.getList().get(0) instanceof CodeAtom) {
                    StackFrame.pop();
                }
                return result;
            case IDENTIFIER:
                if(env.has(Identifier.of(atom.getIdentifier())))
                    return env.get(Identifier.of(atom.getIdentifier()));
                else
                    return atom;
        }

        throw new RuntimeException("Unknown atom type: " + atom.getType());
    }

    @Nonnull
    public static Atom safeEvaluate(Environment env, Atom atom, Function<String, Atom> exceptionHandler) {
        switch(atom.getType()) {
            case STRING: case REAL: case COMPLEX: case INTEGER:
                return atom;
            case CALLABLE:
                return atom;
            case LIST:
                int depth = StackFrame.depth();
                try {
                    if (atom.getList().get(0) instanceof CodeAtom) {
                        StackFrame.push((CodeAtom) atom.getList().get(0));
                    }
                    Atom head = evaluate(env, atom.getList().get(0));
                    if(head.getType() != Type.CALLABLE) {
                        throw new TypeError("Cannot call non-callable atom");
                    }
                    Callable c = head.getCallable();
                    Atom result;
                    if (c instanceof Lambda) {
                        result = evaluate(env, c, atom.getList().stream().skip(1).map(x -> evaluate(env, x)).toList());
                    } else if (c instanceof Macro) {
                        result = evaluate(env, evaluate(env, c, atom.getList().subList(1, atom.getList().size())));
                    } else if (c instanceof SpecialForm) {
                        result = evaluate(env, c, atom.getList().subList(1, atom.getList().size()));
                    } else {
                        throw new RuntimeException("Unknown callable type: " + c.getClass().getName());
                    }
                    if (atom.getList().get(0) instanceof CodeAtom) {
                        StackFrame.pop();
                    }
                    return result;
                } catch(Throwable t) {
                    String trace = StackFrame.stackTrace(t);
                    while(StackFrame.depth() > depth)
                        StackFrame.pop();
                    return exceptionHandler.apply(trace);
                }
            case IDENTIFIER:
                if(env.has(Identifier.of(atom.getIdentifier())))
                    return env.get(Identifier.of(atom.getIdentifier()));
                else
                    return atom;
        }

        throw new RuntimeException("Unknown atom type: " + atom.getType());
    }

    public static Atom evaluate(Environment env, Callable c, List<Atom> args) {
        StackFrame.push(c);
        Atom r = c.apply(env, args);
        StackFrame.pop();
        return r;
    }

    public static Atom safeEvaluate(Environment env, Callable c, List<Atom> args, Function<String, Atom> exceptionHandler) {
        int depth = StackFrame.depth();
        try {
            StackFrame.push(c);
            Atom r = c.apply(env, args);
            StackFrame.pop();
            return r;
        } catch (Throwable t) {
            String trace = StackFrame.stackTrace(t);
            while(StackFrame.depth() > depth)
                StackFrame.pop();
            return exceptionHandler.apply(trace);
        }
    }
}
