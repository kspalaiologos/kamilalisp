package palaiologos.kamilalisp.runtime.graph;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.List;

public class KSpanningClustering extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        int k = args.get(1).getInteger().intValueExact();
        var clustering = new org.jgrapht.alg.clustering.KSpanningTreeClustering<>(wp.getGraph(), k).getClustering();
        return new Atom(clustering.getClusters().stream().map(x -> new Atom(new ArrayList<>(x))).toList());
    }

    @Override
    protected String name() {
        return "graph:k-spanning-clustering";
    }
}
