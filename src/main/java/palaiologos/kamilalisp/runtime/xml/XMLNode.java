package palaiologos.kamilalisp.runtime.xml;

import org.pcollections.HashTreePMap;
import org.w3c.dom.Node;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Callable;
import palaiologos.kamilalisp.atom.Userdata;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class XMLNode implements Userdata {
    private final Node node;

    public XMLNode(Node item) {
        this.node = item;
        this.node.normalize();
    }

    @Override
    public Atom field(Object key) {
        if(key instanceof Integer) {
            return new Atom(new XMLNode(node.getChildNodes().item((Integer) key)));
        } else if(key instanceof String) {
            switch ((String) key) {
                case "name" -> {
                    return new Atom(node.getNodeName());
                }
                case "value" -> {
                    return new Atom(node.getNodeValue() == null ? "" : node.getNodeValue());
                }
                case "parent" -> {
                    return new Atom(new XMLNode(node.getParentNode()));
                }
                case "children" -> {
                    List<Atom> children = new ArrayList<>();
                    for(int i = 0; i < node.getChildNodes().getLength(); i++) {
                        children.add(new Atom(new XMLNode(node.getChildNodes().item(i))));
                    }
                    return new Atom(children);
                }
                case "attributes" -> {
                    HashMap<Atom, Atom> attrData = new HashMap<>();
                    for(int i = 0; i < node.getAttributes().getLength(); i++) {
                        attrData.put(new Atom(node.getAttributes().item(i).getNodeName()), new Atom(node.getAttributes().item(i).getNodeValue()));
                    }
                    return new Atom(new HashMapUserData(HashTreePMap.from(attrData)));
                }
                default -> {
                    throw new IllegalArgumentException("XMLNode has no field " + key);
                }
            }
        } else {
            throw new IllegalArgumentException("XMLNode field must be a string or integer");
        }
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
