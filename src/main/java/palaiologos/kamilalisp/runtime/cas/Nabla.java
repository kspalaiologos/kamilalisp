package palaiologos.kamilalisp.runtime.cas;

import org.pcollections.HashPMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.cas.meta.EvaluationResult;
import palaiologos.kamilalisp.runtime.cas.meta.FortranParser;
import palaiologos.kamilalisp.runtime.cas.meta.FriCAS;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class Nabla extends PrimitiveFunction implements Lambda {
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

    public static MathExpression d(Environment env, MathExpression expr, String var) {
        String instruction = "D(" + expr.getExpression() + ", " + var + ")\n";
        EvaluationResult r = (EvaluationResult) FriCAS.withFriCas(x -> {
            x.apply(")clear all\n");
            x.apply(")set output algebra off\n");
            x.apply(")set output fortran on\n");
            x.apply("digits(" + env.get("fr") + ")\n");
            return x.apply(instruction);
        });
        if (!r.isSuccessful()) {
            if (StackFrame.isDebug())
                throw new RuntimeException("Failed to compute the derivative, command=" + instruction + ", result=" + r.getResult());
            throw new RuntimeException("Failed to compute the derivative.");
        } else {
            HashPMap<Atom, Atom> a;
            try {
                a = FortranParser.parse(r.getResult()).getUserdata(HashMapUserData.class).value();
            } catch (Exception e) {
                if (StackFrame.isDebug())
                    throw new RuntimeException("Failed to compute the derivative (parse), command=" + instruction + ", result=" + r.getResult() + ", why=" + e.getMessage());
                throw new RuntimeException("Failed to compute the derivative.");
            }

            if (a.size() == 0) {
                throw new RuntimeException("Failed to compute the derivative, CAS result empty.");
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
                return new MathExpression(env, args2, entry);
            } else {
                throw new RuntimeException("Failed to compute the derivative, CAS arity error.");
            }
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Set<String> exprArgs;
        MathExpression expr;
        if(args.size() == 1) {
            expr = args.get(0).getUserdata(MathExpression.class);
            exprArgs = expr.getArgs();
        } else if(args.size() == 2) {
            exprArgs = args.get(0).getList().stream().map(Atom::getIdentifier).collect(LinkedHashSet::new, LinkedHashSet::add, LinkedHashSet::addAll);
            expr = args.get(1).getUserdata(MathExpression.class);
        } else {
            throw new RuntimeException("cas:nabla - expected one or two arguments");
        }
        return new Atom(exprArgs.stream().map(x -> new Atom(d(env, expr, x))).toList());
    }

    @Override
    protected String name() {
        return "nabla";
    }
}
