package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.AbstractList;
import java.util.List;

public class Explode extends PrimitiveFunction implements Lambda {
    static class StringList extends AbstractList<Atom> {
        private final String string;

        StringList(String string) {
            this.string = string;
        }

        @Override
        public Atom get(int index) {
            return new Atom(String.valueOf(string.charAt(index)));
        }

        @Override
        public int size() {
            return string.length();
        }
    }

    @Override
    protected String name() {
        return "str:explode";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        return new Atom(new StringList(args.get(0).getString()));
    }
}
