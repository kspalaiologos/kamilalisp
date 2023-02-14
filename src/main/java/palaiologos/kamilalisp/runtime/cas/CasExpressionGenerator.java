package palaiologos.kamilalisp.runtime.cas;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Type;

import java.util.Map;
import java.util.Set;

public class CasExpressionGenerator {
    private static Set<String> allowedFunctions = Set.of(
            "sin", "cos", "tan", "cot", "asin", "acos", "atan", "acot",
            "exp", "ln", "log2", "log10"
    );

    private static Map<String, Integer> expectedArities = Map.ofEntries(
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
            Map.entry("log10", 1)
    );

    private static Map<String, String> primitiveTranslations = Map.ofEntries(
            Map.entry("ln", "log")
    );

    public static String generateExpression(Environment e, Atom tree) {
        if(tree.getType() == Type.IDENTIFIER) {
            String id = tree.getIdentifier();
            if(id.startsWith("`")) {
                if(!e.has(id.substring(1)))
                    throw new RuntimeException("Unknown identifier: " + id.substring(1));
                return "(" + generateExpression(e, e.get(id.substring(1))) + ")";
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
                    if(tree.getList().size() == 2)
                        return "conj(" + generateExpression(e, tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")+(" + y + "))").get();
                case "-":
                    if(tree.getList().size() == 2)
                        return "-(" + generateExpression(e, tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")-(" + y + "))").get();
                case "*":
                    if(tree.getList().size() == 2)
                        return "signum(" + generateExpression(e, tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")*(" + y + "))").get();
                case "/":
                    if(tree.getList().size() == 2)
                        return "1/(" + generateExpression(e, tree.getList().get(1)) + ")";
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")/(" + y + "))").get();
                case "**":
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")^(" + y + "))").get();
                case "pi":
                    return "%pi";
                case "e":
                    return "exp(1)";
                default:
                    if(allowedFunctions.contains(id)) {
                        if(tree.getList().size() - 1 != expectedArities.get(id))
                            throw new RuntimeException("Invalid arity for function: " + id);
                        if(primitiveTranslations.containsKey(id))
                            id = primitiveTranslations.get(id);
                        return id + "(" + tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> x + "," + y).get() + ")";
                    } else {
                        throw new RuntimeException("Unknown function: " + id);
                    }
            }
        } else {
            throw new RuntimeException("Invalid expression. Unexpected component of type " + tree.getType());
        }
    }
}
