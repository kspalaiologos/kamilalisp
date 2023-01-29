package palaiologos.kamilalisp.runtime;

import com.google.common.collect.Iterables;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.array.Rank;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
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

                List<Integer> depth = Streams.stream(Iterables.cycle(data)).limit(args.size()).map(a -> a.getInteger().intValueExact()).toList();

                if(args.size() == 1) {
                    // Easy case: we have only the shape list.
                    int d = depth.get(0);
                    Atom a = args.get(0);
                    if(a.getType() != Type.LIST) {
                        return new Atom(List.of(Evaluation.evaluate(env, lambda, List.of(a))));
                    }

                    if(d < 0) {
                        return map1(env, lambda, a, -d);
                    } else {
                        return map_pos1(env, lambda, a, d);
                    }
                } else {
                    // Hard case: we have the shape list and the auxiliary lists.
                    List<List<Atom>> aux_pos = Streams.zip(args.stream(), depth.stream(), Pair::new).skip(1).map(pair -> {
                        int d = pair.snd();
                        Atom a = pair.fst();

                        // Only one possibility.
                        if(a.getType() != Type.LIST) {
                            return List.of(a);
                        }

                        List<Atom> dt = new ArrayList<>();
                        if(d < 0) {
                            mapN(a, -d, dt);
                        } else {
                            map_posN(a, d, dt);
                        }
                        if(dt.isEmpty())
                            throw new RuntimeException("Internal error?");
                        return dt;
                    }).toList();

                    int d = depth.get(0);
                    Atom a = args.get(0);
                    if(a.getType() != Type.LIST) {
                        return new Atom(List.of(new Atom(Streams.concat(Stream.of(a), aux_pos.stream().map(x -> x.size() == 1 ? x.get(0) : x.remove(0))).toList())));
                    }

                    if(d < 0) {
                        return map2(env, lambda, a, -d, aux_pos);
                    } else {
                        return map_pos2(env, lambda, a, d, aux_pos);
                    }
                }
            }

            private void mapN(Atom data, int d, List<Atom> dt) {
                if (data.getType() != Type.LIST)
                    dt.add(data);
                else if(d == 1)
                    dt.addAll(data.getList());
                else
                    data.getList().forEach(x -> mapN(x, d - 1, dt));
            }

            private Atom map_pos1(Environment e, Callable c, Atom data, int d) {
                int actualRank = Math.abs(Rank.computeRank(data));
                if(d >= actualRank)
                    return Evaluation.evaluate(e, c, List.of(data));
                else {
                    return new Atom((List<Atom>)
                            data.getList().stream().map(x -> map_pos1(e, c, x, d))
                                    .collect(Collectors.toCollection(ArrayList::new)));
                }
            }

            private Atom map_pos2(Environment e, Callable c, Atom data, int d, List<List<Atom>> aux_pos) {
                int actualRank = Math.abs(Rank.computeRank(data));
                if(d >= actualRank)
                    return Evaluation.evaluate(e, c, Streams.concat(Stream.of(data), aux_pos.stream().map(x -> x.size() == 1 ? x.get(0) : x.remove(0))).toList());
                else {
                    return new Atom((List<Atom>)
                            data.getList().stream().map(x -> map_pos2(e, c, x, d, aux_pos))
                                    .collect(Collectors.toCollection(ArrayList::new)));
                }
            }

            private void map_posN(Atom data, int d, List<Atom> target) {
                int actualRank = Math.abs(Rank.computeRank(data));
                if(d >= actualRank)
                    target.add(data);
                else {
                    data.getList().forEach(x -> map_posN(x, d, target));
                }
            }
            private Atom map2(Environment e, Callable c, Atom data, int d, List<List<Atom>> aux_pos) {
                if (data.getType() != Type.LIST)
                    return Evaluation.evaluate(e, c, Streams.concat(Stream.of(data), aux_pos.stream().map(x -> x.size() == 1 ? x.get(0) : x.remove(0))).toList());
                if(d == 1) {
                    return new Atom((List<Atom>)
                            data.getList().stream().map(x -> Evaluation.evaluate(e, c, Streams.concat(Stream.of(x), aux_pos.stream().map(y -> y.size() == 1 ? y.get(0) : y.remove(0))).toList()))
                                    .collect(Collectors.toCollection(ArrayList::new)));
                } else {
                    return new Atom((List<Atom>)
                            data.getList().stream().map(x -> map2(e, c, x, d - 1, aux_pos))
                                    .collect(Collectors.toCollection(ArrayList::new)));
                }
            }

            private Atom map1(Environment e, Callable c, Atom data, int d) {
                if (data.getType() != Type.LIST)
                    return Evaluation.evaluate(e, c, List.of(data));
                if(d == 1) {
                    return new Atom((List<Atom>)
                            data.getList().stream().map(x -> Evaluation.evaluate(e, c, List.of(x)))
                                    .collect(Collectors.toCollection(ArrayList::new)));
                } else {
                    return new Atom((List<Atom>)
                            data.getList().stream().map(x -> map1(e, c, x, d - 1))
                                    .collect(Collectors.toCollection(ArrayList::new)));
                }
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
