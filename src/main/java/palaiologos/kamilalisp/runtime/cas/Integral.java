package palaiologos.kamilalisp.runtime.cas;

import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.List;

public class Integral extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2) {
            Atom expr = args.get(0);
            Atom var = args.get(1);
            var.assertTypes(Type.IDENTIFIER);
            String differential = var.getIdentifier().substring(1);
            if(!differential.matches("[a-zA-Z]+") || differential.isEmpty())
                throw new RuntimeException("Invalid differential.");
            String expressionCode = CasExpressionGenerator.generateExpression(env, expr);
            String instruction = "integrate(" + expressionCode + ", " + differential + ")\n";
            EvaluationResult r = (EvaluationResult) FriCAS.withFriCas(x -> {
                x.apply(")clear all\n");
                x.apply(")set output algebra off\n");
                x.apply(")set output fortran on\n");
                x.apply("digits(" + env.get("fr") + ")\n");
                return x.apply(instruction);
            });
            if(r.isSuccessful()) {
                HashPMap<Atom, Atom> a;
                try {
                    a = FortranParser.parse(r.getResult()).getUserdata(HashMapUserData.class).value();
                } catch (Exception e) {
                    if(StackFrame.isDebug())
                        throw new RuntimeException("Failed to evaluate integral (parse), command=" + instruction + ", result=" + r.getResult() + ", why=" + e.getMessage());
                    throw new RuntimeException("Failed to evaluate integral.");
                }
                if(a.size() == 0) {
                    // No solution.
                    return Atom.NULL;
                } if(a.size() == 1) {
                    // One solution.
                    Atom solution = a.entrySet().stream().findFirst().get().getValue();
                    if(solution.getType() == Type.STRING) {
                        String s = solution.getString();
                        if(s.equals("failed")) {
                            throw new RuntimeException("Failed to evaluate integral.");
                        } else {
                            throw new RuntimeException("Unknown error in evaluating the integral: " + s);
                        }
                    } else {
                        return solution;
                    }
                } else if(a.size() > 1) {
                    // More than one solution.
                    // Return a list of keys starting with T.
                    return new Atom(a.entrySet().stream().filter(x -> x.getKey().getString().startsWith("T")).map(x -> x.getValue()).toList());
                }
            } else {
                if(StackFrame.isDebug())
                    throw new RuntimeException("Failed to evaluate integral, command=" + instruction + ", result=" + r.getResult());
                throw new RuntimeException("Failed to evaluate integral.");
            }
        } else if(args.size() == 4) {
            Atom begin = Evaluation.evaluate(env, args.get(0));
            Atom end = Evaluation.evaluate(env, args.get(1));
            Atom expr = args.get(2);
            Atom var = args.get(3);
            var.assertTypes(Type.IDENTIFIER);
            String differential = var.getIdentifier().substring(1);
            if(!differential.matches("[a-zA-Z]+") || differential.isEmpty())
                throw new RuntimeException("Invalid differential.");
            String expressionCode = CasExpressionGenerator.generateExpression(env, expr);
            String beginCode = CasExpressionGenerator.generateExpression(env, begin);
            String endCode = CasExpressionGenerator.generateExpression(env, end);
            String instruction = "integrate(" + expressionCode + ", " + differential + "=beg..end)\n";
            EvaluationResult r = (EvaluationResult) FriCAS.withFriCas(x -> {
                x.apply(")clear all\n");
                x.apply(")set output algebra off\n");
                x.apply(")set output fortran on\n");
                x.apply("digits(" + env.get("fr") + ")\n");
                x.apply("beg := " + beginCode + "\n");
                x.apply("end := " + endCode + "\n");
                return x.apply(instruction);
            });
            if(r.isSuccessful()) {
                HashPMap<Atom, Atom> a;
                try {
                    a = FortranParser.parse(r.getResult()).getUserdata(HashMapUserData.class).value();
                } catch (Exception e) {
                    if(StackFrame.isDebug())
                        throw new RuntimeException("Failed to evaluate integral (parse), command=" + instruction + ", result=" + r.getResult());
                    throw new RuntimeException("Failed to evaluate integral.");
                }
                if(a.size() == 0) {
                    // No solution.
                    return Atom.NULL;
                } if(a.size() == 1) {
                    // One solution.
                    Atom solution = a.entrySet().stream().findFirst().get().getValue();
                    if(solution.getType() == Type.STRING) {
                        String s = solution.getString();
                        if(s.equals("failed")) {
                            throw new RuntimeException("Failed to evaluate integral.");
                        } else {
                            throw new RuntimeException("Unknown error in evaluating the integral: " + s);
                        }
                    } else {
                        return solution;
                    }
                } else if(a.size() > 1) {
                    // More than one solution.
                    // Return a list of keys starting with T.
                    return new Atom(a.entrySet().stream().filter(x -> x.getKey().getString().startsWith("T")).map(x -> x.getValue()).toList());
                }
            } else {
                if(StackFrame.isDebug())
                    throw new RuntimeException("Failed to evaluate integral, command=" + instruction + ", result=" + r.getResult());
                throw new RuntimeException("Failed to evaluate integral.");
            }
        } else {
            throw new RuntimeException("Invalid number of arguments.");
        }

        throw new RuntimeException("Internal error.");
    }

    @Override
    protected String name() {
        return "cas:integral";
    }
}
