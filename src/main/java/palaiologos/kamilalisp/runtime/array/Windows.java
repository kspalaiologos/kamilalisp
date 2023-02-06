package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.List;

public class Windows extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2) {
            int windowSize = args.get(0).getInteger().intValueExact();
            if (windowSize < 1) {
                throw new TypeError("Window size must be a positive non-zero number");
            }
            if (args.get(1).getType() == Type.LIST) {
                List<Atom> data = args.get(1).getList();
                if (windowSize >= data.size()) {
                    return args.get(1);
                }
                List<Atom> windows = new ArrayList<>();
                for (int i = 0; i < data.size() - windowSize + 1; i++) {
                    windows.add(new Atom(data.subList(i, i + windowSize)));
                }
                return new Atom(windows);
            } else if (args.get(1).getType() == Type.STRING) {
                String data = args.get(1).getString();
                if (windowSize >= data.length()) {
                    return args.get(1);
                }
                List<Atom> windows = new ArrayList<>();
                for (int i = 0; i < data.length() - windowSize + 1; i++) {
                    windows.add(new Atom(data.substring(i, i + windowSize)));
                }
                return new Atom(windows);
            } else {
                throw new TypeError("windows can only be applied to lists or strings");
            }
        } else if (args.size() == 3) {
            int windowSize = args.get(0).getInteger().intValueExact();
            Callable functor = args.get(1).getCallable();
            if (windowSize < 1) {
                throw new TypeError("Window size must be a positive non-zero number");
            }
            if (args.get(2).getType() == Type.LIST) {
                List<Atom> data = args.get(2).getList();
                if (windowSize >= data.size()) {
                    return Evaluation.evaluate(env, functor, List.of(args.get(2)));
                }
                List<Atom> windows = new ArrayList<>();
                for (int i = 0; i < data.size() - windowSize + 1; i++) {
                    windows.add(Evaluation.evaluate(env, functor, List.of(new Atom(data.subList(i, i + windowSize)))));
                }
                return new Atom(windows);
            } else if (args.get(2).getType() == Type.STRING) {
                String data = args.get(2).getString();
                if (windowSize >= data.length()) {
                    return Evaluation.evaluate(env, functor, List.of(args.get(2)));
                }
                List<Atom> windows = new ArrayList<>();
                for (int i = 0; i < data.length() - windowSize + 1; i++) {
                    windows.add(Evaluation.evaluate(env, functor, List.of(new Atom(data.substring(i, i + windowSize)))));
                }
                return new Atom(windows);
            } else {
                throw new TypeError("windows can only be applied to lists or strings");
            }
        } else {
            throw new TypeError("windows takes 2 or 3 arguments");
        }
    }

    @Override
    protected String name() {
        return "windows";
    }
}
