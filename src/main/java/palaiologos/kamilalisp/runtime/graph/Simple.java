package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.Graph;
import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.graph.SimpleGraph;
import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.Map;

public class Simple extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        List<Atom> vertices = args.get(0).getList();
        List<Pair<Atom, Atom>> edges = args.get(1).getList().stream().map(x -> new Pair<>(x.getList().get(0), x.getList().get(1))).toList();
        Graph<Atom, DefaultEdge> graph = new SimpleGraph<>(DefaultEdge.class);
        vertices.forEach(graph::addVertex);
        edges.forEach(x -> graph.addEdge(x.fst(), x.snd()));
        return new Atom(new GraphWrapper(graph, () -> new SimpleGraph<>(DefaultEdge.class), Map.ofEntries()));
    }

    @Override
    protected String name() {
        return "graph:simple";
    }
}
