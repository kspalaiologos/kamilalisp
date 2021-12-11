package kamilalisp.libs;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import kamilalisp.data.*;
import kamilalisp.libs.primitives.math.Add;
import kamilalisp.libs.primitives.math.Derivative;
import kamilalisp.libs.primitives.math.Product;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

public class SymLib {
    public static void install(Environment env) {
        env.push("D", new Atom(new Derivative()));
        // (nabla '(x y z) f) returns a function that yields the gradient vector of f given an argument.
        env.push("nabla", new Atom(new Closure() {
            Derivative derivativeEngine = new Derivative();

            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'nabla'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'nabla'", Type.LIST);
                    arguments.get(1).guardType("Second argument to 'nabla'", Type.CLOSURE);
                    List<Atom> variables = arguments.get(0).getList().get();
                    // Differentiate arg1 with respect to `variables'.
                    List<Atom> fns = variables.stream().map(x -> derivativeEngine.deriv(env, arguments.get(1).getClosure().get(), x.getString().get())).collect(Collectors.toList());
                    return new Closure() {
                        @Override
                        public String representation() {
                            return "∇f" + fns;
                        }

                        @Override
                        public Atom apply(Executor env, List<Atom> arguments) {
                            if(arguments.size() != variables.size())
                                throw new Error("Invalid invocation to 'nabla' gradient vector function.");
                            return new Atom(new LbcSupplier<>(() ->
                                fns.stream().map(x -> x.getClosure().get().apply(env, arguments)).collect(Collectors.toList())
                            ));
                        }
                    };
                }));
            }
        }));
    }
}
