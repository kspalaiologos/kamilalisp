package palaiologos.kamilalisp.runtime.ide.terminal;

import org.armedbear.lisp.Throw;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.ide.IDEStatusBar;

import javax.swing.*;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;
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
                        throw new RuntimeException("ide:status-bar:add: workspace already exists");
                    tp.addWorkspace(name);
                    return Atom.NULL;
                });
            } else {
                throw new RuntimeException("ide:status-bar:add: too many arguments");
            }
        }

        @Override
        protected String name() {
            return "ide:status-bar:add";
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
                throw new RuntimeException("ide:status-bar:add: too many arguments");
            }
        }

        @Override
        protected String name() {
            return "ide:status-bar:has";
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
                    throw new TypeError("ide:status-bar:delete: expected string or integer, got " + args.get(0).getType().toString());
                }
            } else {
                throw new RuntimeException("ide:status-bar:delete: too many arguments");
            }
        }

        @Override
        protected String name() {
            return "ide:status-bar:delete";
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
                    throw new TypeError("ide:status-bar:select: expected string or integer, got " + args.get(0).getType().toString());
                }
            } else {
                throw new RuntimeException("ide:status-bar:select: too many arguments");
            }
        }

        @Override
        protected String name() {
            return "ide:status-bar:select";
        }
    }

    public static void register(Environment e, TerminalPanel tp, IDEStatusBar sb) {
        e.setPrimitive("term:clear", new Atom(new TerminalClear(tp)));
        e.setPrimitive("ide:status-bar:add", new Atom(new IdeStatusBarAdd(sb)));
        e.setPrimitive("ide:status-bar:has", new Atom(new IdeStatusBarHas(sb)));
        e.setPrimitive("ide:status-bar:delete", new Atom(new IdeStatusBarDelete(sb)));
        e.setPrimitive("ide:status-bar:select", new Atom(new IdeStatusBarSelect(sb)));
    }
}
