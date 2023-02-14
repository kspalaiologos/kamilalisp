package palaiologos.kamilalisp.runtime.cas;

import com.google.common.collect.Streams;
import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class ComplexIntegral extends Integral {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2 || args.size() == 3) {
            Atom expr = args.get(0);
            Atom var = args.get(1);
            HashPMap<Atom, Atom> options = env.has("cas-options") ? env.get("cas-options").getUserdata(HashMapUserData.class).value() : HashTreePMap.from(new HashMap<Atom, Atom>());
            var.assertTypes(Type.IDENTIFIER);
            String differential = var.getIdentifier().substring(1);
            if(!differential.matches("[a-zA-Z]+") || differential.isEmpty())
                throw new RuntimeException("Invalid differential.");
            String expressionCode = CasExpressionGenerator.generateExpression(env, expr);
            String instruction = "complexIntegrate(" + expressionCode + ", " + differential + ")\n";
            EvaluationResult r = (EvaluationResult) FriCAS.withFriCas(x -> {
                x.apply(")clear all\n");
                x.apply(")set output algebra off\n");
                if(options.getOrDefault(tex, Atom.FALSE).equals(Atom.TRUE)) {
                    x.apply(")set output fortran off\n");
                    x.apply(")set output tex on\n");
                } else {
                    x.apply(")set output tex off\n");
                    x.apply(")set output fortran on\n");
                }
                x.apply("digits(" + env.get("fr") + ")\n");
                return x.apply(instruction);
            });
            if(r.isSuccessful()) {
                if(options.getOrDefault(tex, Atom.FALSE).equals(Atom.TRUE)) {
                    return new Atom(r.getResult());
                }
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
                } else {
                    // More than one solution.
                    return processSolution(a);
                }
            } else {
                if(StackFrame.isDebug())
                    throw new RuntimeException("Failed to evaluate integral, command=" + instruction + ", result=" + r.getResult());
                throw new RuntimeException("Failed to evaluate integral.");
            }
        } else {
            throw new RuntimeException("Invalid number of arguments.");
        }
    }

    @Override
    protected String name() {
        return "cas:complex-integral";
    }
}
