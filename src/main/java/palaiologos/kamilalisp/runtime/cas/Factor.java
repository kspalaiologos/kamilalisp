package palaiologos.kamilalisp.runtime.cas;

import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.cas.meta.EvaluationResult;
import palaiologos.kamilalisp.runtime.cas.meta.FortranParser;
import palaiologos.kamilalisp.runtime.cas.meta.FriCAS;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.HashMap;
import java.util.List;

public class Factor extends PrimitiveFunction implements Lambda {
    protected static Atom tex = new Atom("tex");

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        MathExpression expr = args.get(0).getUserdata(MathExpression.class);
        HashPMap<Atom, Atom> options = env.has("cas-options") ? env.get("cas-options").getUserdata(HashMapUserData.class).value() : HashTreePMap.from(new HashMap<Atom, Atom>());
        String instruction =
                "factor(" + expr.getExpression() + ")\n";
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
                throw new RuntimeException("Failed to factor, command=" + instruction + ", result=" + r.getResult());
            throw new RuntimeException("Failed to factor.");
        } else {
            if (options.getOrDefault(tex, Atom.FALSE).equals(Atom.TRUE)) {
                return new Atom(r.getResult());
            }
            HashPMap<Atom, Atom> a;
            try {
                a = FortranParser.parse(r.getResult()).getUserdata(HashMapUserData.class).value();
            } catch (Exception e) {
                if (StackFrame.isDebug())
                    throw new RuntimeException("Failed to factor (parse), command=" + instruction + ", result=" + r.getResult() + ", why=" + e.getMessage());
                throw new RuntimeException("Failed to factor.");
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
                return new Atom(new MathExpression(env, expr.getArgs(), entry));
            } else {
                throw new RuntimeException("Failed to compute the derivative, CAS arity error.");
            }
        }
    }

    @Override
    protected String name() {
        return "cas:factor";
    }
}
