package palaiologos.kamilalisp.runtime.graph;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class TransitiveReduction extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        return wp.adjoin(org.jgrapht.alg.TransitiveReduction.INSTANCE::reduce);
    }

    @Override
    protected String name() {
        return "graph:transitive-reduction";
    }
}
