package palaiologos.kamilalisp.runtime.graph;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.AbstractList;
import java.util.List;

public class ChordalGraphMaximumCliqueFinder extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        var clique = new org.jgrapht.alg.clique.ChordalGraphMaxCliqueFinder<>(wp.getGraph());
        Atom[] data = clique.getClique().toArray(Atom[]::new);
        return new Atom(new AbstractList<>() {
            @Override
            public Atom get(int index) {
                return data[index];
            }

            @Override
            public int size() {
                return data.length;
            }
        });
    }

    @Override
    protected String name() {
        return "graph:chordal-graph-maximum-clique-finder";
    }
}
