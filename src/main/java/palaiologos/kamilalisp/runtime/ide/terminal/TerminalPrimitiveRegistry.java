package palaiologos.kamilalisp.runtime.ide.terminal;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import javax.swing.*;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

public class TerminalPrimitiveRegistry {
    private static class TerminalClear extends PrimitiveFunction implements Lambda {
        private TerminalPanel tp;

        public TerminalClear(TerminalPanel tp) {
            this.tp = tp;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            try {
                SwingUtilities.invokeAndWait(() -> {
                    tp.area.setText("");
                    tp.gutter.setText("");
                });
            } catch (InterruptedException | InvocationTargetException e) {
                throw new RuntimeException(e);
            }

            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "term:clear";
        }
    }

    public static void register(Environment e, TerminalPanel tp) {
        e.setPrimitive("term:clear", new Atom(new TerminalClear(tp)));
    }
}
