package palaiologos.kamilalisp.runtime.cas;

import com.google.common.base.Objects;
import palaiologos.kamilalisp.atom.*;

import java.util.*;

public class MathExpression implements Userdata {
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
    final LinkedHashSet<String> args;
    final Atom data;
    final Environment e;

    public MathExpression(Environment e, LinkedHashSet<String> args, Atom data) {
        this.args = args;
        this.data = data;
        this.e = e;

        args.forEach(x -> {
            if (allowedFunctions.contains(x))
                throw new RuntimeException("Identifier " + x + " is not allowed as a variable, as it denotes a function already.");
        });

        stringifyExpression(e, data);
    }

    public static LinkedHashSet<String> emptyArguments = new LinkedHashSet<>();

    public static MathExpression constantExpression(Environment env, Atom a) {
        if (a.getType() == Type.USERDATA && a.isUserdata(MathExpression.class))
            return a.getUserdata(MathExpression.class);
        return new MathExpression(env, emptyArguments, a);
    }

    public static void unknownsFrom(Atom expr, Set<String> dest) {
        if (expr.getType() == Type.USERDATA && expr.isUserdata(MathExpression.class)) {
            MathExpression me = expr.getUserdata(MathExpression.class);
            dest.addAll(me.args);
        } else if (expr.getType() == Type.LIST) {
            if (expr.getList().isEmpty())
                throw new RuntimeException("Invalid expression: " + expr);
            for (Atom a : expr.getList().subList(1, expr.getList().size()))
                unknownsFrom(a, dest);
        } else if (expr.getType() == Type.IDENTIFIER) {
            dest.add(expr.getIdentifier());
        } else if (!expr.isNumeric()) {
            throw new RuntimeException("Invalid expression: " + expr);
        }
    }

    public LinkedHashSet<String> getArgs() {
        return args;
    }
    
    public Atom getData() {
        return data;
    }

    private Atom expandIdentifiers(Environment e, Atom tree) {
        if (tree.getType() == Type.IDENTIFIER) {
            String id = tree.getIdentifier();
            if (id.startsWith("`")) {
                if (!e.has(id.substring(1)))
                    throw new RuntimeException("Unknown identifier: " + id.substring(1));
                return expandIdentifiers(e, e.get(id.substring(1)));
            }
            return tree;
        } else if(tree.getType() == Type.LIST) {
            return new Atom(tree.getList().stream().map(x -> expandIdentifiers(e, x)).toList());
        } else {
            return tree;
        }
    }

    private String stringifyExpression(Environment e, Atom tree) {
        if (tree.getType() == Type.IDENTIFIER) {
            String id = tree.getIdentifier();
            switch (id) {
                case "pi" -> {
                    return "%pi";
                }
                case "e" -> {
                    return "exp(1)";
                }
                case "oo" -> {
                    return "%plusInfinity";
                }
                case "-oo" -> {
                    return "%minusInfinity";
                }
                default -> {
                    if (!id.matches("[a-zA-Z]+"))
                        throw new RuntimeException("Invalid identifier: " + id);
                    if (!args.contains(id))
                        throw new RuntimeException("Unbound identifier: " + id);
                    return id;
                }
            }
        } else if (tree.getType() == Type.REAL) {
            return tree.getReal().toString();
        } else if (tree.getType() == Type.INTEGER) {
            return tree.getInteger().toString();
        } else if (tree.getType() == Type.COMPLEX) {
            String re = tree.getComplex().re.toString();
            String im = tree.getComplex().im.toString();
            return re + "+(" + im + "*%i)";
        } else if (tree.getType() == Type.LIST) {
            Atom head = tree.getList().get(0);
            if (head.getType() != Type.IDENTIFIER) {
                throw new RuntimeException("Invalid function call.");
            }
            String id = head.getIdentifier();
            switch (id) {
                case "+" -> {
                    if (tree.getList().size() == 1)
                        throw new RuntimeException("Invalid arity for function: +");
                    if (tree.getList().size() == 2)
                        return "conj(" + stringifyExpression(e, tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(x -> stringifyExpression(e, x)).reduce((x, y) -> "((" + x + ")+(" + y + "))").get();
                }
                case "-" -> {
                    if (tree.getList().size() == 1)
                        throw new RuntimeException("Invalid arity for function: -");
                    if (tree.getList().size() == 2)
                        return "-(" + stringifyExpression(e, tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(x -> stringifyExpression(e, x)).reduce((x, y) -> "((" + x + ")-(" + y + "))").get();
                }
                case "*" -> {
                    if (tree.getList().size() == 1)
                        throw new RuntimeException("Invalid arity for function: *");
                    if (tree.getList().size() == 2)
                        return "signum(" + stringifyExpression(e, tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(x -> stringifyExpression(e, x)).reduce((x, y) -> "((" + x + ")*(" + y + "))").get();
                }
                case "/" -> {
                    if (tree.getList().size() == 1)
                        throw new RuntimeException("Invalid arity for function: /");
                    if (tree.getList().size() == 2)
                        return "1/(" + stringifyExpression(e, tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(x -> stringifyExpression(e, x)).reduce((x, y) -> "((" + x + ")/(" + y + "))").get();
                }
                case "**" -> {
                    if (tree.getList().size() <= 2)
                        throw new RuntimeException("Invalid arity for function: **");
                    return tree.getList().stream().skip(1).map(x -> stringifyExpression(e, x)).reduce((x, y) -> "((" + x + ")^(" + y + "))").get();
                }
                case "pi" -> {
                    if (tree.getList().size() == 1)
                        return "%pi";
                    else if (tree.getList().size() == 2)
                        return "(%pi*(" + stringifyExpression(e, tree.getList().get(1)) + "))";
                    else
                        throw new RuntimeException("Invalid arity for function: gamma");
                }
                case "e" -> {
                    if (tree.getList().size() == 1)
                        return "exp(1)";
                    else if (tree.getList().size() == 2)
                        return "(exp(1)*(" + stringifyExpression(e, tree.getList().get(1)) + "))";
                    else
                        throw new RuntimeException("Invalid arity for function: gamma");
                }
                case "o" -> {
                    return "0";
                }
                case "gamma" -> {
                    if (tree.getList().size() == 2)
                        return "gamma(" + stringifyExpression(e, tree.getList().get(1)) + ")";
                    else if (tree.getList().size() == 3)
                        return "gamma(" + stringifyExpression(e, tree.getList().get(1)) + "," + stringifyExpression(e, tree.getList().get(2)) + ")";
                    else
                        throw new RuntimeException("Invalid arity for function: gamma");
                }
                default -> {
                    if (allowedFunctions.contains(id)) {
                        if (tree.getList().size() - 1 != expectedArities.get(id))
                            throw new RuntimeException("Invalid arity for function: " + id);
                        if (primitiveTranslations.containsKey(id))
                            id = primitiveTranslations.get(id);
                        return id + "(" + tree.getList().stream().skip(1).map(x -> stringifyExpression(e, x)).reduce((x, y) -> x + "," + y).get() + ")";
                    } else if(e.has(id)) {
                        if(e.get(id).getType() != Type.USERDATA || !(e.get(id).getUserdata() instanceof MathExpression))
                            throw new RuntimeException("Invalid function: " + id);
                        MathExpression f = e.get(id).getUserdata(MathExpression.class);
                        if(f.args.size() != tree.getList().size() - 1)
                            throw new RuntimeException("Invalid arity for function: " + id);
                        int i = 0;
                        Atom expr = f.data;
                        for(String arg : f.args) {
                            expr = substituteRecursively(expr, arg, expandIdentifiers(e, tree.getList().get(i + 1)));
                            i++;
                        }
                        return stringifyExpression(f.e, expr);
                    } else {
                        throw new RuntimeException("Unknown function: " + id);
                    }
                }
            }
        } else {
            throw new RuntimeException("Invalid expression. Unexpected component of type " + tree.getType());
        }
    }

    public Atom force() {
        if (!args.isEmpty())
            throw new IllegalArgumentException("The function is not constant.");
        return Evaluation.evaluate(e, data);
    }

    public String getExpression() {
        return stringifyExpression(e, data);
    }

    @Override
    public Atom field(Object key) {
        if (!(key instanceof String keyStr))
            throw new RuntimeException("Invalid key type: " + key.getClass().getName());
        if (!args.contains(keyStr))
            throw new RuntimeException("Invalid argument: " + keyStr);
        return new Atom(new MathExpressionSubstitute(keyStr));
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(args, data);
    }

    @Override
    public int compareTo(Userdata other) {
        return hashCode() - other.hashCode();
    }

    @Override
    public boolean equals(Userdata other) {
        if (!(other instanceof MathExpression otherExpr))
            return false;
        return stringifyExpression(e, data).equals(otherExpr.stringifyExpression(otherExpr.e, otherExpr.data));
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

    private Atom substituteRecursively(Atom data, String key, Atom sub) {
        if (data.getType() == Type.IDENTIFIER) {
            if (data.getIdentifier().equals(key))
                return sub;
            else
                return data;
        } else if (data.getType() == Type.LIST) {
            List<Atom> newList = new ArrayList<>();
            for (Atom a : data.getList())
                newList.add(substituteRecursively(a, key, sub));
            return new Atom(newList);
        } else {
            return data;
        }
    }

    private class MathExpressionSubstitute extends PrimitiveFunction implements Lambda {
        private final String keyStr;

        public MathExpressionSubstitute(String keyStr) {
            this.keyStr = keyStr;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            LinkedHashSet<String> variables = new LinkedHashSet<>();
            unknownsFrom(args.get(0), variables);
            MathExpression me = new MathExpression(env, variables, args.get(0));
            Atom result = substituteRecursively(MathExpression.this.data, keyStr, me.data);
            LinkedHashSet<String> returnVariables = new LinkedHashSet<>();
            unknownsFrom(result, returnVariables);
            return new Atom(new MathExpression(env, returnVariables, result));
        }

        @Override
        protected String name() {
            return "cas:function." + keyStr;
        }
    }
}
