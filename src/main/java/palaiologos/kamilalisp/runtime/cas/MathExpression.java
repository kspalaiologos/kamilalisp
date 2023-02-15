package palaiologos.kamilalisp.runtime.cas;

import com.google.common.base.Objects;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Type;
import palaiologos.kamilalisp.atom.Userdata;

import java.util.List;
import java.util.Map;
import java.util.Set;

public class MathExpression implements Userdata {
    private final Set<String> args;
    private final Atom data;
    private final Environment e;
    private final String expressionCache;

    public MathExpression(Environment e, Set<String> args, Atom data) {
        this.args = args;
        this.data = data;
        this.e = e;

        expressionCache = stringifyExpression(data);
    }

    public Set<String> getArgs() {
        return args;
    }

    private static final Set<String> allowedFunctions = Set.of(
            "sin", "cos", "tan", "cot", "asin", "acos", "atan", "acot",
            "exp", "ln", "log2", "log10", "sqrt", "sec", "csc", "asec", "acsc",
            "dilog", "polylog"
    );

    private static final Map<String, Integer> expectedArities = Map.ofEntries(
            Map.entry("sin", 1),
            Map.entry("cos", 1),
            Map.entry("tan", 1),
            Map.entry("cot", 1),
            Map.entry("asin", 1),
            Map.entry("acos", 1),
            Map.entry("atan", 1),
            Map.entry("acot", 1),
            Map.entry("exp", 1),
            Map.entry("ln", 1),
            Map.entry("log2", 1),
            Map.entry("log10", 1),
            Map.entry("sqrt", 1),
            Map.entry("sec", 1),
            Map.entry("csc", 1),
            Map.entry("asec", 1),
            Map.entry("acsc", 1),
            Map.entry("dilog", 1),
            Map.entry("polylog", 2)
    );

    private static final Map<String, String> primitiveTranslations = Map.ofEntries(
            Map.entry("ln", "log")
    );

    private String stringifyExpression(Atom tree) {
        if(tree.getType() == Type.IDENTIFIER) {
            String id = tree.getIdentifier();
            if(id.startsWith("`")) {
                if(!e.has(id.substring(1)))
                    throw new RuntimeException("Unknown identifier: " + id.substring(1));
                return "(" + stringifyExpression(e.get(id.substring(1))) + ")";
            } else if(id.equals("pi")) {
                return "%pi";
            } else if(id.equals("e")) {
                return "exp(1)";
            } else if(id.equals("oo")) {
                return "%plusInfinity";
            } else if(id.equals("-oo")) {
                return "%minusInfinity";
            } else {
                if(!id.matches("[a-zA-Z]+"))
                    throw new RuntimeException("Invalid identifier: " + id);
                if(!args.contains(id))
                    throw new RuntimeException("Unbound identifier: " + id);
                return id;
            }
        } else if(tree.getType() == Type.REAL) {
            return tree.getReal().toString();
        } else if (tree.getType() == Type.INTEGER) {
            return tree.getInteger().toString();
        } else if(tree.getType() == Type.COMPLEX) {
            String re = tree.getComplex().re.toString();
            String im = tree.getComplex().im.toString();
            return re + "+(" + im + "*%i)";
        } else if(tree.getType() == Type.LIST) {
            Atom head = tree.getList().get(0);
            if(head.getType() != Type.IDENTIFIER) {
                throw new RuntimeException("Invalid function call.");
            }
            String id = head.getIdentifier();
            switch(id) {
                case "+":
                    if(tree.getList().size() == 1)
                        throw new RuntimeException("Invalid arity for function: +");
                    if(tree.getList().size() == 2)
                        return "conj(" + stringifyExpression(tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(this::stringifyExpression).reduce((x, y) -> "((" + x + ")+(" + y + "))").get();
                case "-":
                    if(tree.getList().size() == 1)
                        throw new RuntimeException("Invalid arity for function: -");
                    if(tree.getList().size() == 2)
                        return "-(" + stringifyExpression(tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(this::stringifyExpression).reduce((x, y) -> "((" + x + ")-(" + y + "))").get();
                case "*":
                    if(tree.getList().size() == 1)
                        throw new RuntimeException("Invalid arity for function: *");
                    if(tree.getList().size() == 2)
                        return "signum(" + stringifyExpression(tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(this::stringifyExpression).reduce((x, y) -> "((" + x + ")*(" + y + "))").get();
                case "/":
                    if(tree.getList().size() == 1)
                        throw new RuntimeException("Invalid arity for function: /");
                    if(tree.getList().size() == 2)
                        return "1/(" + stringifyExpression(tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(this::stringifyExpression).reduce((x, y) -> "((" + x + ")/(" + y + "))").get();
                case "**":
                    if(tree.getList().size() <= 2)
                        throw new RuntimeException("Invalid arity for function: **");
                    return tree.getList().stream().skip(1).map(this::stringifyExpression).reduce((x, y) -> "((" + x + ")^(" + y + "))").get();
                case "pi":
                    if(tree.getList().size() == 1)
                        return "%pi";
                    else if(tree.getList().size() == 2)
                        return "(%pi*(" + stringifyExpression(tree.getList().get(1)) + "))";
                    else
                        throw new RuntimeException("Invalid arity for function: gamma");
                case "e":
                    if(tree.getList().size() == 1)
                        return "exp(1)";
                    else if(tree.getList().size() == 2)
                        return "(exp(1)*(" + stringifyExpression(tree.getList().get(1)) + "))";
                    else
                        throw new RuntimeException("Invalid arity for function: gamma");
                case "gamma":
                    if(tree.getList().size() == 2)
                        return "gamma(" + stringifyExpression(tree.getList().get(1)) + ")";
                    else if(tree.getList().size() == 3)
                        return "gamma(" + stringifyExpression(tree.getList().get(1)) + "," + stringifyExpression(tree.getList().get(2)) + ")";
                    else
                        throw new RuntimeException("Invalid arity for function: gamma");
                default:
                    if(allowedFunctions.contains(id)) {
                        if(tree.getList().size() - 1 != expectedArities.get(id))
                            throw new RuntimeException("Invalid arity for function: " + id);
                        if(primitiveTranslations.containsKey(id))
                            id = primitiveTranslations.get(id);
                        return id + "(" + tree.getList().stream().skip(1).map(this::stringifyExpression).reduce((x, y) -> x + "," + y).get() + ")";
                    } else {
                        throw new RuntimeException("Unknown function: " + id);
                    }
            }
        } else {
            throw new RuntimeException("Invalid expression. Unexpected component of type " + tree.getType());
        }
    }

    public String getExpression() {
        return expressionCache;
    }

    @Override
    public Atom field(Object key) {
        return null;
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(expressionCache, args, data);
    }

    @Override
    public int compareTo(Userdata other) {
        return hashCode() - other.hashCode();
    }

    @Override
    public boolean equals(Userdata other) {
        if(!(other instanceof MathExpression otherExpr))
            return false;
        return expressionCache.equals(otherExpr.expressionCache);
    }

    @Override
    public String toDisplayString() {
        return "ƒ(" + args.stream().reduce((x, y) -> x + "," + y).orElse("") + ")=" + data.toString();
    }

    @Override
    public String toString() {
        return toDisplayString();
    }

    @Override
    public String typeName() {
        return "cas:function";
    }

    @Override
    public boolean coerceBoolean() {
        return true;
    }
}
