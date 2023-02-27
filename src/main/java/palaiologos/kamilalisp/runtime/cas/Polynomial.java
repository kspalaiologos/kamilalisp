package palaiologos.kamilalisp.runtime.cas;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class Polynomial extends PrimitiveFunction implements Lambda {
    // cas:polynomial '(3 5 2 6)
    //  = 3x^3 + 5x^2 + 2x + 6
    //  = 6 + 2x + 5x^2 + 3x^3
    //  = 6 + x * (2 + x * (5 + 3 * x))
    private static final Atom x = new Atom("x", true);
    private static final Atom plus = new Atom("+", true);
    private static final Atom times = new Atom("*", true);

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        List<Atom> coefficients = args.get(0).getList();
        if (coefficients.isEmpty())
            throw new RuntimeException("Polynomial must have at least one coefficient.");
        else if (coefficients.size() == 1)
            return new Atom(List.of(coefficients.get(0)));
        LinkedHashSet<String> variables = new LinkedHashSet<>();
        variables.add("x");
        Atom result = coefficients.get(0);
        for (int i = 1; i < coefficients.size(); i++) {
            MathExpression.unknownsFrom(coefficients.get(i), variables);
            result = new Atom(List.of(plus, coefficients.get(i), new Atom(List.of(times, x, result))));
        }
        return new Atom(new MathExpression(env, variables, result));
    }

    @Override
    protected String name() {
        return "cas:polynomial";
    }
}
