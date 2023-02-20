package palaiologos.kamilalisp.runtime.ide.terminal;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.ide.IDEStatusBar;

import javax.swing.*;
import java.lang.reflect.InvocationTargetException;
import java.math.BigInteger;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Supplier;

public class TerminalPrimitiveRegistry {
    private static <T> T invokeSwing(Supplier<T> r) {
        try {
            AtomicReference<T> ref = new AtomicReference<>();
            AtomicReference<RuntimeException> ex = new AtomicReference<>();
            SwingUtilities.invokeAndWait(() -> {
                try {
                    ref.set(r.get());
                } catch (Throwable e) {
                    if (e instanceof RuntimeException) {
                        ex.set((RuntimeException) e);
                    } else {
                        ex.set(new RuntimeException(e));
                    }
                }
            });
            if(ex.get() != null)
                throw ex.get();
            return ref.get();
        } catch (InterruptedException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    private static class TerminalClear extends PrimitiveFunction implements Lambda {
        private TerminalPanel tp;

        public TerminalClear(TerminalPanel tp) {
            this.tp = tp;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return invokeSwing(() -> {
                tp.area.setText("");
                tp.gutter.setText("");
                return Atom.NULL;
            });
        }

        @Override
        protected String name() {
            return "term:clear";
        }
    }

    private static class IdeStatusBarAdd extends PrimitiveFunction implements Lambda {
        private IDEStatusBar tp;

        public IdeStatusBarAdd(IDEStatusBar tp) {
            this.tp = tp;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 0) {
                return invokeSwing(() -> {
                    tp.addWorkspace();
                    return Atom.NULL;
                });
            } else if(args.size() == 1) {
                String name = args.get(0).getString();
                return invokeSwing(() -> {
                    if(tp.hasWorkspace(name))
                        throw new RuntimeException("ide:workspace:add: workspace already exists");
                    tp.addWorkspace(name);
                    return Atom.NULL;
                });
            } else {
                throw new RuntimeException("ide:workspace:add: expected zero or one arguments");
            }
        }

        @Override
        protected String name() {
            return "ide:workspace:add";
        }
    }

    private static class IdeStatusBarHas extends PrimitiveFunction implements Lambda {
        private IDEStatusBar tp;

        public IdeStatusBarHas(IDEStatusBar tp) {
            this.tp = tp;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 1) {
                String name = args.get(0).getString();
                return invokeSwing(() -> new Atom(tp.hasWorkspace(name)));
            } else {
                throw new RuntimeException("ide:workspace:add: expected one argument");
            }
        }

        @Override
        protected String name() {
            return "ide:workspace:has";
        }
    }

    private static class IdeStatusBarDelete extends PrimitiveFunction implements Lambda {
        private IDEStatusBar tp;

        public IdeStatusBarDelete(IDEStatusBar tp) {
            this.tp = tp;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 1) {
                if(args.get(0).getType() == Type.STRING) {
                    String name = args.get(0).getString();
                    return invokeSwing(() -> {
                        tp.deleteWorkspace(name);
                        return Atom.NULL;
                    });
                } else if(args.get(0).getType() == Type.INTEGER) {
                    int index = args.get(0).getInteger().intValueExact();
                    return invokeSwing(() -> {
                        tp.deleteWorkspace(index);
                        return Atom.NULL;
                    });
                } else {
                    throw new TypeError("ide:workspace:delete: expected string or integer, got " + args.get(0).getType().toString());
                }
            } else {
                throw new RuntimeException("ide:workspace:delete: expected one argument");
            }
        }

        @Override
        protected String name() {
            return "ide:workspace:delete";
        }
    }

    private static class IdeStatusBarSelect extends PrimitiveFunction implements Lambda {
        private IDEStatusBar tp;

        public IdeStatusBarSelect(IDEStatusBar tp) {
            this.tp = tp;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 1) {
                if(args.get(0).getType() == Type.STRING) {
                    String name = args.get(0).getString();
                    return invokeSwing(() -> {
                        tp.selectWorkspace(name);
                        return Atom.NULL;
                    });
                } else if(args.get(0).getType() == Type.INTEGER) {
                    int index = args.get(0).getInteger().intValueExact();
                    return invokeSwing(() -> {
                        tp.selectWorkspace(index);
                        return Atom.NULL;
                    });
                } else {
                    throw new TypeError("ide:workspace:select: expected string or integer, got " + args.get(0).getType().toString());
                }
            } else {
                throw new RuntimeException("ide:workspace:select: expected one argument");
            }
        }

        @Override
        protected String name() {
            return "ide:workspace:select";
        }
    }

    private static class IdeStatusBarRename extends PrimitiveFunction implements Lambda {
        private IDEStatusBar tp;

        public IdeStatusBarRename(IDEStatusBar tp) {
            this.tp = tp;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 2) {
                if(args.get(0).getType() == Type.STRING) {
                    String name = args.get(0).getString();
                    String dest = args.get(1).getString();
                    return invokeSwing(() -> {
                        tp.renameWorkspace(name, dest);
                        return Atom.NULL;
                    });
                } else if(args.get(0).getType() == Type.INTEGER) {
                    int index = args.get(0).getInteger().intValueExact();
                    String dest = args.get(1).getString();
                    return invokeSwing(() -> {
                        tp.renameWorkspace(index, dest);
                        return Atom.NULL;
                    });
                } else {
                    throw new TypeError("ide:workspace:rename: expected string or integer, got " + args.get(0).getType().toString());
                }
            } else {
                throw new RuntimeException("ide:workspace:rename: expected two arguments");
            }
        }

        @Override
        protected String name() {
            return "ide:workspace:rename";
        }
    }

    private static class IdeStatusBarSwap extends PrimitiveFunction implements Lambda {
        private IDEStatusBar tp;

        public IdeStatusBarSwap(IDEStatusBar tp) {
            this.tp = tp;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 2) {
                int srcIdx = args.get(0).getInteger().intValueExact();
                int destIdx = args.get(1).getInteger().intValueExact();
                return invokeSwing(() -> {
                    tp.swapWorkspaces(srcIdx, destIdx);
                    return Atom.NULL;
                });
            } else {
                throw new RuntimeException("ide:workspace:swap: expected two arguments");
            }
        }

        @Override
        protected String name() {
            return "ide:workspace:swap";
        }
    }

    private static class IdeStatusBarCurrent extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
        private IDEStatusBar tp;

        public IdeStatusBarCurrent(IDEStatusBar tp) {
            this.tp = tp;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return invokeSwing(() -> {
                Pair<Integer, String> pair = tp.currentWorkspace();
                return new Atom(List.of(new Atom(BigInteger.valueOf(pair.fst())), new Atom(pair.snd())));
            });
        }

        @Override
        protected String name() {
            return "ide:workspace:current";
        }
    }

    public static void register(Environment e, TerminalPanel tp, IDEStatusBar sb) {
        e.setPrimitive("term:clear", new Atom(new TerminalClear(tp)));
        e.setPrimitive("ide:workspace:add", new Atom(new IdeStatusBarAdd(sb)));
        e.setPrimitive("ide:workspace:has", new Atom(new IdeStatusBarHas(sb)));
        e.setPrimitive("ide:workspace:delete", new Atom(new IdeStatusBarDelete(sb)));
        e.setPrimitive("ide:workspace:select", new Atom(new IdeStatusBarSelect(sb)));
        e.setPrimitive("ide:workspace:rename", new Atom(new IdeStatusBarRename(sb)));
        e.setPrimitive("ide:workspace:current", new Atom(new IdeStatusBarCurrent(sb)));
        e.setPrimitive("ide:workspace:swap", new Atom(new IdeStatusBarSwap(sb)));
    }
}
