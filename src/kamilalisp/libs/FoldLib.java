package kamilalisp.libs;

import com.google.common.collect.Lists;
import kamilalisp.data.*;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Stream;

public class FoldLib {
    public static void install(Environment env) {
        // Folds and scans with initial element.

        env.push("foldl", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'foldl'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldl'", Type.CLOSURE, Type.MACRO);
                    arguments.get(2).guardType("Third argument to 'foldl'", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        return Stream.concat(Stream.of(acc), data.stream()).reduce((x, y) ->
                                arguments.get(0).getCallable().get().apply(env, Arrays.asList(x, y))
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("foldr", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'foldr'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldr'", Type.CLOSURE, Type.MACRO);
                    arguments.get(2).guardType("Third argument to 'foldr'", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        return Stream.concat(Stream.of(acc), Lists.reverse(data).stream()).reduce((x, y) ->
                                arguments.get(0).getCallable().get().apply(env, Arrays.asList(y, x))
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("foldl'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'foldl''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldl''", Type.CLOSURE, Type.MACRO);
                    arguments.get(2).guardType("Third argument to 'foldl''", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        return Stream.concat(Stream.of(acc), data.stream()).reduce((x, y) ->
                                arguments.get(0).getCallable().get().apply(env, Arrays.asList(x.eager(), y.eager())).eager()
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("foldr'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'foldr''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldr''", Type.CLOSURE, Type.MACRO);
                    arguments.get(2).guardType("Third argument to 'foldr''", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        return Stream.concat(Stream.of(acc), Lists.reverse(data).stream()).reduce((x, y) ->
                                arguments.get(0).getCallable().get().apply(env, Arrays.asList(y.eager(), x.eager())).eager()
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("scanl", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'scanl'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'scanl'", Type.CLOSURE, Type.MACRO);
                    arguments.get(2).guardType("Third argument to 'scanl'", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    List<Atom> result = new LinkedList<>();
                    result.add(acc);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        Stream.concat(Stream.of(acc), data.stream()).reduce((x, y) -> {
                            Atom a = arguments.get(0).getCallable().get().apply(env, Arrays.asList(x, y));
                            result.add(a);
                            return a;
                        }).get().get().get();
                        return result;
                    }
                }));
            }
        }));

        env.push("scanr", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'scanr'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'scanr'", Type.CLOSURE, Type.MACRO);
                    arguments.get(2).guardType("Third argument to 'scanr'", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    List<Atom> result = new LinkedList<>();
                    result.add(acc);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        Stream.concat(Stream.of(acc), Lists.reverse(data).stream()).reduce((x, y) -> {
                            Atom a = arguments.get(0).getCallable().get().apply(env, Arrays.asList(y, x));
                            result.add(a);
                            return a;
                        }).get().get().get();
                        return Lists.reverse(result);
                    }
                }));
            }
        }));

        env.push("scanl'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'scanl''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'scanl''", Type.CLOSURE, Type.MACRO);
                    arguments.get(2).guardType("Third argument to 'scanl''", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    List<Atom> result = new LinkedList<>();
                    result.add(acc);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        Stream.concat(Stream.of(acc), data.stream()).reduce((x, y) -> {
                            Atom a = arguments.get(0).getCallable().get().apply(env, Arrays.asList(x.eager(), y.eager())).eager();
                            result.add(a);
                            return a;
                        }).get().get().get();
                        return result;
                    }
                }));
            }
        }));

        env.push("scanr'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 3)
                    throw new Error("Invalid invocation to 'scanr''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'scanr''", Type.CLOSURE, Type.MACRO);
                    arguments.get(2).guardType("Third argument to 'scanr''", Type.LIST);
                    List<Atom> data = arguments.get(2).getList().get();
                    Atom acc = arguments.get(1);
                    List<Atom> result = new LinkedList<>();
                    result.add(acc);
                    if(data.isEmpty())
                        return acc.get().get();
                    else {
                        Stream.concat(Stream.of(acc), Lists.reverse(data).stream()).reduce((x, y) -> {
                            Atom a = arguments.get(0).getCallable().get().apply(env, Arrays.asList(y.eager(), x.eager())).eager();
                            result.add(a);
                            return a;
                        }).get().get().get();
                        return Lists.reverse(result);
                    }
                }));
            }
        }));

        // Folds and scans that assume the input is already big enough to not need the identity.

        env.push("foldl1", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'foldl1'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldl1'", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Second argument to 'foldl1'", Type.LIST);
                    List<Atom> data = arguments.get(1).getList().get();
                    if(data.isEmpty())
                        throw new Error("Cannot fold an empty list.");
                    else if(data.size() == 1)
                        return data.get(0);
                    else {
                        return data.stream().reduce((x, y) ->
                                arguments.get(0).getCallable().get().apply(env, Arrays.asList(x, y))
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("foldr1", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'foldr1'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldr1'", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Second argument to 'foldr1'", Type.LIST);
                    List<Atom> data = arguments.get(1).getList().get();
                    if(data.isEmpty())
                        throw new Error("Cannot fold an empty list.");
                    else if(data.size() == 1)
                        return data.get(0);
                    else {
                        return Lists.reverse(data).stream().reduce((x, y) ->
                                arguments.get(0).getCallable().get().apply(env, Arrays.asList(y, x))
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("foldl1'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'foldl1''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldl1''", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Second argument to 'foldl1''", Type.LIST);
                    List<Atom> data = arguments.get(1).getList().get();
                    if(data.isEmpty())
                        throw new Error("Cannot fold an empty list.");
                    else if(data.size() == 1)
                        return data.get(0);
                    else {
                        return data.stream().reduce((x, y) ->
                                arguments.get(0).getCallable().get().apply(env, Arrays.asList(x.eager(), y.eager())).eager()
                        ).get().get().get();
                    }
                }));
            }
        }));

        env.push("foldr1'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'foldr1''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'foldr1''", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Second argument to 'foldr1''", Type.LIST);
                    List<Atom> data = arguments.get(1).getList().get();
                    if(data.isEmpty())
                        throw new Error("Cannot fold an empty list.");
                    else if(data.size() == 1)
                        return data.get(0);
                    else {
                        return Lists.reverse(data).stream().reduce((x, y) ->
                                arguments.get(0).getCallable().get().apply(env, Arrays.asList(y.eager(), x.eager())).eager()
                        ).get().get().get();
                    }
                }));
            }
        }));


        env.push("scanl1", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'scanl1'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'scanl1'", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Second argument to 'scanl1'", Type.LIST);
                    List<Atom> data = arguments.get(1).getList().get();
                    List<Atom> result = new LinkedList<>();
                    if(data.isEmpty())
                        throw new Error("Cannot fold an empty list.");
                    else if(data.size() == 1)
                        return data.get(0);
                    else {
                        data.stream().reduce((x, y) -> {
                            Atom a = arguments.get(0).getCallable().get().apply(env, Arrays.asList(x, y));
                            result.add(a);
                            return a;
                        }).get().get().get();
                        return result;
                    }
                }));
            }
        }));

        env.push("scanr1", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'scanr1'.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'scanr1'", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Second argument to 'scanr1'", Type.LIST);
                    List<Atom> data = arguments.get(1).getList().get();
                    List<Atom> result = new LinkedList<>();
                    if(data.isEmpty())
                        throw new Error("Cannot fold an empty list.");
                    else if(data.size() == 1)
                        return data.get(0);
                    else {
                        Lists.reverse(data).stream().reduce((x, y) -> {
                            Atom a = arguments.get(0).getCallable().get().apply(env, Arrays.asList(y, x));
                            result.add(a);
                            return a;
                        }).get().get().get();
                        return Lists.reverse(result);
                    }
                }));
            }
        }));

        env.push("scanl1'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'scanl1''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'scanl1''", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Third argument to 'scanl1''", Type.LIST);
                    List<Atom> data = arguments.get(1).getList().get();
                    List<Atom> result = new LinkedList<>();
                    if(data.isEmpty())
                        throw new Error("Cannot fold an empty list.");
                    else if(data.size() == 1)
                        return data.get(0);
                    else {
                        data.stream().reduce((x, y) -> {
                            Atom a = arguments.get(0).getCallable().get().apply(env, Arrays.asList(x.eager(), y.eager())).eager();
                            result.add(a);
                            return a;
                        }).get().get().get();
                        return result;
                    }
                }));
            }
        }));

        env.push("scanr1'", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 2)
                    throw new Error("Invalid invocation to 'scanr1''.");
                return new Atom(new LbcSupplier<>(() -> {
                    arguments.get(0).guardType("First argument to 'scanr1''", Type.CLOSURE, Type.MACRO);
                    arguments.get(1).guardType("Second argument to 'scanr1''", Type.LIST);
                    List<Atom> data = arguments.get(1).getList().get();
                    List<Atom> result = new LinkedList<>();
                    if(data.isEmpty())
                        throw new Error("Cannot fold an empty list.");
                    else if(data.size() == 1)
                        return data.get(0);
                    else {
                        Lists.reverse(data).stream().reduce((x, y) -> {
                            Atom a = arguments.get(0).getCallable().get().apply(env, Arrays.asList(y.eager(), x.eager())).eager();
                            result.add(a);
                            return a;
                        }).get().get().get();
                        return Lists.reverse(result);
                    }
                }));
            }
        }));
    }
}
