package palaiologos.kamilalisp.runtime.data.xml;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class XmlWrite extends PrimitiveFunction implements Lambda {
    private Element genXmlNode(Document dom, List<Atom> a) {
        String nodeName = a.get(0).getString();
        Element node = dom.createElement(nodeName);
        String value = a.get(1).getString();
        if (value != null) {
            node.appendChild(dom.createTextNode(value));
        }
        List<Atom> attribs = a.get(2).getList();
        for (Atom attrib : attribs) {
            List<Atom> attribData = attrib.getList();
            String attribName = attribData.get(0).getString();
            String attribValue = attribData.get(1).getString();
            node.setAttribute(attribName, attribValue);
        }
        List<Atom> children = a.get(3).getList();
        for (Atom child : children) {
            Node childNode = genXmlNode(dom, child.getList());
            node.appendChild(childNode);
        }
        return node;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        try {
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document dom = db.newDocument();
            Element rootElem = genXmlNode(dom, args.get(0).getList());
            dom.appendChild(rootElem);
            Transformer tr = TransformerFactory.newInstance().newTransformer();
            tr.setOutputProperty(OutputKeys.INDENT, "yes");
            tr.setOutputProperty(OutputKeys.METHOD, "xml");
            tr.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
            tr.setOutputProperty(OutputKeys.DOCTYPE_SYSTEM, "roles.dtd");
            tr.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            tr.transform(new DOMSource(dom), new StreamResult(baos));
            return new Atom(baos.toString(StandardCharsets.UTF_8));
        } catch (ParserConfigurationException | TransformerException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "xml:write";
    }
}
