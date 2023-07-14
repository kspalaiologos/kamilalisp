package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.matching.KuhnMunkresMinimalWeightBipartitePerfectMatching;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class KuhnMunkresMWBipartitePerfectMatching extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        Set<Atom> p1 = new HashSet<>(args.get(1).getList());
        Set<Atom> p2 = new HashSet<>(args.get(2).getList());
        return MatchingAlgorithmWrapper.wrap(new KuhnMunkresMinimalWeightBipartitePerfectMatching<>(wp.getGraph(), p1, p2).getMatching());
    }

    @Override
    protected String name() {
        return "graph:kuhn-munkres-mw-bipartite-perfect-matching";
    }
}
