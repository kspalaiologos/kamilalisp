package palaiologos.kamilalisp.runtime.graph;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class BronKerboschCliqueFinder extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        var clique = new org.jgrapht.alg.clique.BronKerboschCliqueFinder<>(wp.getGraph());
        List<Atom> cliques = new ArrayList<>();
        for (Set<Atom> c : clique)
            cliques.add(new Atom(new ArrayList<>(c)));
        return new Atom(cliques);
    }

    @Override
    protected String name() {
        return "graph:bron-kerbosch-clique-finder";
    }
}
