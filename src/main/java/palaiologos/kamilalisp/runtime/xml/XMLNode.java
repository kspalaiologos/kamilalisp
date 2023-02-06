package palaiologos.kamilalisp.runtime.xml;

import org.w3c.dom.Node;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Callable;
import palaiologos.kamilalisp.atom.Userdata;

import java.math.BigDecimal;
import java.util.List;

public class XMLNode implements Userdata {
    private final Node node;

    public XMLNode(Node item) {
        this.node = item;
        this.node.normalize();
    }

    @Override
    public Atom field(Object key) {
        return null;
    }

    @Override
    public int compareTo(Userdata other) {
        return Integer.compare(node.hashCode(), other.hashCode());
    }

    @Override
    public boolean equals(Userdata other) {
        if(other instanceof XMLNode) {
            return node.isEqualNode(((XMLNode) other).node);
        } else {
            return false;
        }
    }

    @Override
    public String toDisplayString() {
        return "XMLNode " + node.getNodeName();
    }

    @Override
    public String typeName() {
        return "XMLNode";
    }

    @Override
    public boolean coerceBoolean() {
        return true;
    }

    @Override
    public int hashCode() {
        return node.hashCode();
    }
}
