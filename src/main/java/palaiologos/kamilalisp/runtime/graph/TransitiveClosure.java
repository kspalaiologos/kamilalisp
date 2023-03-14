package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.graph.DirectedAcyclicGraph;
import org.jgrapht.graph.SimpleDirectedGraph;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class TransitiveClosure extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper graph = args.get(0).getUserdata(GraphWrapper.class);
        if(graph.getGraph() instanceof DirectedAcyclicGraph<Atom, DefaultEdge>) {
            return graph.adjoin(g -> {
                org.jgrapht.alg.TransitiveClosure.INSTANCE.closeDirectedAcyclicGraph((DirectedAcyclicGraph<Atom, DefaultEdge>) g);
            });
        } else if(graph.getGraph() instanceof SimpleDirectedGraph<Atom, DefaultEdge>) {
            return graph.adjoin(g -> {
                org.jgrapht.alg.TransitiveClosure.INSTANCE.closeSimpleDirectedGraph((SimpleDirectedGraph<Atom, DefaultEdge>) g);
            });
        } else {
            throw new IllegalArgumentException("Expected a directed acyclic graph or simple directed graph.");
        }
    }

    @Override
    protected String name() {
        return "graph:transitive-closure";
    }
}
