package palaiologos.kamilalisp.runtime.graph.type;

import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.graph.DirectedWeightedMultigraph;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.graph.GraphWrapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public class MultiDirectedWeighted extends PrimitiveFunction implements Lambda {
    public static class WeightOf extends PrimitiveFunction implements Lambda {
        private final GraphWrapper w;

        public WeightOf(GraphWrapper w) {
            this.w = w;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 2) {
                Atom source = args.get(0);
                Atom target = args.get(1);
                return new Atom(BigDecimal.valueOf(w.getGraph().getEdgeWeight(w.getGraph().getEdge(source, target))));
            } else if(args.size() == 1) {
                List<Atom> edge = args.get(0).getList();
                Atom source = edge.get(0);
                Atom target = edge.get(1);
                return new Atom(BigDecimal.valueOf(w.getGraph().getEdgeWeight(w.getGraph().getEdge(source, target))));
            } else {
                throw new TypeError("Wrong number of arguments to graph.weight-of");
            }
        }

        @Override
        protected String name() {
            return "graph.weight-of";
        }
    }

    public static class SetWeight extends PrimitiveFunction implements Lambda {
        private final GraphWrapper w;

        public SetWeight(GraphWrapper w) {
            this.w = w;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 3) {
                Atom source = args.get(0);
                Atom target = args.get(1);
                Atom weight = args.get(2);
                return w.adjoin(g -> {
                    g.setEdgeWeight(g.getEdge(source, target), weight.getReal().doubleValue());
                });
            } else if(args.size() == 2) {
                List<Atom> edge = args.get(0).getList();
                Atom source = edge.get(0);
                Atom target = edge.get(1);
                Atom weight = args.get(1);
                return w.adjoin(g -> {
                    g.setEdgeWeight(g.getEdge(source, target), weight.getReal().doubleValue());
                });
            } else {
                throw new TypeError("Wrong number of arguments to graph.set-weight");
            }
        }

        @Override
        protected String name() {
            return "graph.adjoin-weight";
        }
    }

    public static class SetWeights extends PrimitiveFunction implements Lambda {
        private final GraphWrapper w;

        public SetWeights(GraphWrapper w) {
            this.w = w;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            List<Atom> edges = args.get(0).getList();
            return w.adjoin(g -> {
                for(Atom edge : edges) {
                    List<Atom> edgeList = edge.getList();
                    g.setEdgeWeight(g.getEdge(edgeList.get(0), edgeList.get(1)), edgeList.get(2).getReal().doubleValue());
                }
            });
        }

        @Override
        protected String name() {
            return "graph.adjoin-weights";
        }
    }

    public static GraphWrapper wrap(DirectedWeightedMultigraph<Atom, DefaultEdge> graph) {
        return new GraphWrapper(graph, () -> new DirectedWeightedMultigraph<>(DefaultEdge.class), Map.ofEntries(
                Map.entry("weight-of", e -> new Atom(new WeightOf(e))),
                Map.entry("adjoin-weight", e -> new Atom(new SetWeight(e))),
                Map.entry("adjoin-weights", e -> new Atom(new SetWeights(e)))
        ), "weighted-directed-multigraph");
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        List<Atom> vertices = args.get(0).getList();
        List<Pair<Atom, Atom>> edges = args.get(1).getList().stream().map(x -> new Pair<>(x.getList().get(0), x.getList().get(1))).toList();
        DirectedWeightedMultigraph<Atom, DefaultEdge> graph = new DirectedWeightedMultigraph<>(DefaultEdge.class);
        vertices.forEach(graph::addVertex);
        edges.forEach(x -> graph.addEdge(x.fst(), x.snd()));
        return new Atom(wrap(graph));
    }

    @Override
    protected String name() {
        return "graph:multi-directed-weighted";
    }
}
