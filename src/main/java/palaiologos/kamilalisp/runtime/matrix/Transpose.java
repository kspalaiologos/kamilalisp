package palaiologos.kamilalisp.runtime.matrix;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.error.TypeError;

import java.util.AbstractList;
import java.util.List;
import java.util.stream.Collectors;

public class Transpose extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1)
            throw new TypeError("matrix:transpose takes exactly one argument");
        List<Atom> arg = args.get(0).getList();
        if (arg.isEmpty())
            return Atom.NULL;
        // Assert all members are of the same length:
        if (arg.stream().map(x -> x.getList().size()).distinct().count() != 1)
            throw new TypeError("matrix:transpose takes a matrix as argument");
        if (arg.get(0).getList().isEmpty())
            return args.get(0);
        return new Atom(new AbstractList<Atom>() {
            @Override
            public int size() {
                return arg.get(0).getList().size();
            }

            @Override
            public Atom get(int index) {
                if (index < 0 || index >= size())
                    throw new IndexOutOfBoundsException();
                return new Atom(arg.stream().map(x -> x.getList().get(index)).collect(Collectors.toList()));
            }
        });
    }

    @Override
    protected String name() {
        return "matrix:transpose";
    }
}
