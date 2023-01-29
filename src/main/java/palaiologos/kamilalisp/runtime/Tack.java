package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;

import java.util.List;

public class Tack implements Lambda {
    private final int[] indices;

    private final int l;
    private final int c;

    public Tack(int[] indices, int l, int c) {
        this.indices = indices;
        this.l = l;
        this.c = c;
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
    public Atom apply(Environment env, List<Atom> args) {
        if (indices.length == 1) {
            return args.get(indices[0]);
        } else {
            return new Atom(args.subList(indices[0], indices[1]));
        }
    }

    @Override
    public String stringify() {
        if (indices.length == 1) {
            return "#" + indices[0];
        } else {
            return "#" + indices[0] + "." + indices[1];
        }
    }

    @Override
    public String frameString() {
        return "#/syn";
    }
}
