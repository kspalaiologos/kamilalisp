package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Type;

import java.util.List;

public class Prototype {
    public static Atom getPrototype(List<Atom> list) {
        Atom prototype;

        if(list.isEmpty())
            prototype = Atom.NULL;
        else if(list.get(0).isNumeric())
            prototype = Atom.FALSE;
        else if(list.get(0).getType() == Type.STRING)
            prototype = new Atom("");
        else
            prototype = Atom.NULL;

        return prototype;
    }
}
