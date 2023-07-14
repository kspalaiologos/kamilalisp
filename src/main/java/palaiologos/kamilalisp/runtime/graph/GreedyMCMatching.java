package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.matching.GreedyMaximumCardinalityMatching;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class GreedyMCMatching extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        boolean sort = args.get(1).coerceBool();
        return MatchingAlgorithmWrapper.wrap(new GreedyMaximumCardinalityMatching<>(wp.getGraph(), sort).getMatching());
    }

    @Override
    protected String name() {
        return "graph:greedy-mc-matching";
    }
}
