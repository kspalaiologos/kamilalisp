package palaiologos.kamilalisp.runtime.xml;

import org.w3c.dom.Document;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;

public class XMLDocument implements Userdata {
    private final Document dom;

    public XMLDocument(Document dom) {
        this.dom = dom;
        this.dom.normalizeDocument();
    }

    @Override
    public Atom field(Object key) {
        if(key instanceof String) {
            switch ((String) key) {
                case "doctype" -> {
                    if (dom.getDoctype() == null)
                        return Atom.NULL;
                    return new Atom(dom.getDoctype().toString());
                }
                case "root" -> {
                    return new Atom(new XMLNode(dom.getDocumentElement()));
                }
                default -> {
                    throw new IllegalArgumentException("XMLDocument has no field " + key);
                }
            }
        } else {
            throw new IllegalArgumentException("XMLDocument field must be a string");
        }
    }

    @Override
    public int compareTo(Userdata other) {
        return Integer.compare(dom.hashCode(), other.hashCode());
    }

    @Override
    public boolean equals(Userdata other) {
        if(other instanceof XMLDocument) {
            return dom.isEqualNode(((XMLDocument) other).dom);
        } else {
            return false;
        }
    }

    @Override
    public String toDisplayString() {
        return "XMLDocument " + dom.getDoctype();
    }

    @Override
    public String typeName() {
        return "XMLDocument";
    }

    @Override
    public boolean coerceBoolean() {
        return true;
    }
}
