package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.cycle.ChordalityInspector;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class ChordalityCheck extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        var inspector = new ChordalityInspector<>(wp.getGraph());
        return new Atom(List.of(inspector.isChordal() ? Atom.TRUE : Atom.FALSE, new Atom(new GraphPath(inspector.getHole()))));
    }

    @Override
    protected String name() {
        return "graph:is-chordal-graph";
    }
}
