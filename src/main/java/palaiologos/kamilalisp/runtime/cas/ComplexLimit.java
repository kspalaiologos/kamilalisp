package palaiologos.kamilalisp.runtime.cas;

import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class ComplexLimit extends Limit {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() < 4)
            throw new RuntimeException("Expected at least 4 arguments, got " + args.size());
        String variable = args.get(0).getIdentifier();
        String arrow = args.get(1).getIdentifier();
        if(!arrow.equals("->"))
            throw new RuntimeException("Invalid arrow.");
        Atom value = args.get(2);
        MathExpression function = Evaluation.evaluate(env, args.get(3)).getUserdata(MathExpression.class);
        HashPMap<Atom, Atom> options = env.has("cas-options") ? env.get("cas-options").getUserdata(HashMapUserData.class).value() : HashTreePMap.from(new HashMap<Atom, Atom>());
        String instruction =
                "complexLimit(" + function.getExpression() + ", " + variable + "=" + (new MathExpression(env, Set.of(), value).getExpression()) + ")\n";
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
            } else {
                throw new RuntimeException("Failed to evaluate limit, CAS arity error.");
            }
        }
    }

    @Override
    protected String name() {
        return "cas:complex-lim";
    }
}
