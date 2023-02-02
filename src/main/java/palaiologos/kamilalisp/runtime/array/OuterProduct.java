package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;
import java.util.function.BiFunction;
import java.util.stream.Collectors;

public class OuterProduct extends PrimitiveFunction implements Lambda {
    private static Tie tie = new Tie();

    static <T, R> List<List<R>> op(BiFunction<T, T, R> f, List<T> a, List<T> b) {
        List<List<R>> results = new ArrayList<>();
        for (T x : a) {
            List<R> result = new ArrayList<>();
            for (T y : b) {
                result.add(f.apply(x, y));
            }
            results.add(result);
        }
        return results;
    }

    public static Atom op2(Callable fn, Environment env, Atom a, Atom b) {
        if (a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(op((x, y) -> fn.apply(env, List.of(x, y)), a.getList(), b.getList()).stream().map(Atom::new).toList());
        } else if (a.getType() == Type.STRING && b.getType() == Type.STRING) {
            return new Atom(op(
                    (x, y) -> fn.apply(env, List.of(new Atom(String.valueOf(x)), new Atom(String.valueOf(y)))),
                    a.getString().chars().mapToObj(x -> (char) x).toList(),
                    b.getString().chars().mapToObj(x -> (char) x).toList()
            ).stream().map(x -> new Atom(x.stream().map(Object::toString).collect(Collectors.joining()))).toList());
        } else if (a.getType() == Type.LIST && b.getType() != Type.LIST) {
            return new Atom(op((x, y) -> fn.apply(env, List.of(x, y)), a.getList(), List.of(b)).stream().map(Atom::new).toList());
        } else if (a.getType() != Type.LIST && b.getType() == Type.LIST) {
            return new Atom(op((x, y) -> fn.apply(env, List.of(x, y)), List.of(a), b.getList()).stream().map(Atom::new).toList());
        } else {
            return new Atom(List.of(a, b));
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() <= 1) {
            throw new TypeError("outer-product called with too few arguments.");
        }

        if(args.get(0).getType() == Type.CALLABLE) {
            if(args.size() <= 2) {
                throw new TypeError("outer-product called with too few arguments.");
            }

            return args.stream().skip(1).reduce((x, y) -> op2(args.get(0).getCallable(), env, x, y)).get();
        } else {
            return args.stream().reduce((x, y) -> op2(tie, env, x, y)).get();
        }
    }

    @Override
    protected String name() {
        return "outer-product";
    }
}
