package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.Graph;
import org.jgrapht.graph.DefaultEdge;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;

public class GraphWrapper implements Userdata {
    private final Graph<Atom, DefaultEdge> graph;

    public GraphWrapper(Graph<Atom, DefaultEdge> graph) {
        this.graph = graph;
    }

    @Override
    public Atom field(Object key) {
        return null;
    }

    @Override
    public int hashCode() {
        return graph.hashCode();
    }

    @Override
    public int compareTo(Userdata other) {
        return hashCode() - other.hashCode();
    }

    @Override
    public boolean equals(Userdata other) {
        if(other instanceof GraphWrapper)
            return graph.equals(((GraphWrapper) other).graph);
        return false;
    }

    @Override
    public String toDisplayString() {
        return "Graph(" +
                "Vertices=[" + graph.vertexSet().stream().map(Atom::toDisplayString).reduce((x, y) -> x + ", " + y).orElse("") + "], " +
                "Edges=[" + graph.edgeSet().stream().map(x -> "(" + graph.getEdgeSource(x).toDisplayString() + " => " + graph.getEdgeTarget(x).toDisplayString() + ")").reduce((x, y) -> x + ", " + y).orElse("") + "])";
    }

    @Override
    public String typeName() {
        return "graph (" + graph.vertexSet().size() + " vertices, " + graph.edgeSet().size() + " edges)";
    }

    @Override
    public boolean coerceBoolean() {
        return graph.vertexSet().size() > 0;
    }
}
