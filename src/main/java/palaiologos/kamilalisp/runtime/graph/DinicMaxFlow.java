package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.flow.BoykovKolmogorovMFImpl;
import org.jgrapht.alg.flow.DinicMFImpl;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.util.List;

public class DinicMaxFlow extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        var inspector = new DinicMFImpl<>(wp.getGraph());
        Atom source = args.get(1);
        Atom sink = args.get(2);
        return new Atom(BigDecimal.valueOf(inspector.getMaximumFlow(source, sink).getValue()));
    }

    @Override
    protected String name() {
        return "graph:dinic-max-flow";
    }
}
