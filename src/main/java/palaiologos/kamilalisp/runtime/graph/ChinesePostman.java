package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.cycle.BergeGraphInspector;
import org.jgrapht.graph.DefaultEdge;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class ChinesePostman extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        var inspector = new org.jgrapht.alg.cycle.ChinesePostman<Atom, DefaultEdge>();
        return new Atom(new GraphPath(inspector.getCPPSolution(wp.getGraph())));
    }

    @Override
    protected String name() {
        return "graph:chinese-postman";
    }
}
