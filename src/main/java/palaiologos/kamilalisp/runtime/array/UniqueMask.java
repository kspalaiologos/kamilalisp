package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.List;

public class UniqueMask extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        List<Atom> list = args.get(0).getList();
        List<Atom> mask = new ArrayList<>(list.size());
        for (int i = 0; i < list.size(); i++) {
            mask.set(i, Atom.TRUE);
            for (int j = 0; j < i; j++) {
                if (list.get(i).equals(list.get(j))) {
                    mask.set(i, Atom.FALSE);
                    break;
                }
            }
        }
        return new Atom(mask);
    }

    @Override
    protected String name() {
        return "unique-mask";
    }
}
