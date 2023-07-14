package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.Graph;
import org.jgrapht.GraphMetrics;
import org.jgrapht.GraphTests;
import org.jgrapht.Graphs;
import org.jgrapht.graph.DefaultEdge;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.*;
import java.util.function.Consumer;
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
            return adjoin(g -> {
                g.addVertex(vertex);
            });
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
                return adjoin(g -> {
                    g.addEdge(source, target);
                });
            } else if(args.size() == 1) {
                List<Atom> edge = args.get(0).getList();
                Atom source = edge.get(0);
                Atom target = edge.get(1);
                return adjoin(g -> {
                    g.addEdge(source, target);
                });
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
                return adjoin(g -> {
                    g.removeEdge(source, target);
                });
            } else if(args.size() == 1) {
                List<Atom> edge = args.get(0).getList();
                Atom source = edge.get(0);
                Atom target = edge.get(1);
                return adjoin(g -> {
                    g.removeEdge(source, target);
                });
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
            return adjoin(g -> g.removeVertex(vertex));
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
            return adjoin(g -> {
                for(Atom vertex : vertices)
                    g.addVertex(vertex);
            });
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
            return adjoin(g -> {
                for(Atom edge : edges) {
                    List<Atom> edgeList = edge.getList();
                    g.addEdge(edgeList.get(0), edgeList.get(1));
                }
            });
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
            return adjoin(g -> {
                for(Atom vertex : vertices)
                    g.removeVertex(vertex);
            });
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
            return adjoin(g -> {
                for (Atom edge : edges) {
                    List<Atom> edgeList = edge.getList();
                    g.removeEdge(edgeList.get(0), edgeList.get(1));
                }
            });
        }

        @Override
        protected String name() {
            return "graph.minus-edge-set";
        }
    }

    public class VertexHasSuccessors extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            return Graphs.vertexHasSuccessors(graph, vertex) ? Atom.TRUE : Atom.FALSE;
        }

        @Override
        protected String name() {
            return "graph.vertex-has-successors";
        }
    }

    public class VertexHasPredecessors extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            return Graphs.vertexHasPredecessors(graph, vertex) ? Atom.TRUE : Atom.FALSE;
        }

        @Override
        protected String name() {
            return "graph.vertex-has-predecessors";
        }
    }

    public class IncidentTo extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            Atom vertex = args.get(0);
            Atom e1 = args.get(1).getList().get(0);
            Atom e2 = args.get(1).getList().get(1);
            return Graphs.testIncidence(graph, graph.getEdge(e1, e2), vertex) ? Atom.TRUE : Atom.FALSE;
        }

        @Override
        protected String name() {
            return "graph.incident-to";
        }
    }

    public class NeighboursOf extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Atom vertex = args.get(0);
            return new Atom(Graphs.neighborListOf(graph, vertex));
        }

        @Override
        protected String name() {
            return "graph.neighbours-of";
        }
    }

    public class Process extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            ArrayList<Atom> vertexSet = new ArrayList<>(graph.vertexSet());
            Set<DefaultEdge> edges = graph.edgeSet();
            ArrayList<Atom> edgeSet = new ArrayList<>();
            for (DefaultEdge edge : edges) {
                List<Atom> edgeList = new ArrayList<>(2);
                edgeList.add(graph.getEdgeSource(edge));
                edgeList.add(graph.getEdgeTarget(edge));
                edgeSet.add(new Atom(edgeList));
            }
            List<Atom> r = Evaluation.evaluate(env, args.get(0).getCallable(), List.of(new Atom(vertexSet), new Atom(edgeSet))).getList();
            Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
            for (Atom vertex : r.get(0).getList())
                empty.addVertex(vertex);
            for (Atom edge : r.get(1).getList()) {
                List<Atom> edgeList = edge.getList();
                empty.addEdge(edgeList.get(0), edgeList.get(1));
            }
            return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations, name));
        }

        @Override
        protected String name() {
            return "graph.process";
        }
    }

    public Atom adjoin(Consumer<Graph<Atom, DefaultEdge>> process) {
        Graph<Atom, DefaultEdge> empty = emptyGraphFactory.get();
        Graphs.addGraph(empty, graph);
        process.accept(empty);
        return new Atom(new GraphWrapper(empty, emptyGraphFactory, extraOperations, name));
    }

    private final Graph<Atom, DefaultEdge> graph;
    private final Supplier<Graph<Atom, DefaultEdge>> emptyGraphFactory;
    private final Map<String, Function<GraphWrapper, Atom>> extraOperations;
    private final String name;

    public Graph<Atom, DefaultEdge> getGraph() {
        return graph;
    }

    public GraphWrapper(Graph<Atom, DefaultEdge> graph, Supplier<Graph<Atom, DefaultEdge>> emptyGraphFactory, Map<String, Function<GraphWrapper, Atom>> extraOperations, String name) {
        this.graph = graph;
        this.emptyGraphFactory = emptyGraphFactory;
        this.extraOperations = extraOperations;
        this.name = name;
    }

    private Optional<Double> diameter = Optional.empty();
    private double getDiameter() {
        if(diameter.isEmpty()) {
            diameter = Optional.of(GraphMetrics.getDiameter(graph));
        }
        return diameter.get();
    }

    private Optional<Integer> girth = Optional.empty();
    private int getGirth() {
        if(girth.isEmpty()) {
            girth = Optional.of(GraphMetrics.getGirth(graph));
        }
        return girth.get();
    }

    private Optional<Double> radius = Optional.empty();
    private double getRadius() {
        if(radius.isEmpty()) {
            radius = Optional.of(GraphMetrics.getRadius(graph));
        }
        return radius.get();
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
            case "diameter" -> {
                return new Atom(BigDecimal.valueOf(getDiameter()));
            }
            case "girth" -> {
                return new Atom(BigInteger.valueOf(getGirth()));
            }
            case "radius" -> {
                return new Atom(BigDecimal.valueOf(getRadius()));
            }
            case "vertex-has-successors" -> {
                return new Atom(new VertexHasSuccessors());
            }
            case "vertex-has-predecessors" -> {
                return new Atom(new VertexHasPredecessors());
            }
            case "incident-to" -> {
                return new Atom(new IncidentTo());
            }
            case "neighbours-of" -> {
                return new Atom(new NeighboursOf());
            }
            case "has-multiple-edges?" -> {
                return GraphTests.hasMultipleEdges(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "has-self-loops?" -> {
                return GraphTests.hasSelfLoops(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "has-ore-property?" -> {
                return GraphTests.hasOreProperty(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-biconnected?" -> {
                return GraphTests.isBiconnected(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-connected?" -> {
                return GraphTests.isConnected(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-bipartite?" -> {
                return GraphTests.isBipartite(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-chordal?" -> {
                return GraphTests.isChordal(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-complete?" -> {
                return GraphTests.isComplete(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-empty?" -> {
                return GraphTests.isEmpty(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-eulerian?" -> {
                return GraphTests.isEulerian(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-forest?" -> {
                return GraphTests.isForest(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-k33-subdivision?" -> {
                return GraphTests.isK33Subdivision(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-k5-subdivision?" -> {
                return GraphTests.isK5Subdivision(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-kuratowski-subdivision?" -> {
                return GraphTests.isKuratowskiSubdivision(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-overfull?" -> {
                return GraphTests.isOverfull(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-perfect?" -> {
                return GraphTests.isPerfect(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-planar?" -> {
                return GraphTests.isPlanar(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-simple?" -> {
                return GraphTests.isSimple(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-strongly-connected?" -> {
                return GraphTests.isStronglyConnected(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "is-tree?" -> {
                return GraphTests.isTree(graph) ? Atom.TRUE : Atom.FALSE;
            }
            case "process" -> {
                return new Atom(new Process());
            }
            default -> {
                if(extraOperations.containsKey(key))
                    return extraOperations.get(key).apply(this);
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
        return name + " (" + graph.vertexSet().size() + " vertices, " + graph.edgeSet().size() + " edges)";
    }

    @Override
    public boolean coerceBoolean() {
        return graph.vertexSet().size() > 0;
    }
}
