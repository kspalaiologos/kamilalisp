package palaiologos.kamilalisp.runtime.cas;

import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.cas.meta.EvaluationResult;
import palaiologos.kamilalisp.runtime.cas.meta.FortranParser;
import palaiologos.kamilalisp.runtime.cas.meta.FriCAS;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;

public class Derivative extends PrimitiveFunction implements Lambda {
    protected static Atom tex = new Atom("tex");

    private static boolean hasVariable(Atom a, String name) {
        if (a.getType() == Type.IDENTIFIER) {
            return a.getIdentifier().equals(name);
        } else if (a.getType() == Type.LIST) {
            for (Atom x : a.getList()) {
                if (hasVariable(x, name))
                    return true;
            }
        }
        return false;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        String var = args.get(0).getIdentifier();
        MathExpression expr = args.get(1).getUserdata(MathExpression.class);
        HashPMap<Atom, Atom> options = env.has("cas-options") ? env.get("cas-options").getUserdata(HashMapUserData.class).value() : HashTreePMap.from(new HashMap<Atom, Atom>());
        String instruction =
                "D(" + expr.getExpression() + ", " + var + ")\n";
        EvaluationResult r = (EvaluationResult) FriCAS.withFriCas(x -> {
            x.apply(")clear all\n");
            x.apply(")set output algebra off\n");
            if (options.getOrDefault(tex, Atom.FALSE).equals(Atom.TRUE)) {
                x.apply(")set output fortran off\n");
                x.apply(")set output tex on\n");
            } else {
                x.apply(")set output tex off\n");
                x.apply(")set output fortran on\n");
            }
            x.apply("digits(" + env.get("fr") + ")\n");
            return x.apply(instruction);
        });
        if (!r.isSuccessful()) {
            if (StackFrame.isDebug())
                throw new RuntimeException("Failed to compute the derivative, command=" + instruction + ", result=" + r.getResult());
            throw new RuntimeException("Failed to compute the derivative.");
        } else {
            if (options.getOrDefault(tex, Atom.FALSE).equals(Atom.TRUE)) {
                return new Atom(r.getResult());
            }
            HashPMap<Atom, Atom> a;
            try {
                a = FortranParser.parse(r.getResult()).getUserdata(HashMapUserData.class).value();
            } catch (Exception e) {
                if (StackFrame.isDebug())
                    throw new RuntimeException("Failed to compute the derivative (parse), command=" + instruction + ", result=" + r.getResult() + ", why=" + e.getMessage());
                throw new RuntimeException("Failed to compute the derivative.");
            }

            if (a.size() == 0) {
                return Atom.NULL;
            } else if (a.size() == 1) {
                Atom entry = a.entrySet().stream().findFirst().get().getValue();
                if (entry.getType() == Type.STRING) {
                    if (entry.getString().equals("failed"))
                        throw new RuntimeException("Failed to compute the derivative.");
                    else
                        throw new RuntimeException("Failed to compute the derivative, unknown error.");
                }
                LinkedHashSet<String> args2 = new LinkedHashSet<>();
                for(String s : expr.getArgs())
                    if (hasVariable(entry, s))
                        args2.add(s);
                return new Atom(new MathExpression(env, args2, entry));
            } else {
                throw new RuntimeException("Failed to compute the derivative, CAS arity error.");
            }
        }
    }

    @Override
    protected String name() {
        return "cas:D";
    }
}
