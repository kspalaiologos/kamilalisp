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

public class Integral extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 2 || args.size() == 3) {
            Atom expr = args.get(0);
            Atom var = args.get(1);
            Set<String> options = new HashSet<>();
            if(args.size() == 3) {
                Atom opt = args.get(2);
                opt.assertTypes(Type.LIST);
                for(Atom a : opt.getList()) {
                    a.assertTypes(Type.IDENTIFIER);
                    if(!a.getIdentifier().equals("tex"))
                        throw new RuntimeException("Invalid option: " + a.getIdentifier());
                    options.add(a.getIdentifier());
                }
            }
            var.assertTypes(Type.IDENTIFIER);
            String differential = var.getIdentifier().substring(1);
            if(!differential.matches("[a-zA-Z]+") || differential.isEmpty())
                throw new RuntimeException("Invalid differential.");
            String expressionCode = CasExpressionGenerator.generateExpression(env, expr);
            String instruction = "integrate(" + expressionCode + ", " + differential + ")\n";
            EvaluationResult r = (EvaluationResult) FriCAS.withFriCas(x -> {
                x.apply(")clear all\n");
                x.apply(")set output algebra off\n");
                if(options.contains("tex")) {
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
                if(options.contains("tex")) {
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

    private static Atom replaceIdentifiers(Atom a, Set<String> defined, HashPMap<Atom, Atom> map) {
        if(a.getType() == Type.IDENTIFIER) {
            if(defined.contains(a.getIdentifier())) {
                return replaceIdentifiers(map.get(new Atom(a.getIdentifier())), defined, map);
            } else {
                return a;
            }
        } else if(a.getType() == Type.LIST) {
            List<Atom> l = new ArrayList<>();
            for(Atom x : a.getList()) {
                l.add(replaceIdentifiers(x, defined, map));
            }
            return new Atom(l);
        } else {
            return a;
        }
    }

    public static Atom processSolution(HashPMap<Atom, Atom> a) {
        // If all of them are identifiers:
        if(a.entrySet().stream().noneMatch(x -> x.getKey().getString().contains("("))) {
            Set<String> defined = a.keySet().stream().map(Atom::getString).filter(x -> x.startsWith("T")).collect(Collectors.toSet());
            Atom result = a.entrySet().stream().filter(x -> x.getKey().getString().startsWith("R")).findFirst().get().getValue();
            // Replace all occurences of identifiers in "defined" with their value in "a".
            return replaceIdentifiers(result, defined, a);
        } else {
            // Got a list somewhere.
            Atom result = a.entrySet().stream().filter(x -> x.getKey().getString().startsWith("R")).findFirst().get().getValue();
            Set<String> listEntries = a.entrySet().stream().filter(x -> x.getKey().getString().startsWith("T")).map(x -> x.getKey().getString()).collect(Collectors.toSet());
            if(listEntries.size() != a.size() - 1)
                throw new RuntimeException("Invalid result.");
            // Check if listEntires are in form of Ln(a).
            String firstEntry = listEntries.stream().findFirst().get();
            int n = Integer.parseInt(firstEntry.substring(1, firstEntry.indexOf('(')));
            if(listEntries.stream().anyMatch(x -> !x.matches("T" + n + "\\([0-9]+\\)")))
                throw new RuntimeException("Invalid result.");
            // Verify that the indices are a permutation of naturals until n-1.
            List<Integer> indices = listEntries.stream().map(x -> Integer.parseInt(x.substring(x.indexOf('(') + 1, x.indexOf(')')))).sorted().toList();
            if(!Streams.zip(indices.stream().sorted(), IntStream.range(1, n - 1).boxed(), Integer::equals).allMatch(x -> x))
                throw new RuntimeException("Invalid result.");
            // Verify that the result is R...=Ln
            if(!result.getIdentifier().matches("T" + n))
                throw new RuntimeException("Invalid result.");
            return new Atom(Stream.concat(Stream.of(new Atom("tie", true)), a.entrySet().stream().filter(x -> x.getKey().getString().startsWith("T")).map(Map.Entry::getValue)).toList());
        }
    }

    @Override
    protected String name() {
        return "cas:integral";
    }
}
