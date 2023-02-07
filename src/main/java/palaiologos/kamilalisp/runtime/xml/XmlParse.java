package palaiologos.kamilalisp.runtime.xml;

import com.google.common.io.CharSource;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.xml.sax.SAXException;
import palaiologos.kamilalisp.atom.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class XmlParse extends PrimitiveFunction implements Lambda {
    private Atom xmlToList(Node n) {
        List<Atom> data = new ArrayList<>();
        data.add(new Atom(n.getNodeName()));
        if(n.getChildNodes().getLength() > 0 && n.getChildNodes().item(0).getNodeType() == Node.TEXT_NODE) {
            data.add(new Atom(n.getChildNodes().item(0).getNodeValue()));
            if (n.getAttributes() != null) {
                List<Atom> attribs = new ArrayList<>();
                for (int i = 0; i < n.getAttributes().getLength(); i++) {
                    Node attr = n.getAttributes().item(i);
                    attribs.add(new Atom(List.of(new Atom(attr.getNodeName()), new Atom(attr.getNodeValue()))));
                }
                data.add(new Atom(attribs));
            } else {
                data.add(Atom.NULL);
            }
            List<Atom> children = new ArrayList<>();
            for (int i = 1; i < n.getChildNodes().getLength(); i++) {
                Node child = n.getChildNodes().item(i);
                children.add(xmlToList(child));
            }
            data.add(new Atom(children));
        } else {
            data.add(new Atom(n.getNodeValue() == null ? "" : n.getNodeValue()));
            if (n.getAttributes() != null) {
                List<Atom> attribs = new ArrayList<>();
                for (int i = 0; i < n.getAttributes().getLength(); i++) {
                    Node attr = n.getAttributes().item(i);
                    attribs.add(new Atom(List.of(new Atom(attr.getNodeName()), new Atom(attr.getNodeValue()))));
                }
                data.add(new Atom(attribs));
            } else {
                data.add(Atom.NULL);
            }
            List<Atom> children = new ArrayList<>();
            for (int i = 0; i < n.getChildNodes().getLength(); i++) {
                Node child = n.getChildNodes().item(i);
                children.add(xmlToList(child));
            }
            data.add(new Atom(children));
        }
        return new Atom(data);
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Atom arg = args.get(0);
        String xmldata = null;

        if(arg.getType() == Type.LIST) {
            // Assume a buffer.
            byte[] data = new byte[arg.getList().size()];
            for (int i = 0; i < arg.getList().size(); i++)
                data[i] = arg.getList().get(i).getInteger().byteValueExact();
            xmldata = new String(data, StandardCharsets.UTF_8);

        } else if(arg.getType() == Type.STRING) {
            // Assume a string.
            xmldata = arg.getString();
        } else {
            throw new RuntimeException("xml:parse not defined for: " + arg.getType());
        }

        // Parse the XML.
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        try {
            DocumentBuilder db = factory.newDocumentBuilder();
            InputStream targetStream =
                    CharSource.wrap(xmldata).asByteSource(StandardCharsets.UTF_8).openStream();
            Document dom = db.parse(targetStream);
            Atom result = xmlToList(dom.getDocumentElement());
            targetStream.close();
            return result;
        } catch (ParserConfigurationException | IOException | SAXException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "xml:parse";
    }
}
