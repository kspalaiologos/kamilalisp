package palaiologos.kamilalisp.runtime.dataformat;

import org.apache.commons.text.StringEscapeUtils;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.List;

public class XmlEscape extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String str = args.get(0).getString();
        return new Atom(StringEscapeUtils.escapeXml11(str));
    }

    @Override
    protected String name() {
        return "xml:escape";
    }
}
