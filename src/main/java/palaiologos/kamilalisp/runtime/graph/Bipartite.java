package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.partition.BipartitePartitioning;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Bipartite extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        var partitioning = new BipartitePartitioning<>(wp.getGraph());
        Map<Atom, Atom> data = Map.ofEntries(
                Map.entry(new Atom("is-bipartite?"), new Atom(partitioning.isBipartite())),
                Map.entry(new Atom("partitions"), new Atom(
                        partitioning.getPartitioning().getPartitions().stream()
                                .map(x -> new Atom(new ArrayList<>(x))).toList()))
        );
        return new Atom(new HashMapUserData(HashTreePMap.from(data)));
    }

    @Override
    protected String name() {
        return "graph:bipartite";
    }
}
