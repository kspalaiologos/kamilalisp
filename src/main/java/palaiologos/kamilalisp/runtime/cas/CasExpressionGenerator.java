package palaiologos.kamilalisp.runtime.cas;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Type;

import java.util.Map;
import java.util.Set;

public class CasExpressionGenerator {
    private static Set<String> allowedFunctions = Set.of(
            "sin"
    );

    private static Map<String, Integer> expectedArities = Map.of(
            "sin", 1
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
                return "%e";
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
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")+(" + y + "))").get();
                case "-":
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")-(" + y + "))").get();
                case "*":
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")*(" + y + "))").get();
                case "/":
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")/(" + y + "))").get();
                case "**":
                    return tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> "((" + x + ")^(" + y + "))").get();
                default:
                    if(allowedFunctions.contains(id)) {
                        if(tree.getList().size() - 1 != expectedArities.get(id))
                            throw new RuntimeException("Invalid arity for function: " + id);
                        return id + "(" + tree.getList().stream().skip(1).map(x -> generateExpression(e, x)).reduce((x, y) -> x + "," + y).get() + ")";
                    } else {
                        throw new RuntimeException("Unknown function: " + id);
                    }
            }
        } else {
            throw new RuntimeException("Invalid expression. Unexpected component of type " + tree.getType());
        }

        throw new RuntimeException("Internal error.");
    }
}
