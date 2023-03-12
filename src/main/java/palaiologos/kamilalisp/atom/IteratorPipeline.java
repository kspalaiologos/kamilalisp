package palaiologos.kamilalisp.atom;

import palaiologos.kamilalisp.error.TypeError;

import java.math.BigInteger;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Stream;

public class IteratorPipeline {
    public static Atom evaluate(Environment env, List<Atom> operations, Stream<Atom> input) {
        Stream<Atom> result = input;
        for(Atom op : operations) {
            op.assertTypes(Type.LIST);
            List<Atom> opList = op.getList();
            if(opList.isEmpty()) {
                throw new TypeError("Empty list in iterator pipeline");
            }
            Atom head = opList.get(0);
            List<Atom> tail = opList.subList(1, opList.size());
            head.assertTypes(Type.IDENTIFIER);
            switch (head.getIdentifier()) {
                case "map", "¨" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to map");
                    Callable f = tail.get(0).getCallable();
                    result = result.map(a -> Evaluation.evaluate(env, f, List.of(a)));
                }
                case "filter", "⍭" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to filter");
                    Callable f = tail.get(0).getCallable();
                    result = result.filter(a -> Evaluation.evaluate(env, f, List.of(a)).coerceBool());
                }
                case "fold", "⌿" -> {
                    if (tail.size() != 2)
                        throw new TypeError("Wrong number of arguments to reduce");
                    Callable f = tail.get(0).getCallable();
                    Atom initial = tail.get(1);
                    return result.reduce(initial, (a, b) -> Evaluation.evaluate(env, f, List.of(a, b)));
                }
                case "reduce", "⍀" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to reduce");
                    Callable f = tail.get(0).getCallable();
                    return result.reduce((a, b) -> Evaluation.evaluate(env, f, List.of(a, b))).orElse(Atom.NULL);
                }
                case "collect", "⍠←⌽" -> {
                    if (tail.size() != 0)
                        throw new TypeError("Wrong number of arguments to collect");
                    return new Atom(result.toList());
                }
                case "drop", "↓" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to drop");
                    result = result.skip(tail.get(0).getInteger().intValueExact());
                }
                case "take", "↑" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to take");
                    result = result.limit(tail.get(0).getInteger().intValueExact());
                }
                case "all", "∧?" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to all");
                    Callable f = tail.get(0).getCallable();
                    return new Atom(result.allMatch(a -> Evaluation.evaluate(env, f, List.of(a)).coerceBool()));
                }
                case "any", "∨?" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to any");
                    Callable f = tail.get(0).getCallable();
                    return new Atom(result.anyMatch(a -> Evaluation.evaluate(env, f, List.of(a)).coerceBool()));
                }
                case "none", "∅?" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to none");
                    Callable f = tail.get(0).getCallable();
                    return new Atom(result.noneMatch(a -> Evaluation.evaluate(env, f, List.of(a)).coerceBool()));
                }
                case "count", "⍴?" -> {
                    if (tail.size() != 0)
                        throw new TypeError("Wrong number of arguments to count");
                    return new Atom(BigInteger.valueOf(result.count()));
                }
                case "take-while", "⍣↑" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to take-while");
                    Callable f = tail.get(0).getCallable();
                    result = result.takeWhile(a -> Evaluation.evaluate(env, f, List.of(a)).coerceBool());
                }
                case "drop-while", "⍣↓" -> {
                    if (tail.size() != 1)
                        throw new TypeError("Wrong number of arguments to drop-while");
                    Callable f = tail.get(0).getCallable();
                    result = result.dropWhile(a -> Evaluation.evaluate(env, f, List.of(a)).coerceBool());
                }
                case "unique", "⊙" -> {
                    if (tail.size() != 0)
                        throw new TypeError("Wrong number of arguments to unique");
                    result = result.distinct();
                }
                case "sort-asc", "⊼" -> {
                    if (tail.size() == 0) {
                        result = result.sorted();
                    } else if (tail.size() == 1) {
                        Callable f = tail.get(0).getCallable();
                        result = result.sorted((a, b) -> Evaluation.evaluate(env, f, List.of(a, b)).getInteger().intValueExact());
                    } else {
                        throw new TypeError("Wrong number of arguments to sort-asc");
                    }
                }
                case "sort-desc", "⊽" -> {
                    if (tail.size() == 0) {
                        result = result.sorted(Comparator.reverseOrder());
                    } else if (tail.size() == 1) {
                        Callable f = tail.get(0).getCallable();
                        result = result.sorted((a, b) -> Evaluation.evaluate(env, f, List.of(b, a)).getInteger().intValueExact());
                    } else {
                        throw new TypeError("Wrong number of arguments to sort-desc");
                    }
                }
                default -> throw new TypeError("Unknown iterator operation: " + head.getIdentifier());
            }
        }
        throw new RuntimeException("No terminal operation on iterator.");
    }
}
