package palaiologos.kamilalisp.runtime.cas;

import com.google.common.collect.Streams;
import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.cas.meta.EvaluationResult;
import palaiologos.kamilalisp.runtime.cas.meta.FortranParser;
import palaiologos.kamilalisp.runtime.cas.meta.FriCAS;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Integral extends PrimitiveFunction implements SpecialForm {
    protected static Atom tex = new Atom("tex");

    protected static Atom expressionFromList(Environment env, Set<String> args, String differential, Atom expression) {
        LinkedHashSet<String> newArgs = new LinkedHashSet<>(args);
        newArgs.add(differential);
        return new Atom(new MathExpression(env, newArgs, expression));
    }

    protected static Atom replaceIdentifiers(Atom a, Set<String> defined, HashPMap<Atom, Atom> map) {
        if (a.getType() == Type.IDENTIFIER) {
            if (defined.contains(a.getIdentifier())) {
                return replaceIdentifiers(map.get(new Atom(a.getIdentifier())), defined, map);
            } else {
                return a;
            }
        } else if (a.getType() == Type.LIST) {
            List<Atom> l = new ArrayList<>();
            for (Atom x : a.getList()) {
                l.add(replaceIdentifiers(x, defined, map));
            }
            return new Atom(l);
        } else {
            return a;
        }
    }

    public static Atom processSolution(Environment env, MathExpression originalExpression, String differential, HashPMap<Atom, Atom> a) {
        // If all of them are identifiers:
        boolean allIdentifiers = true;
        for (Map.Entry<Atom, Atom> atomAtomEntry : a.entrySet()) {
            if (atomAtomEntry.getKey().getString().contains("(")) {
                allIdentifiers = false;
                break;
            }
        }
        if (allIdentifiers) {
            Set<String> defined = new HashSet<>();
            for (Atom atom : a.keySet()) {
                String string = atom.getString();
                if (string.startsWith("T")) {
                    defined.add(string);
                }
            }
            Optional<Map.Entry<Atom, Atom>> found = Optional.empty();
            for (Map.Entry<Atom, Atom> x : a.entrySet()) {
                if (x.getKey().getString().startsWith("R")) {
                    found = Optional.of(x);
                    break;
                }
            }
            Atom result = found.get().getValue();
            // Replace all occurences of identifiers in "defined" with their value in "a".
            return expressionFromList(env, originalExpression.getArgs(), differential, replaceIdentifiers(result, defined, a));
        } else {
            // Got a list somewhere.
            Optional<Map.Entry<Atom, Atom>> found = Optional.empty();
            for (Map.Entry<Atom, Atom> atomAtomEntry : a.entrySet()) {
                if (atomAtomEntry.getKey().getString().startsWith("R")) {
                    found = Optional.of(atomAtomEntry);
                    break;
                }
            }
            Atom result = found.get().getValue();
            LinkedHashSet<String> listEntries = new LinkedHashSet<>();
            for (Map.Entry<Atom, Atom> atomAtomEntry : a.entrySet()) {
                if (atomAtomEntry.getKey().getString().startsWith("T")) {
                    String string = atomAtomEntry.getKey().getString();
                    listEntries.add(string);
                }
            }
            if (listEntries.size() != a.size() - 1)
                throw new RuntimeException("Invalid result.");
            // Check if listEntires are in form of Ln(a).
            String firstEntry = listEntries.iterator().next();
            int n = Integer.parseInt(firstEntry.substring(1, firstEntry.indexOf('(')));
            for (String listEntry : listEntries) {
                if (!listEntry.matches("T" + n + "\\([0-9]+\\)")) {
                    throw new RuntimeException("Invalid result.");
                }
            }
            // Verify that the indices are a permutation of naturals until n-1.
            ArrayList<Integer> indices = new ArrayList<>();
            for (String listEntry : listEntries) {
                Integer parseInt = Integer.parseInt(listEntry.substring(listEntry.indexOf('(') + 1, listEntry.indexOf(')')));
                indices.add(parseInt);
            }
            indices.sort(null);
            if(indices.size() != n - 1)
                throw new RuntimeException("Invalid result.");
            for(int i = 1; i < n - 1; i++) {
                if (indices.get(i - 1) != i) {
                    throw new RuntimeException("Invalid result.");
                }
            }
            // Verify that the result is R...=Ln
            if (!result.getIdentifier().matches("T" + n))
                throw new RuntimeException("Invalid result.");
            ArrayList<Atom> list = new ArrayList<>();
            for (Map.Entry<Atom, Atom> x : a.entrySet()) {
                if (x.getKey().getString().startsWith("T")) {
                    Atom solution = x.getValue();
                    Atom atom = expressionFromList(env, originalExpression.getArgs(), differential, solution);
                    list.add(atom);
                }
            }
            return new Atom(list);
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 2 || args.size() == 3) {
            MathExpression expr = Evaluation.evaluate(env, args.get(0)).getUserdata(MathExpression.class);
            Atom var = args.get(1);
            HashPMap<Atom, Atom> options = env.has("cas-options") ? env.get("cas-options").getUserdata(HashMapUserData.class).value() : HashTreePMap.from(new HashMap<Atom, Atom>());
            var.assertTypes(Type.IDENTIFIER);
            String differential = var.getIdentifier().substring(1);
            if (!differential.matches("[a-zA-Z]+") || differential.isEmpty())
                throw new RuntimeException("Invalid differential.");
            String instruction = "integrate(" + expr.getExpression() + ", " + differential + ")\n";
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
            if (r.isSuccessful()) {
                if (options.getOrDefault(tex, Atom.FALSE).equals(Atom.TRUE)) {
                    return new Atom(r.getResult());
                }
                HashPMap<Atom, Atom> a;
                try {
                    a = FortranParser.parse(r.getResult()).getUserdata(HashMapUserData.class).value();
                } catch (Exception e) {
                    if (StackFrame.isDebug())
                        throw new RuntimeException("Failed to evaluate integral (parse), command=" + instruction + ", result=" + r.getResult() + ", why=" + e.getMessage());
                    throw new RuntimeException("Failed to evaluate integral.");
                }
                if (a.size() == 0) {
                    // No solution.
                    return Atom.NULL;
                }
                if (a.size() == 1) {
                    // One solution.
                    Atom solution = a.entrySet().stream().findFirst().get().getValue();
                    if (solution.getType() == Type.STRING) {
                        String s = solution.getString();
                        if (s.equals("failed")) {
                            throw new RuntimeException("Failed to evaluate integral.");
                        } else {
                            throw new RuntimeException("Unknown error in evaluating the integral: " + s);
                        }
                    } else {
                        return expressionFromList(env, expr.getArgs(), differential, solution);
                    }
                } else {
                    // More than one solution.
                    return processSolution(env, expr, differential, a);
                }
            } else {
                if (StackFrame.isDebug())
                    throw new RuntimeException("Failed to evaluate integral, command=" + instruction + ", result=" + r.getResult());
                throw new RuntimeException("Failed to evaluate integral.");
            }
        } else {
            throw new RuntimeException("Invalid number of arguments.");
        }
    }

    @Override
    protected String name() {
        return "cas:integral";
    }
}
