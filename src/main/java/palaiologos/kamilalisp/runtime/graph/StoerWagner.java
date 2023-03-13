package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.StoerWagnerMinimumCut;
import org.jgrapht.graph.DefaultEdge;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class StoerWagner extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        StoerWagnerMinimumCut<Atom, DefaultEdge> cut = new StoerWagnerMinimumCut<>(wp.getGraph());
        Map<Atom, Atom> data = Map.ofEntries(
                Map.entry(new Atom("min-cut"), new Atom(new ArrayList<>(cut.minCut()))),
                Map.entry(new Atom("min-cut-weight"), new Atom(BigDecimal.valueOf(cut.minCutWeight())))
        );
        return new Atom(new HashMapUserData(HashTreePMap.from(data)));
    }

    @Override
    protected String name() {
        return "graph:stoer-wagner";
    }
}
