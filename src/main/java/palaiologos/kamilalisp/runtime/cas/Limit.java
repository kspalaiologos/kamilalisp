package palaiologos.kamilalisp.runtime.cas;

import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class Limit extends PrimitiveFunction implements SpecialForm {
    // cas:lim x -> 0 (cas:fn x \+ x (** x 2))
    protected static Atom tex = new Atom("tex");

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() < 4)
            throw new RuntimeException("Expected at least 4 arguments, got " + args.size());
        String variable = args.get(0).getIdentifier();
        String arrow = args.get(1).getIdentifier();
        String side = switch (arrow) {
            case "->+" -> "\"left\"";
            case "->-" -> "\"right\"";
            case "->" -> "";
            default -> throw new RuntimeException("Invalid arrow.");
        };
        Atom value = args.get(2);
        MathExpression function = Evaluation.evaluate(env, args.get(3)).getUserdata(MathExpression.class);
        HashPMap<Atom, Atom> options = env.has("cas-options") ? env.get("cas-options").getUserdata(HashMapUserData.class).value() : HashTreePMap.from(new HashMap<Atom, Atom>());
        String instruction =
                "limit(" + function.getExpression() + ", " + variable + "=" + (new MathExpression(env, Set.of(), value).getExpression()) + (side.equals("") ? "" : ", " + side) + ")\n";
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
        if(!r.isSuccessful()) {
            if(StackFrame.isDebug())
                throw new RuntimeException("Failed to evaluate the limit, command=" + instruction + ", result=" + r.getResult());
            throw new RuntimeException("Failed to evaluate the limit.");
        } else {
            if(options.getOrDefault(tex, Atom.FALSE).equals(Atom.TRUE)) {
                return new Atom(r.getResult());
            }
            HashPMap<Atom, Atom> a;
            try {
                a = FortranParser.parse(r.getResult()).getUserdata(HashMapUserData.class).value();
            } catch (Exception e) {
                if(StackFrame.isDebug())
                    throw new RuntimeException("Failed to evaluate limit (parse), command=" + instruction + ", result=" + r.getResult() + ", why=" + e.getMessage());
                throw new RuntimeException("Failed to evaluate limit.");
            }

            Set<String> newVariables = new LinkedHashSet<>(function.getArgs());
            newVariables.remove(variable);

            if(a.size() == 0) {
                return Atom.NULL;
            } else if(a.size() == 1) {
                Atom entry = a.entrySet().stream().findFirst().get().getValue();
                if(entry.getType() == Type.STRING) {
                    if(entry.getString().equals("failed"))
                        throw new RuntimeException("Failed to evaluate limit.");
                    else
                        throw new RuntimeException("Failed to evaluate limit, unknown error.");
                }
                return new Atom(new MathExpression(env, newVariables, entry));
            } else if(a.size() == 3) {
                // Assert that: T1(1), T1(2) exist as keys, R=T1.
                // In T-keys, equality of left and right limit.
                List<String> keys = a.keySet().stream().map(Atom::getString).toList();
                if(!keys.contains("T1(1)") || !keys.contains("T1(2)") || !keys.contains("R"))
                    throw new RuntimeException("Failed to evaluate limit, CAS error.");
                if(!a.get(new Atom("R")).equals(new Atom("T1", true)))
                    throw new RuntimeException("Failed to evaluate limit, CAS error.");
                Atom limit1 = a.get(new Atom("T1(1)"));
                Atom limit2 = a.get(new Atom("T1(2)"));
                Atom left, right;
                if(limit1.getType() != Type.LIST || limit2.getType() != Type.LIST)
                    throw new RuntimeException("Failed to evaluate limit, CAS error.");
                if(limit1.getList().size() != 3 || limit2.getList().size() != 3)
                    throw new RuntimeException("Failed to evaluate limit, CAS error.");
                String lim1Kind = limit1.getList().get(1).getString();
                String lim2Kind = limit2.getList().get(1).getString();
                if(lim1Kind.startsWith("left") && lim2Kind.startsWith("right")) {
                    left = limit1.getList().get(2);
                    right = limit2.getList().get(2);
                } else if(lim1Kind.startsWith("right") && lim2Kind.startsWith("left")) {
                    left = limit2.getList().get(2);
                    right = limit1.getList().get(2);
                } else {
                    throw new RuntimeException("Failed to evaluate limit, CAS error.");
                }
                HashMap<Atom, Atom> data = new HashMap<>();
                if(left.getType() != Type.STRING)
                    data.put(new Atom("left"), new Atom(new MathExpression(env, newVariables, left)));
                if(right.getType() != Type.STRING)
                    data.put(new Atom("right"), new Atom(new MathExpression(env, newVariables, left)));
                return new Atom(new HashMapUserData(HashTreePMap.from(data)));
            }
        }

        throw new RuntimeException("Internal error.");
    }

    @Override
    protected String name() {
        return "cas:lim";
    }
}
