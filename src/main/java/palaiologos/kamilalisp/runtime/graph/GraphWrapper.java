package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.Graph;
import org.jgrapht.Graphs;
import org.jgrapht.graph.DefaultEdge;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.function.Supplier;

public class GraphWrapper implements Userdata {
    public class HasVertex extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            return graph.containsVertex(vertex) ? Atom.TRUE : Atom.FALSE;
        }

        @Override
        protected String name() {
            return "graph.has-vertex?";
        }
    }

    public class HasEdge extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 2) {
                Atom source = args.get(0);
                Atom target = args.get(1);
                return graph.containsEdge(source, target) ? Atom.TRUE : Atom.FALSE;
            } else if(args.size() == 1) {
                List<Atom> edge = args.get(0).getList();
                Atom source = edge.get(0);
                Atom target = edge.get(1);
                return graph.containsEdge(source, target) ? Atom.TRUE : Atom.FALSE;
            } else {
                throw new TypeError("Wrong number of arguments to graph.has-edge?");
            }
        }

        @Override
        protected String name() {
            return "graph.has-edge?";
        }
    }

    public class EdgesOf extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            List<Atom> edges = new ArrayList<>();
            for(DefaultEdge edge : graph.edgesOf(vertex)) {
                List<Atom> edgeList = new ArrayList<>();
                edgeList.add(graph.getEdgeSource(edge));
                edgeList.add(graph.getEdgeTarget(edge));
                edges.add(new Atom(edgeList));
            }
            return new Atom(edges);
        }

        @Override
        protected String name() {
            return "graph.edges-of";
        }
    }

    public class IncomingEdgesOf extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            List<Atom> edges = new ArrayList<>();
            for(DefaultEdge edge : graph.incomingEdgesOf(vertex)) {
                List<Atom> edgeList = new ArrayList<>();
                edgeList.add(graph.getEdgeSource(edge));
                edgeList.add(graph.getEdgeTarget(edge));
                edges.add(new Atom(edgeList));
            }
            return new Atom(edges);
        }

        @Override
        protected String name() {
            return "graph.incoming-edges-of";
        }
    }

    public class OutgoingEdgesOf extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            List<Atom> edges = new ArrayList<>();
            for(DefaultEdge edge : graph.outgoingEdgesOf(vertex)) {
                List<Atom> edgeList = new ArrayList<>();
                edgeList.add(graph.getEdgeSource(edge));
                edgeList.add(graph.getEdgeTarget(edge));
                edges.add(new Atom(edgeList));
            }
            return new Atom(edges);
        }

        @Override
        protected String name() {
            return "graph.outgoing-edges-of";
        }
    }

    public class AdjoinVertex extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
            Graphs.addGraph(empty, graph);
            empty.addVertex(vertex);
            return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
        }

        @Override
        protected String name() {
            return "graph.adjoin-vertex";
        }
    }

    public class AdjoinEdge extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 2) {
                Atom source = args.get(0);
                Atom target = args.get(1);
                Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
                Graphs.addGraph(empty, graph);
                empty.addEdge(source, target);
                return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
            } else if(args.size() == 1) {
                List<Atom> edge = args.get(0).getList();
                Atom source = edge.get(0);
                Atom target = edge.get(1);
                Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
                Graphs.addGraph(empty, graph);
                empty.addEdge(source, target);
                return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
            } else {
                throw new TypeError("Wrong number of arguments to graph.adjoin-edge");
            }
        }

        @Override
        protected String name() {
            return "graph.adjoin-edge";
        }
    }

    public class DegreeOf extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            return new Atom(BigInteger.valueOf(graph.degreeOf(vertex)));
        }

        @Override
        protected String name() {
            return "graph.degree-of";
        }
    }

    public class MinusEdge extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 2) {
                Atom source = args.get(0);
                Atom target = args.get(1);
                Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
                Graphs.addGraph(empty, graph);
                empty.removeEdge(source, target);
                return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
            } else if(args.size() == 1) {
                List<Atom> edge = args.get(0).getList();
                Atom source = edge.get(0);
                Atom target = edge.get(1);
                Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
                Graphs.addGraph(empty, graph);
                empty.removeEdge(source, target);
                return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
            } else {
                throw new TypeError("Wrong number of arguments to graph.minus-edge");
            }
        }

        @Override
        protected String name() {
            return "graph.minus-edge";
        }
    }

    public class MinusVertex extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
            Graphs.addGraph(empty, graph);
            empty.removeVertex(vertex);
            return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
        }

        @Override
        protected String name() {
            return "graph.minus-vertex";
        }
    }

    public class AdjoinVertexSet extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            List<Atom> vertices = args.get(0).getList();
            Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
            Graphs.addGraph(empty, graph);
            for(Atom vertex : vertices)
                empty.addVertex(vertex);
            return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
        }

        @Override
        protected String name() {
            return "graph.adjoin-vertex-set";
        }
    }

    public class AdjoinEdgeSet extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            List<Atom> edges = args.get(0).getList();
            Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
            Graphs.addGraph(empty, graph);
            for(Atom edge : edges) {
                List<Atom> edgeList = edge.getList();
                empty.addEdge(edgeList.get(0), edgeList.get(1));
            }
            return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
        }

        @Override
        protected String name() {
            return "graph.adjoin-edge-set";
        }
    }

    public class MinusVertexSet extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            List<Atom> vertices = args.get(0).getList();
            Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
            Graphs.addGraph(empty, graph);
            for(Atom vertex : vertices)
                empty.removeVertex(vertex);
            return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
        }

        @Override
        protected String name() {
            return "graph.minus-vertex-set";
        }
    }

    public class MinusEdgeSet extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            List<Atom> edges = args.get(0).getList();
            Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
            Graphs.addGraph(empty, graph);
            for(Atom edge : edges) {
                List<Atom> edgeList = edge.getList();
                empty.removeEdge(edgeList.get(0), edgeList.get(1));
            }
            return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
        }

        @Override
        protected String name() {
            return "graph.minus-edge-set";
        }
    }

    public class WeightOf extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 2) {
                Atom source = args.get(0);
                Atom target = args.get(1);
                return new Atom(BigDecimal.valueOf(graph.getEdgeWeight(graph.getEdge(source, target))));
            } else if(args.size() == 1) {
                List<Atom> edge = args.get(0).getList();
                Atom source = edge.get(0);
                Atom target = edge.get(1);
                return new Atom(BigDecimal.valueOf(graph.getEdgeWeight(graph.getEdge(source, target))));
            } else {
                throw new TypeError("Wrong number of arguments to graph.weight-of");
            }
        }

        @Override
        protected String name() {
            return "graph.weight-of";
        }
    }

    public class SetWeight extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 3) {
                Atom source = args.get(0);
                Atom target = args.get(1);
                Atom weight = args.get(2);
                Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
                Graphs.addGraph(empty, graph);
                empty.setEdgeWeight(empty.getEdge(source, target), weight.getReal().doubleValue());
                return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
            } else if(args.size() == 2) {
                List<Atom> edge = args.get(0).getList();
                Atom source = edge.get(0);
                Atom target = edge.get(1);
                Atom weight = args.get(1);
                Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
                Graphs.addGraph(empty, graph);
                empty.setEdgeWeight(empty.getEdge(source, target), weight.getReal().doubleValue());
                return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
            } else {
                throw new TypeError("Wrong number of arguments to graph.set-weight");
            }
        }

        @Override
        protected String name() {
            return "graph.adjoin-weight";
        }
    }

    public class SetWeights extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            List<Atom> edges = args.get(0).getList();
            Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
            Graphs.addGraph(empty, graph);
            for(Atom edge : edges) {
                List<Atom> edgeList = edge.getList();
                empty.setEdgeWeight(empty.getEdge(edgeList.get(0), edgeList.get(1)), edgeList.get(2).getReal().doubleValue());
            }
            return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations));
        }

        @Override
        protected String name() {
            return "graph.adjoin-weights";
        }
    }

    private final Graph<Atom, DefaultEdge> graph;
    private final Supplier<Graph<Atom, DefaultEdge>> emptyGraphFactory;
    private final Map<String, Function<Graph<Atom, DefaultEdge>, Atom>> extraOperations;

    public GraphWrapper(Graph<Atom, DefaultEdge> graph, Supplier<Graph<Atom, DefaultEdge>> emptyGraphFactory, Map<String, Function<Graph<Atom, DefaultEdge>, Atom>> extraOperations) {
        this.graph = graph;
        this.emptyGraphFactory = emptyGraphFactory;
        this.extraOperations = extraOperations;
    }

    @Override
    public Atom field(Object key) {
        if(!(key instanceof String))
            throw new IllegalArgumentException("Graph field name must be a string");
        switch ((String) key) {
            case "vertices" -> {
                List<Atom> vertices = new ArrayList<>(graph.vertexSet());
                return new Atom(vertices);
            }
            case "edges" -> {
                List<Atom> edges = new ArrayList<>();
                for (DefaultEdge edge : graph.edgeSet()) {
                    List<Atom> edgeList = new ArrayList<>();
                    edgeList.add(graph.getEdgeSource(edge));
                    edgeList.add(graph.getEdgeTarget(edge));
                    edges.add(new Atom(edgeList));
                }
                return new Atom(edges);
            }
            case "has-vertex?" -> {
                return new Atom(new HasVertex());
            }
            case "has-edge?" -> {
                return new Atom(new HasEdge());
            }
            case "edges-of" -> {
                return new Atom(new EdgesOf());
            }
            case "incoming-edges-of" -> {
                return new Atom(new IncomingEdgesOf());
            }
            case "outgoing-edges-of" -> {
                return new Atom(new OutgoingEdgesOf());
            }
            case "adjoin-vertex" -> {
                return new Atom(new AdjoinVertex());
            }
            case "adjoin-edge" -> {
                return new Atom(new AdjoinEdge());
            }
            case "degree-of" -> {
                return new Atom(new DegreeOf());
            }
            case "minus-edge" -> {
                return new Atom(new MinusEdge());
            }
            case "minus-vertex" -> {
                return new Atom(new MinusVertex());
            }
            case "adjoin-vertex-set" -> {
                return new Atom(new AdjoinVertexSet());
            }
            case "adjoin-edge-set" -> {
                return new Atom(new AdjoinEdgeSet());
            }
            case "minus-vertex-set" -> {
                return new Atom(new MinusVertexSet());
            }
            case "minus-edge-set" -> {
                return new Atom(new MinusEdgeSet());
            }
            case "weight-of" -> {
                return new Atom(new WeightOf());
            }
            case "adjoin-weight" -> {
                return new Atom(new SetWeight());
            }
            case "adjoin-weights" -> {
                return new Atom(new SetWeights());
            }
            default -> {
                if(extraOperations.containsKey(key))
                    return extraOperations.get(key).apply(graph);
                throw new IllegalArgumentException("Graph has no field " + key);
            }
        }
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
