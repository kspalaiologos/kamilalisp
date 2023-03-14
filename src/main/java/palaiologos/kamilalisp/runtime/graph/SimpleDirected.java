package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.graph.SimpleDirectedGraph;
import org.jgrapht.graph.SimpleGraph;
import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.Map;

public class SimpleDirected extends PrimitiveFunction implements Lambda {
    public static GraphWrapper wrap(SimpleDirectedGraph<Atom, DefaultEdge> graph) {
        return new GraphWrapper(graph, () -> new SimpleDirectedGraph<>(DefaultEdge.class), Map.ofEntries(), "simple-directed-graph");
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        List<Atom> vertices = args.get(0).getList();
        List<Pair<Atom, Atom>> edges = args.get(1).getList().stream().map(x -> new Pair<>(x.getList().get(0), x.getList().get(1))).toList();
        SimpleDirectedGraph<Atom, DefaultEdge> graph = new SimpleDirectedGraph<>(DefaultEdge.class);
        vertices.forEach(graph::addVertex);
        edges.forEach(x -> graph.addEdge(x.fst(), x.snd()));
        return new Atom(wrap(graph));
    }

    @Override
    protected String name() {
        return "graph:simple-directed";
    }
}
