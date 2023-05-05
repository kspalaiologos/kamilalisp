package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.graph.DefaultEdge;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;

import java.math.BigDecimal;
import java.math.BigInteger;

public class GraphPath implements Userdata {
    private final org.jgrapht.GraphPath<Atom, DefaultEdge> path;

    public GraphPath(org.jgrapht.GraphPath<Atom, DefaultEdge> path) {
        this.path = path;
    }

    @Override
    public Atom field(Object key) {
        if(!(key instanceof String s))
            throw new IllegalArgumentException("key must be a string");
        switch (s) {
            case "length" -> {
                return new Atom(BigInteger.valueOf(path.getLength()));
            }
            case "weight" -> {
                return new Atom(BigDecimal.valueOf(path.getWeight()));
            }
            case "start" -> {
                return path.getStartVertex();
            }
            case "end" -> {
                return path.getEndVertex();
            }
            case "vertices" -> {
                return new Atom(path.getVertexList());
            }
            default -> {
                throw new IllegalArgumentException("unknown key: " + key);
            }
        }
    }

    @Override
    public String toDisplayString() {
        return "graph:path of length " + path.getLength();
    }

    @Override
    public String typeName() {
        return "graph:path";
    }
}
