package palaiologos.kamilalisp.runtime;

import com.google.common.collect.Iterables;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class Depth implements SpecialForm, ReactiveFunction {
    private final Atom form;
    private final List<Atom> depths;

    private final int l;
    private final int c;

    public Depth(Atom form, List<Atom> depths, int line, int col) {
        this.form = form;
        this.l = line;
        this.c = col;
        this.depths = depths;

        if (this.depths.isEmpty()) {
            throw new RuntimeException("Error on line " + l + " column " + c + ". Empty depth.");
        }
    }

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    @Override
    public Atom apply(Environment oldEnv, List<Atom> args) {
        Callable lambda = Evaluation.evaluate(oldEnv, form).getCallable();
        return new Atom(new Lambda() {
            @Override
            public String stringify() {
                return Depth.this.stringify();
            }

            @Override
            public String frameString() {
                return Depth.this.frameString();
            }

            public int computeRank(Atom atom) {
                if (atom.getType() == Type.LIST) {
                    // Compute the ranks of all elements in the list. If they're all the same, return that + 1.
                    // If they differ, return -1 (do not consider).
                    List<Integer> ranks = atom.getList().stream().map(this::computeRank).distinct().toList();
                    if (ranks.size() == 1) {
                        return 1 + ranks.get(0);
                    } else {
                        return -1;
                    }
                } else {
                    return 0;
                }
            }

            public int computeRankMax(Atom atom) {
                if (atom.getType() == Type.LIST) {
                    // Compute the ranks of all elements in the list. Take the maximum one.
                    return 1 + atom.getList().stream().map(this::computeRankMax).max(Integer::compareTo).orElse(0);
                } else {
                    return 0;
                }
            }

            private void traverse(Atom a, int depth, List<Atom> possibleValues) {
                if (a.getType() != Type.LIST && depth == 0)
                    possibleValues.add(a);
                else if (a.getType() == Type.LIST) {
                    if (computeRank(a) == depth)
                        possibleValues.add(a);
                    else
                        a.getList().forEach(b -> traverse(b, depth, possibleValues));
                }
            }

            @Override
            public Atom apply(Environment env, List<Atom> args) {
                if (args.size() == 0)
                    return Atom.NULL;

                // Check what in the world is the depths list.
                // Case 1: Just integers.
                List<Atom> data;
                if (depths.stream().allMatch(a -> a.getType() == Type.INTEGER)) {
                    // OK, so we have a list of integers. Cycle it so that it's the same length as the args list,
                    // shortening it if needed.
                    data = depths;
                } else {
                    // Case 2: Anything else.
                    // Evaluate the list in the old environment and then do the same thing as above.
                    Atom a = Evaluation.evaluate(oldEnv, new Atom(depths));
                    if (a.getType() != Type.LIST || !a.getList().stream().allMatch(b -> b.getType() == Type.INTEGER))
                        throw new RuntimeException("Depth list must be a list of integers or an expression that evaluates to a list of integers.");
                    data = a.getList();
                }

                Stream<Integer> depthStream = Streams.stream(Iterables.cycle(data)).limit(args.size()).map(a -> a.getInteger().intValueExact());

                // Example: Scalar pervasion of +: +%[0] l1 l2
                // Takes the scalars of l1 and l2 and applies + between them to form a new list.
                List<List<Atom>> argumentValues = Streams.zip(args.stream(), depthStream, (a, d) -> {
                    if (d < 0) {
                        d = Math.max(computeRank(a) + d, 0);
                    }
                    List<Atom> possibleValues = new ArrayList<>();
                    traverse(a, d, possibleValues);
                    if (possibleValues.isEmpty()) {
                        // Oops. We didn't find anything - we need to box the original value a few times.
                        int rank = computeRankMax(a);
                        if (rank > d) {
                            throw new RuntimeException("Internal error.");
                        } else if (rank == d) {
                            return List.of(a);
                        } else {
                            while (rank < d) {
                                a = new Atom(List.of(a));
                                rank++;
                            }
                            return List.of(a);
                        }
                    }
                    return possibleValues;
                }).toList();

                int size = argumentValues.stream().map(List::size).filter(x -> x == 1).min(Comparator.naturalOrder()).get();
                if (size == 0)
                    return Atom.NULL;

                List<List<Atom>> arguments = argumentValues.stream().map(l -> l.size() == 1 ? l : l.subList(0, size)).toList();
                return new Atom(IntStream.range(0, size)
                        .mapToObj(index -> Evaluation.evaluate(env, lambda, arguments.stream().map(x -> x.size() != 1 ? x.get(index) : x.get(0))
                                .collect(Collectors.toCollection(ArrayList::new)))).toList());
            }

            @Override
            public int line() {
                return Depth.this.line();
            }

            @Override
            public int column() {
                return Depth.this.column();
            }
        });
    }

    @Override
    public String stringify() {
        return form.toString() + "%" + depths.toString();
    }

    @Override
    public String frameString() {
        return "%[]/syn";
    }
}
