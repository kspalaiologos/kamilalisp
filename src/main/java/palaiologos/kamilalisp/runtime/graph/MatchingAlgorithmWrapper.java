package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.interfaces.MatchingAlgorithm;
import org.jgrapht.graph.DefaultEdge;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

public class MatchingAlgorithmWrapper {
    public static Atom wrap(MatchingAlgorithm.Matching<Atom, DefaultEdge> e) {
        Map<Atom, Atom> data = Map.ofEntries(
                Map.entry(new Atom("weight"), new Atom(BigDecimal.valueOf(e.getWeight()))),
                Map.entry(new Atom("edges"), new Atom(e.getEdges().stream().map(defaultEdge -> new Atom(List.of(
                        e.getGraph().getEdgeSource(defaultEdge),
                        e.getGraph().getEdgeTarget(defaultEdge)
                ))).toList())),
                Map.entry(new Atom("is-perfect?"), new Atom(e.isPerfect())),
                Map.entry(new Atom("is-matched?"), new Atom(new IsMatched(e)))
        );
        return new Atom(new HashMapUserData(HashTreePMap.from(data)));
    }

    private static class IsMatched extends PrimitiveFunction implements Lambda {
        private final MatchingAlgorithm.Matching<Atom, DefaultEdge> e;

        public IsMatched(MatchingAlgorithm.Matching<Atom, DefaultEdge> e) {
            this.e = e;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            return new Atom(e.isMatched(vertex));
        }

        @Override
        protected String name() {
            return "graph:matching.is-matched?";
        }
    }
}
