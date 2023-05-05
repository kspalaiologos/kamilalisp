package palaiologos.kamilalisp.runtime.graph.type;

import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.graph.Pseudograph;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.graph.GraphWrapper;

import java.util.List;
import java.util.Map;

public class Pseudo extends PrimitiveFunction implements Lambda {
    public static GraphWrapper wrap(Pseudograph<Atom, DefaultEdge> graph) {
        return new GraphWrapper(graph, () -> new Pseudograph<>(DefaultEdge.class), Map.ofEntries(), "pseudograph");
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        List<Atom> vertices = args.get(0).getList();
        List<Pair<Atom, Atom>> edges = args.get(1).getList().stream().map(x -> new Pair<>(x.getList().get(0), x.getList().get(1))).toList();
        Pseudograph<Atom, DefaultEdge> graph = new Pseudograph<>(DefaultEdge.class);
        vertices.forEach(graph::addVertex);
        edges.forEach(x -> graph.addEdge(x.fst(), x.snd()));
        return new Atom(wrap(graph));
    }

    @Override
    protected String name() {
        return "graph:pseudo";
    }
}
